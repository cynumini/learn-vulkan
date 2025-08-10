const std = @import("std");
const builtin = @import("builtin");

const glfw = @import("glfw.zig");
const vk = @import("vulkan.zig");

const Self = @This();

const width = 800;
const height = 600;

const validation_layers = [_][*c]const u8{
    "VK_LAYER_KHRONOS_validation",
};
const enable_validation_layers = builtin.mode == .Debug;

pub fn run(self: *Self) !void {
    self.initWindow();
    try self.initVulkan();
    self.mainLoop();
    self.cleanup();
}

allocator: std.mem.Allocator,
window: *glfw.Window = undefined,

instance: vk.Instance = undefined,
debug_messenger: vk.DebugUtilsMessengerEXT = undefined,

fn initWindow(self: *Self) void {
    glfw.init();

    self.window = glfw.Window.init(width, height, "Vulkan", .{
        .client_api = .no_api,
        .resizable = false,
    });
}

fn initVulkan(self: *Self) !void {
    try self.createInstance();
    try self.setupDebugMessenger();
}

fn mainLoop(self: *Self) void {
    while (!self.window.shouldClose()) {
        glfw.pollEvents();
        break;
    }
}

fn cleanup(self: *Self) void {
    if (enable_validation_layers) {
        vk.destroyDebugUtilsMessengerEXT(self.instance, self.debug_messenger, null);
    }

    vk.destroyInstance(self.instance, null);

    self.window.deinit();

    glfw.deinit();
}

fn createInstance(self: *Self) !void {
    if (enable_validation_layers and !try self.checkValidationLayerSupport()) {
        return error.ValidationLayersNotAvailable;
    }

    const app_info = vk.ApplicationInfo{
        .sType = vk.structure_type_application_info,
        .pApplicationName = "Hello Triangle",
        .applicationVersion = vk.makeVersion(1, 0, 0),
        .pEngineName = "No Engine",
        .engineVersion = vk.makeVersion(1, 0, 0),
        .apiVersion = vk.api_version_1_0,
    };

    var extensions = try self.getRequiredExtensions();
    defer extensions.deinit();

    var create_info = vk.InstanceCreateInfo{
        .sType = vk.structure_type_instance_create_info,
        .pApplicationInfo = &app_info,
        .enabledExtensionCount = @intCast(extensions.items.len),
        .ppEnabledExtensionNames = @ptrCast(extensions.items),
        .enabledLayerCount = if (enable_validation_layers) validation_layers.len else 0,
        .ppEnabledLayerNames = &validation_layers,
    };

    const debugCreateInfo = getDebugMessengerCreateInfo();
    if (enable_validation_layers) {
        create_info.pNext = &debugCreateInfo;
    } else {
        create_info.pNext = null;
    }

    if (vk.createInstance(&create_info, null, &self.instance) != vk.success) {
        return error.FailedToCreateInstance;
    }
}

fn getDebugMessengerCreateInfo() vk.DebugUtilsMessengerCreateInfoEXT {
    return .{
        .sType = vk.structure_type_debug_utils_messenger_create_info_ext,
        .messageSeverity = vk.debug_utils_message_severity_verbose_bit_ext |
            vk.debug_utils_message_severity_warning_bit_ext |
            vk.debug_utils_message_severity_error_bit_ext,
        .messageType = vk.debug_utils_message_type_general_bit_ext |
            vk.debug_utils_message_type_validation_bit_ext |
            vk.debug_utils_message_type_performance_bit_ext,
        .pfnUserCallback = debugCallback,
        .pUserData = null,
    };
}

fn setupDebugMessenger(self: *Self) !void {
    if (!enable_validation_layers) return;

    const create_info = getDebugMessengerCreateInfo();

    if (vk.createDebugUtilsMessengerEXT(self.instance, &create_info, null, &self.debug_messenger) != vk.success) {
        return error.FailedToSetUpDebugMessenger;
    }
}

/// Deinitialize with `deinit` or use `toOwnedSlice`.
fn getRequiredExtensions(self: *Self) !std.ArrayList([*c]const u8) {
    var glfw_extension_count: u32 = 0;
    const glfw_extensions = glfw.getRequiredInstanceExtensions(&glfw_extension_count);

    var extensions: std.ArrayList([*c]const u8) = .init(self.allocator);
    try extensions.appendSlice(glfw_extensions[0..glfw_extension_count]);

    if (enable_validation_layers) {
        try extensions.append(vk.ext_debug_utils_extension_name);
    }

    return extensions;
}

fn checkValidationLayerSupport(self: *Self) !bool {
    var layer_count: u32 = undefined;
    _ = vk.enumerateInstanceLayerProperties(&layer_count, null);

    const available_layers = try self.allocator.alloc(vk.LayerProperties, layer_count);
    defer self.allocator.free(available_layers);

    _ = vk.enumerateInstanceLayerProperties(&layer_count, @ptrCast(available_layers));

    for (validation_layers) |layer_name| {
        var layer_found = false;

        for (available_layers) |layer_properties| {
            const name: [*c]const u8 = &layer_properties.layerName;
            if (std.mem.eql(u8, std.mem.span(layer_name), std.mem.span(name))) {
                layer_found = true;
                break;
            }
        }

        if (!layer_found) {
            return false;
        }
    }

    return true;
}

fn debugCallback(message_severity: vk.DebugUtilsMessageSeverityFlagBitsEXT, message_type: vk.DebugUtilsMessageTypeFlagsEXT, callback_data: [*c]const vk.DebugUtilsMessengerCallbackDataEXT, user_data: ?*anyopaque) callconv(.c) vk.Bool32 {
    _ = message_severity;
    _ = message_type;
    _ = user_data;
    std.debug.print("validation layer: {s}\n", .{callback_data[0].pMessage});
    return @intFromBool(false);
}
