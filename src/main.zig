const std = @import("std");
const vk = @import("vulkan.zig");
const glfw = @import("glfw.zig");
const m = @import("m.zig");

pub fn main(init: std.process.Init) !void {
    _ = init;

    _ = glfw.init();
    defer glfw.terminate();

    glfw.windowHint(.client_api, .no_api);

    const window = glfw.createWindow(800, 600, "Vulkan window", null, null).?;
    defer window.destroy();

    var extensionCount: u32 = 0;
    _ = vk.enumerateInstanceExtensionProperties(null, &extensionCount, null);

    std.debug.print("{} extensions supported\n", .{extensionCount});

    const matrix: m.Mat4 = undefined;
    const vec: m.Vec4 = undefined;
    const @"test" = matrix.mulVec4(vec);
    _ = @"test";

    while (!window.shouldClose()) {
        glfw.pollEvents();
    }
}

test {
    std.testing.refAllDecls(@This());
}
