extern fn glfwInit() c_int;
pub const init = glfwInit;
extern fn glfwTerminate() void;
pub const terminate = glfwTerminate;
const WindowHint = enum(c_int) {
    client_api = 0x00022001,
};
const WindowHintValue = enum(c_int) {
    no_api = 0,
};
extern fn glfwWindowHint(hint: WindowHint, value: WindowHintValue) void;
pub const windowHint = glfwWindowHint;
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
