pub const Window = struct {
    initFn: *const fn (self: *Window, title: []const u8) anyerror!void,
    shouldCloseFn: *const fn (self: *Window) bool,
    onFrameStartFn: *const fn (self: *Window) anyerror!void,
    onFrameEndFn: *const fn (self: *Window) anyerror!void,
    disposeFn: *const fn (self: *Window) void,

    pub fn init(self: *Window, title: []const u8) !void {
        return try self.initFn(self, title);
    }

    /// Whether the window should close or not
    pub fn shouldClose(self: *Window) bool {
        return self.shouldCloseFn(self);
    }

    /// Callback occuring at the beginning of the frame
    pub fn onFrameStart(self: *Window) !void {
        return try self.onFrameStartFn(self);
    }

    /// Callback occuring at the end of the frame
    pub fn onFrameEnd(self: *Window) !void {
        return try self.onFrameEndFn(self);
    }

    /// Dispose of the Window instance and destroys
    /// platform specific memory
    pub fn dispose(self: *Window) void {
        return self.disposeFn(self);
    }
};