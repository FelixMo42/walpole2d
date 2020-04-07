import math

type Vector = ref object
    x, y: int

type Circle = ref object
    position: Vector
    radius: int

type Entity = ref object
    center: Circle
    velocity: Vector

proc `+` (a: Vector, b: Vector): Vector =
    Vector(x: a.x + b.x, y: a.y + b.y)

proc `-` (a: Vector, b: Vector): Vector =
    Vector(x: a.x - b.x, y: a.y - b.y)

proc distanceSqr(a: Vector, b: Vector): int =
    (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2

proc isMoving(entity: Entity): bool =
    entity.velocity.x == 0 and entity.velocity.y == 0

proc moveEntity(entity: Entity) =
    entity.center.position.x += entity.velocity.x
    entity.center.position.y += entity.velocity.y

#

proc collidesWith(a: Entity, b: Entity): bool = 
    0 > (a.center.radius + b.center.radius) ^ 2

proc limitMovement(a: Entity, b: Entity) =
    discard "hi"

#

proc handleEntityBundle(bundle: seq[Entity]) =
    if (bundle.len() == 1):
        moveEntity( bundle[0] )
        return

    var done = false

    while not done:
        done = true

        for i in 0 .. < bundle.len() - 1:
            for j in i + 1 .. < bundle.len():
                if collidesWith( bundle[i], bundle[j] ):
                    limitMovement( bundle[i], bundle[j] )
                    done = false

proc couldCollideWith(a: Entity, b: Entity): bool =
    (
        (a.velocity.x + b.velocity.x + a.center.radius + b.center.radius) ^ 2 +
        (a.velocity.y + b.velocity.y + a.center.radius + b.center.radius) ^ 2
    ) > distanceSqr(a.center.position, b.center.position)

proc update(entities: var seq[Entity]) =
    var bundleStart = 0

    while bundleStart < entities.len():
        var bundleEnd = bundleStart

        for i in bundleStart..bundleEnd:
            for j in  (bundleEnd + 1)..(entities.len() - 1):
                if couldCollideWith(entities[i], entities[j]):
                    # we have a new entity to add to our bundle, increment the count by one
                    bundleEnd += 1

                    echo "i: ", i, "j: ", j, "end: ", bundleEnd

                    # flip the whatever is at the end of the bundle with what we just found
                    var outher = entities[bundleEnd]
                    entities[bundleEnd] = entities[j]
                    entities[j] = outher

        # deal with the small bundle of entities
        handleEntityBundle( entities[bundleStart..bundleEnd] )

        # move up to where the last bundle ended
        bundleStart = bundleEnd + 1


########################################################################

var entities = @[
    Entity(
        center: Circle(
            position: Vector(x: 0, y: 15),
            radius: 10
        ),
        velocity: Vector(x: 0, y: 5)
    ),

    Entity(
        center: Circle(
            position: Vector(x: 0, y: 0),
            radius: 10
        ),
        velocity: Vector(x: 0, y: -5)
    )
]

update(entities)