pub const c = @cImport({
    @cDefine("GLFW_INCLUDE_VULKAN", {});
    @cInclude("GLFW/glfw3.h");
});

const ABI = struct {
    extern fn glfwCreateWindow(width: c_int, height: c_int, title: [*c]const u8, monitor: ?*Monitor, share: ?*Window) ?*Window;
    extern fn glfwDestroyWindow(window: ?*Window) void;
    extern fn glfwWindowHint(hint: c_int, value: c_int) void;
    extern fn glfwWindowShouldClose(window: ?*Window) c_int;
};

/// Context client API hint and attribute.
const ClientApi = enum(i32) {
    no_api = c.GLFW_NO_API,
    opengl_api = c.GLFW_OPENGL_API,
    opengl_es_api = c.GLFW_OPENGL_ES_API,

    pub fn set(self: ClientApi) void {
        ABI.glfwWindowHint(c.GLFW_CLIENT_API, @intFromEnum(self));
    }
};

/// Opaque window object.
pub const Window = opaque {
    /// Creates a window and its associated context.
    pub fn init(width: i32, height: i32, title: []const u8, options: struct {
        monitor: ?*Monitor = null,
        share: ?*Window = null,
        client_api: ClientApi = .no_api,
        resizable: bool = false,
    }) *Window {
        options.client_api.set(); // client_api
        ABI.glfwWindowHint(c.GLFW_RESIZABLE, @intFromBool(options.resizable)); // resizable
        return ABI.glfwCreateWindow(
            width,
            height,
            title.ptr,
            options.monitor,
            options.share,
        ) orelse unreachable; // TODO: Handle errors
    }
    /// Destroys the specified window and its context.
    pub fn deinit(window: *Window) void {
        ABI.glfwDestroyWindow(window);
    }
    /// Checks the close flag of the specified window.
    pub fn shouldClose(window: *Window) bool {
        return ABI.glfwWindowShouldClose(window) != 0;
    }
};
/// Opaque monitor object.
pub const Monitor = opaque {};
/// Initializes the GLFW library.
pub fn init() void {
    if (c.glfwInit() == c.GLFW_FALSE) unreachable;
}
/// Terminates the GLFW library.
pub const deinit = c.glfwTerminate;
/// Processes all pending events.
pub const pollEvents = c.glfwPollEvents;
/// Returns the Vulkan instance extensions required by GLFW.
pub const getRequiredInstanceExtensions = c.glfwGetRequiredInstanceExtensions;
