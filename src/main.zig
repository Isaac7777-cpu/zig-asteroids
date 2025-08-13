const std = @import("std");
const rl = @import("raylib");
const rlm = rl.math;
const Vector2 = rl.Vector2;

const THICKNESS = 3.0;

// const Vector2 = rl.Vector2;

const State = struct {
    shipPos: Vector2,
};

var state: State = {};

fn drawLines(origin: Vector2, scale: f32, points: []const Vector2) void {
    // transform(point)
    const Transformer = struct {
        origin: Vector2,
        scale: f32,

        fn apply(self: @This(), p: Vector2) Vector2 {
            return rlm.vector2Add(rlm.vector2Scale(p, self.scale), self.origin);
        }
    };

    const t = Transformer{
        .origin = origin,
        .scale = scale,
    };

    for (0..points.len) |i| {
        rl.drawLineEx(
            t.apply(points[i]),
            t.apply(points[(i + 1) % points.len]),
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

        // const a = Vector2{ .x = 10, .y = 10 };
        // const b = Vector2{ .x = 100, .y = 100 };
        // rl.drawLineV(a, b, rl.Color.white);

        drawLines(
            Vector2.init(100, 100),
            100,
            &[_]Vector2{
                Vector2.init(-0.4, -0.5),
                Vector2.init(0.0, 0.5),
                Vector2.init(0.4, -0.5),
                Vector2.init(0.3, -0.4),
                Vector2.init(-0.3, -0.4),
            },
        );
    }
}
