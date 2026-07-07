extern fn glfwInit() c_int;
pub const init = glfwInit;
extern fn glfwTerminate() void;
pub const terminate = glfwTerminate;
extern fn glfwWindowHint(hint: c_int, value: c_int) void;
const WindowHints = struct {
    resizable: ?bool,
    client_api: ?enum(c_int) {
        no_api = 0,
    },
};
pub fn windowHints(window_hints: WindowHints) void {
    if (window_hints.resizable) |resizable| glfwWindowHint(0x00020003, @intFromBool(resizable));
    if (window_hints.client_api) |client_api| glfwWindowHint(0x00022001, @intFromEnum(client_api));
}
pub const Monitor = opaque {};
pub const Window = opaque {
    extern fn glfwWindowShouldClose(window: *Window) bool;
    pub const shouldClose = glfwWindowShouldClose;
    extern fn glfwDestroyWindow(window: *Window) void;
    pub const destroy = glfwDestroyWindow;
};
extern fn glfwCreateWindow(width: c_int, height: c_int, title: [*c]const u8, monitor: ?*Monitor, share: ?*Window) ?*Window;
pub const createWindow = glfwCreateWindow;
extern fn glfwPollEvents() void;
pub const pollEvents = glfwPollEvents;
