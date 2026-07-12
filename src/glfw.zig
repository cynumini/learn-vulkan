pub const Monitor = opaque {}; // 1391

pub const Window = opaque { // 1403
    extern fn glfwCreateWindow(width: c_int, height: c_int, title: [*:0]const u8, monitor: ?*Monitor, share: ?*Window) ?*Window; // 3235
    pub const init = glfwCreateWindow;

    extern fn glfwDestroyWindow(window: *Window) void; // 3264
    pub const deinit = glfwDestroyWindow;

    extern fn glfwWindowShouldClose(window: *Window) bool; // 3284
    pub const shouldClose = glfwWindowShouldClose;
};

extern fn glfwInit() bool; // 2220
pub const init = glfwInit;

extern fn glfwTerminate() void; //2254
pub const deint = glfwTerminate;

extern fn glfwWindowHint(hint: c_int, value: c_int) void; // 3053
pub fn windowHints(window_hints: struct {
    resizable: ?bool,
    client_api: ?enum(c_int) { no_api = 0 },
}) void {
    if (window_hints.resizable) |resizable| glfwWindowHint(0x00020003, @intFromBool(resizable));
    if (window_hints.client_api) |client_api| glfwWindowHint(0x00022001, @intFromEnum(client_api));
}

extern fn glfwPollEvents() void; // 4534
pub const pollEvents = glfwPollEvents;

extern fn glfwGetRequiredInstanceExtensions(count: *u32) [*c][*:0]const u8; // 6360
pub fn getRequiredInstanceExtensions() [][*:0] const u8 {
    var count: u32 = 0;
    var extensions = glfwGetRequiredInstanceExtensions(&count);
    return extensions[0..count];
}
