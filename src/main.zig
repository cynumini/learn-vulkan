const std = @import("std");

const HelloTriangleApplication = @import("hello_triangle_application.zig");
const math = @import("math.zig");
const vk = @import("vulkan.zig");

pub fn main() !void {
    var da: std.heap.DebugAllocator(.{}) = .init;
    defer _ = da.deinit();
    const allocator = da.allocator();

    var app: HelloTriangleApplication = .{.allocator = allocator};

    try app.run();
}
