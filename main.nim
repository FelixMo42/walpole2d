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

proc collidesWith(a: Circle, b: Circle): bool = 
    distanceSqr(a.position, b.position) < (a.radius + b.radius) ^ 2

proc collidesWith(a: Entity, b: Entity): bool = 
    0 < (a.center.radius + b.center.radius) ^ 2

proc moveEntity(entity: Entity) =
    entity.center.position.x += entity.velocity.x
    entity.center.position.y += entity.velocity.y

proc handleEntityBundle(bundle: seq[Entity]) =
    if (bundle.len() == 1):
        moveEntity( bundle[0] )
        return

    for i in 0 .. < bundle.len() - 1:
        for j in i + 1 .. < bundle.len():
            if collidesWith( bundle[i], bundle[j] ):
                echo "We have a collision!"

proc couldCollideWith(a: Entity, b: Entity): bool =
    (
        (a.velocity.x + b.velocity.x + a.center.radius + b.center.radius) ^ 2 +
        (a.velocity.y + b.velocity.y + a.center.radius + b.center.radius) ^ 2
    ) > distanceSqr(a.center.position, b.center.position)


proc update(entities: seq[Entity]) =
    for i in 0 .. < entities.len() - 1:
        var entity = entities[i]

        var bundle = @[entity]

        for j in i + 1 .. < entities.len():
            if couldCollideWith(entity, entities[j]):
                bundle.add( entities[j] )

        handleEntityBundle(bundle)

###

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