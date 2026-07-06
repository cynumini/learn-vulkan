const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "learn_vulkan",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .link_libcpp = true,
        }),
    });

    if (target.result.os.tag == .windows) {
        exe.root_module.linkSystemLibrary("gdi32", .{});
        exe.root_module.addObjectFile(b.path("vendor/glfw-3.4.bin.WIN64/lib-mingw-w64/libglfw3.a"));
        const dlltool_run = b.addSystemCommand(&.{"zig"});
        dlltool_run.addArgs(&.{"dlltool", "-d"});
        dlltool_run.addFileArg(b.path("vendor/Vulkan-Loader/loader/vulkan-1.def"));
        dlltool_run.addArgs(&.{"-D", "vulkan-1.dll", "-l"});
        exe.root_module.addObjectFile(dlltool_run.addOutputFileArg("libvulkan-1.a"));
    } else {
        exe.root_module.linkSystemLibrary("glfw3", .{});
        exe.root_module.linkSystemLibrary("vulkan", .{});
    }

    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");

    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);

    run_cmd.step.dependOn(b.getInstallStep());

    run_cmd.addPassthruArgs();

    const exe_tests = b.addTest(.{
        .root_module = exe.root_module,
    });

    const run_exe_tests = b.addRunArtifact(exe_tests);

    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_exe_tests.step);
}
