const std = @import("std");
pub const Vec4 = @Vector(4, f32);

pub const Mat4 = struct {
    rows: [4]Vec4,

    pub fn identity(v: f32) Mat4 {
        return .{
            .rows = .{
                .{ v, 0, 0, 0 },
                .{ 0, v, 0, 0 },
                .{ 0, 0, v, 0 },
                .{ 0, 0, 0, v },
            },
        };
    }

    pub fn mulVec4(self: Mat4, vec4: Vec4) Vec4 {
        return .{
            @reduce(.Add, self.rows[0] * vec4),
            @reduce(.Add, self.rows[1] * vec4),
            @reduce(.Add, self.rows[2] * vec4),
            @reduce(.Add, self.rows[3] * vec4),
        };
    }

    test mulVec4 {
        const matrix = Mat4.identity(2);
        const vec = Vec4{ 1, 2, 3, 1 };
        try std.testing.expectEqual(matrix.mulVec4(vec), Vec4{ 2, 4, 6, 2 });
    }
};
