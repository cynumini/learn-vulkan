const std = @import("std");

const glfw = @import("glfw.zig");
const vk = @import("vulkan.zig");

const Self = @This();

const width = 800;
const height = 600;

pub fn run(self: *Self) !void {
    self.initWindow();
    try self.initVulkan();
    self.mainLoop();
    self.cleanup();
}

window: *glfw.Window = undefined,

instance: vk.Instance = undefined,

fn initWindow(self: *Self) void {
    glfw.init();

    self.window = glfw.Window.init(width, height, "Vulkan", .{
        .client_api = .no_api,
        .resizable = false,
    });
}

fn initVulkan(self: *Self) !void {
    try self.createInstance();
}

fn mainLoop(self: *Self) void {
    while (!self.window.shouldClose()) {
        glfw.pollEvents();
    }
}

fn cleanup(self: *Self) void {
    vk.destroyInstance(self.instance, null);

    self.window.deinit();

    glfw.deinit();
}

fn createInstance(self: *Self) !void {
    const app_info = vk.ApplicationInfo{
        .sType = vk.structure_type_application_info,
        .pApplicationName = "Hello Triangle",
        .applicationVersion = vk.makeVersion(1, 0, 0),
        .pEngineName = "No Engine",
        .engineVersion = vk.makeVersion(1, 0, 0),
        .apiVersion = vk.api_version_1_0,
    };

    var glfw_extension_count: u32 = 0;
    const glfw_extensions = glfw.getRequiredInstanceExtensions(&glfw_extension_count);

    const create_info = vk.InstanceCreateInfo{
        .sType = vk.structure_type_instance_create_info,
        .pApplicationInfo = &app_info,
        .enabledExtensionCount = glfw_extension_count,
        .ppEnabledExtensionNames = glfw_extensions,
        .enabledLayerCount = 0,
    };

    if (vk.createInstance(&create_info, null, &self.instance) != vk.success) {
        return error.FailedToCreateInstance;
    }
}
