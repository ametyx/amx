const std = @import("std");


pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Link to AMX
    const lib = b.addStaticLibrary(.{
        .name = "amx",
        .root_source_file = b.path("src/amx.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib);


    // Create exe
    const exe = b.addExecutable(.{
        .name = "amx",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);


    // Link to GLFW and Glad
    exe.addIncludePath(b.path("libs/includes/"));
    exe.addIncludePath(b.path("libs/includes/glad/"));
    exe.addIncludePath(b.path("libs/includes/GLFW/"));
    exe.addLibraryPath(b.path("libs/"));
    exe.linkLibC();
    exe.addCSourceFile(.{
        .file = b.path("libs/glad.c"),
    });
    exe.linkSystemLibrary("opengl32");
    exe.linkSystemLibrary("winmm");
    exe.linkSystemLibrary("gdi32");
    exe.linkSystemLibrary("glfw3");


    // Run command
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);


    // Tests
    const lib_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/amx.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_lib_unit_tests = b.addRunArtifact(lib_unit_tests);

    const exe_unit_tests = b.addTest(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);


    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_lib_unit_tests.step);
    test_step.dependOn(&run_exe_unit_tests.step);
}
