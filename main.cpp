#include <vector>
#include <math.h>
#include <stdio.h>
#include <iostream>

typedef struct {
    int x, y;
} Vector2d;

typedef struct {
    Vector2d position;
    int radius;
} Circle;

typedef struct {
    Circle body;
    Vector2d velocity;
} Entity;

int distance(Vector2d a, Vector2d b) {
    return pow(a.x - b.x, 2) + pow(a.y - b.y, 2);
}

bool collides(Circle a, Circle b) {
    return distance(a.position, b.position) < pow(a.radius + b.radius, 2);
}

bool couldCollide(Entity a, Entity b) {
    int radius = pow(a.velocity.x + b.velocity.x, 2) + pow(a.velocity.y + b.velocity.y, 2)
    return 
}

int main() {
    std::vector<Entity> circles;

    circles.push_back({{{0, 1}, 12}, {5, 10}});
    circles.push_back({{{1, 1}, 12}, {10, 10}});
    
    for (size_t i = 0; i < circles.size() - 1; ++i) {
        Entity entity = circles[i];

        for (size_t j = i + 1; j < circles.size(); ++j) {
            
        }
    }

    return 0;
}