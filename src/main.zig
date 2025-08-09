const std = @import("std");
const math = @import("math.zig");
const vk = @import("vulkan.zig");
const HelloTriangleApplication = @import("hello_triangle_application.zig");

pub fn main() !void {
    var app: HelloTriangleApplication = .{};

    app.run();
    // _ = glfw.init();
    // defer glfw.deinit();
    //
    // const window = glfw.Window.init(800, 600, "Vulkan window", .{ .client_api = .no_api });
    // defer window.deinit();
    //
    // var extension_count: u32 = undefined;
    // _ = vk.enumerateInstanceExtensionProperties(null, &extension_count, null);
    //
    // std.debug.print("{} extensions supported\n", .{extension_count});
    //
    // const matrix: math.Mat4 = undefined;
    // const vec: math.Vec4 = undefined;
    // const @"test" = math.multiply(matrix, vec);
    // _ = @"test";
    //
    // while (!window.shouldClose()) {
    //     glfw.pollEvents();
    // }
}
