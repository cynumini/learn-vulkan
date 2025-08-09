const std = @import("std");

const HelloTriangleApplication = @import("hello_triangle_application.zig");
const math = @import("math.zig");
const vk = @import("vulkan.zig");

pub fn main() !void {
    var app: HelloTriangleApplication = .{};

    try app.run();
}
