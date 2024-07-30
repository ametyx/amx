const std = @import("std");
const glfw = @cImport({
    @cInclude("glfw3.h");
});

pub fn helloWorld() !void {

    if (glfw.glfwInit() == 0) {
        @panic("Failed to initialize glfw");
    }
    std.debug.print("Hello world", .{});
    glfw.glfwTerminate();
}