const std = @import("std");
const rl = @import("raylib");

const THICKNESS = 3.0;

const Vector2 = rl.Vector2;

const State = struct {
    shipPos: Vector2,
};

var state: State = {};

fn drawLine(origin: Vector2, scale: f32, points: []Vector2) void {
    // transform(point)
    const Transformer = struct {
        fn apply(p: Vector2) Vector2 {
            return Vector2.init(p.x + origin.x * scale, p.y + origin.y * scale);
        }
    };

    for (0..points.len) |i| {
        rl.drawLineEx(
            Transformer.apply(points[i]),
            Transformer.apply(points[(i + 1) % points.len]),
            THICKNESS,
            .white,
        );
    }
}

// fn drawShip(pos: Vector2) void {
//     _ = pos;
// }

pub fn main() !void {
    std.debug.print("Hello, world!\n", .{});
    rl.setConfigFlags(.{
        .window_highdpi = true, // This is required for the display on my mac to work correctly
        // .window_resizable = true,
    });
    rl.initWindow(640 * 2, 480 * 2, "Asteroids Replica");
    rl.setWindowPosition(100, 100);
    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);

        const a = Vector2{ .x = 10, .y = 10 };
        const b = Vector2{ .x = 20, .y = 20 };
        rl.drawLineV(a, b, rl.Color.white);
    }
}
