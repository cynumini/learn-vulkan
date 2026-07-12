const std = @import("std");
const vk = @import("vulkan.zig");
const glfw = @import("glfw.zig");
const m = @import("m.zig");

pub fn main(init: std.process.Init) !void {
    _ = init;

    std.debug.assert(glfw.init());
    defer glfw.deint();

    glfw.windowHints(.{
        .resizable = false,
        .client_api = .no_api,
    });

    const window = glfw.Window.init(800, 600, "Vulkan window", null, null).?;
    defer window.deinit();

    const app_info = vk.ApplicationInfo{
        .application_name = "Hello Triangle",
        .application_version = .make(1, 0, 0),
        .engine_name = "No Engine",
        .engine_version = .make(1, 0, 0),
        .api_version = .@"1_0",
    };

    const extensions = glfw.getRequiredInstanceExtensions();

    const create_info = vk.InstanceCreateInfo{
        .application_info = &app_info,
        .enabled_extension_count = @intCast(extensions.len),
        .enabled_extension_names = extensions.ptr,
    };

    var instance: vk.Instance = .init(&create_info, null);
    defer instance.deinit(null);

    while (!window.shouldClose()) {
        glfw.pollEvents();
        break;
    }
}

test {
    std.testing.refAllDecls(@This());
}
