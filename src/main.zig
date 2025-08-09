const std = @import("std");
const math = @import("math.zig");
const glfw = @import("glfw.zig");
const vk = @import("vulkan.zig");

pub fn main() !void {
    _ = glfw.init();
    defer glfw.terminate();

    glfw.windowHint(glfw.client_api, glfw.no_api);
    const window = glfw.createWindow(800, 600, "Vulkan window", null, null);
    defer glfw.destroyWindow(window);

    var extension_count: u32 = undefined;
    _ = vk.enumerateInstanceExtensionProperties(null, &extension_count, null);

    std.debug.print("{} extensions supported\n", .{extension_count});

    const matrix: math.Mat4 = undefined;
    const vec: math.Vec4 = undefined;
    const @"test" = math.matNMulVec(matrix, vec);
    _ = @"test";

    while (!glfw.windowShouldClose(window)) {
        glfw.pollEvents();
    }
}
