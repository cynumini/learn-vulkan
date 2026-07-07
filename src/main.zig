const std = @import("std");
const vk = @import("vulkan.zig");
const glfw = @import("glfw.zig");
const m = @import("m.zig");

pub fn main(init: std.process.Init) !void {
    _ = init;

    _ = glfw.init();
    defer glfw.terminate();

    glfw.windowHints(.{
        .resizable = false,
        .client_api = .no_api,
    });

    const window = glfw.createWindow(800, 600, "Vulkan window", null, null).?;
    defer window.destroy();

    while (!window.shouldClose()) {
        glfw.pollEvents();
    }
}

test {
    std.testing.refAllDecls(@This());
}
