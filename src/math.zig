const std = @import("std");

pub const Vec4 = @Vector(4, f32);
pub const Mat4 = [4]Vec4;

pub fn matNMulVec(mat: anytype, vec: @Vector(mat.len, f32)) @Vector(mat.len, f32) {
    var result: @Vector(mat.len, f32) = [_]f32{0} ** mat.len;
    inline for (0..mat.len) |i| {
        inline for (0..mat.len) |j| {
            result[i] += mat[j][i] * vec[j];
        }
    }
    return result;
}
