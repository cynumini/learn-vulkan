const std = @import("std");
const c = @import("c");

pub extern fn lv_glm_test() void;

pub fn main(init: std.process.Init) !void {
    _ = init;

    _ = c.glfwInit();
    defer c.glfwTerminate();

    c.glfwWindowHint(c.GLFW_CLIENT_API, c.GLFW_NO_API);

    const window = c.glfwCreateWindow(800, 600, "Vulkan window", null, null).?;
    defer window.glfwDestroyWindow();

    var extensionCount: u32 = 0;
    _ = c.vkEnumerateInstanceExtensionProperties(null, &extensionCount, null);

    std.debug.print("{} extensions supported\n", .{extensionCount});

    lv_glm_test();

    while(window.glfwWindowShouldClose() == 0) {
        c.glfwPollEvents();
    }

}
