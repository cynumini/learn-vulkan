const glfw = @import("glfw.zig");

const Self = @This();

const width = 800;
const height = 600;

window: *glfw.Window = undefined,

pub fn run(self: *Self) void {
    self.initWindow();
    initVulkan();
    self.mainLoop();
    self.cleanup();
}

fn initWindow(self: *Self) void {
    glfw.init();

    self.window = glfw.Window.init(width, height, "Vulkan", .{
        .client_api = .no_api,
        .resizable = false,
    });
}

fn initVulkan() void {}

fn mainLoop(self: *Self) void {
    while (!self.window.shouldClose()) {
        glfw.pollEvents();
    }
}

fn cleanup(self: *Self) void {
    self.window.deinit();

    glfw.deinit();
}
