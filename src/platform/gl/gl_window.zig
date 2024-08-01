const Window = @import("../window.zig").Window;
const GLError = @import("gl_errors.zig").GLError;
const glfw = @cImport({
    @cInclude("glfw3.h");
});

pub const GLWindow = struct {
    win: Window = Window{
        .initFn = init,
        .shouldCloseFn = shouldClose,
        .onFrameStartFn = onFrameStart,
        .onFrameEndFn = onFrameEnd
    },
    handle: ?*glfw.GLFWwindow,

    fn init(self: *Window, title: []const u8) !void {
        if (glfw.glfwInit() == 0) {
            return GLError.initError;
        }

        var w: *GLWindow = @ptrCast(@alignCast(self));
        const c_title: [*c]const u8 = title.ptr;
        w.handle = glfw.glfwCreateWindow(800, 600, c_title, null, null);

        if (w.handle == null) {
            return GLError.windowInitError;
        }

        glfw.glfwMakeContextCurrent(w.handle);
    }

    fn shouldClose(self: *Window) bool {
        const w: *GLWindow = @ptrCast(@alignCast(self));
        return glfw.glfwWindowShouldClose(w.handle) > 0;
    }

    fn onFrameStart(self: *Window) !void {
        _ = self;
        glfw.glClear(glfw.GL_COLOR_BUFFER_BIT);
        glfw.glClearColor(0.1, 0.1, 0.1, 1.0);
    }

    fn onFrameEnd(self: *Window) !void {
        const w: *GLWindow = @ptrCast(@alignCast(self));
        glfw.glfwSwapBuffers(w.handle);
        glfw.glfwPollEvents();
    }
};