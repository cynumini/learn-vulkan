const std = @import("std");
const vk = @import("vulkan.zig");
const glfw = @import("glfw.zig");
const m = @import("m.zig");
const builtin = @import("builtin");

const validation_layers = [_][*:0]const u8{"VK_LAYER_KHRONOS_validation"};

fn checkValidationLayerSupport(gpa: std.mem.Allocator) !bool {
    const available_layers = try vk.enumerateInstanceLayerProperties(gpa);
    defer gpa.free(available_layers);
    blk: for (validation_layers) |layer_name| {
        const validation_layer_name = std.mem.span(layer_name);
        for (available_layers) |layer_properties| {
            const available_layer_name = std.mem.sliceTo(&layer_properties.layer_name, 0);
            if (std.mem.eql(u8, validation_layer_name, available_layer_name)) continue :blk;
        }
        return false;
    }
    return true;
}

fn debugCallback(
    message_severity: vk.DebugUtilsMessageSeverityFlagBitsEXT,
    message_types: vk.DebugUtilsMessageTypeFlagsEXT,
    callback_data: *const vk.DebugUtilsMessengerCallbackDataEXT,
    user_data: ?*anyopaque,
) callconv(.c) vk.Bool32 {
    _ = message_severity;
    _ = message_types;
    _ = user_data;
    std.log.info("validation layer: {s}", .{callback_data.message});
    return .false;
}

pub fn main(init: std.process.Init) !void {
    std.debug.assert(glfw.init());
    defer glfw.deint();

    glfw.windowHints(.{
        .resizable = false,
        .client_api = .no_api,
    });

    const window = glfw.Window.init(800, 600, "Vulkan window", null, null).?;
    defer window.deinit();

    const enable_validation_layers = builtin.mode == .Debug;

    if (enable_validation_layers and !try checkValidationLayerSupport(init.gpa)) {
        return error.ValidationLayerNotAvailable;
    }

    const app_info = vk.ApplicationInfo{
        .application_name = "Hello Triangle",
        .application_version = .make(1, 0, 0),
        .engine_name = "No Engine",
        .engine_version = .make(1, 0, 0),
        .api_version = .@"1_0",
    };

    var extensions = std.ArrayList([*:0]const u8).empty;
    defer extensions.deinit(init.gpa);
    try extensions.appendSlice(init.gpa, glfw.getRequiredInstanceExtensions());
    try extensions.append(init.gpa, vk.ext_debug_utils_extension_name);

    var create_info = vk.InstanceCreateInfo{
        .application_info = &app_info,
        .enabled_extension_count = @intCast(extensions.items.len),
        .enabled_extension_names = extensions.items.ptr,
    };

    var debug_create_info = vk.DebugUtilsMessengerCreateInfoEXT{};
    if (enable_validation_layers) {
        create_info.enabled_layer_count = validation_layers.len;
        create_info.enabled_layer_names = &validation_layers;

        debug_create_info.message_severity = .{
            .verbose = true,
            .warning = true,
            .@"error" = true,
        };
        debug_create_info.message_type = .{
            .general = true,
            .validation = true,
            .performance = true,
        };
        debug_create_info.user_callback = debugCallback;

        create_info.next = &debug_create_info;
    } else {
        create_info.enabled_layer_count = 0;
        create_info.next = null;
    }

    var instance: vk.Instance = .init(&create_info, null);
    defer instance.deinit(null);

    var debug_messenger: ?vk.DebugUtilsMessengerEXT = null;
    if (enable_validation_layers) {
        debug_messenger = try vk.CreateDebugUtilsMessengerEXT(instance, &debug_create_info, null);
    }
    defer if (debug_messenger) |db| vk.DestroyDebugUtilsMessengerEXT(instance, db, null);

    while (!window.shouldClose()) {
        glfw.pollEvents();
        break;
    }
}

test {
    std.testing.refAllDecls(@This());
}
