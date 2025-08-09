const std = @import("std");

pub const Vec4 = @Vector(4, f32);
pub const Mat4 = [4]Vec4;

pub fn multiply(a: anytype, b: @Vector(a.len, f32)) @Vector(a.len, f32) {
    var result: @Vector(a.len, f32) = [_]f32{0} ** a.len;
    inline for (0..a.len) |i| {
        inline for (0..a.len) |j| {
            result[i] += a[j][i] * b[j];
        }
    }
    return result;
}
