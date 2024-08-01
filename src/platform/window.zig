pub const Window = struct {
    initFn: *const fn (self: *Window, title: []const u8) anyerror!void,
    shouldCloseFn: *const fn (self: *Window) bool,
    onFrameStartFn: *const fn (self: *Window) anyerror!void,
    onFrameEndFn: *const fn (self: *Window) anyerror!void,

    pub fn init(self: *Window, title: []const u8) !void {
        return try self.initFn(self, title);
    }

    /// Whether the window should close or not
    pub fn shouldClose(self: *Window) bool {
        return self.shouldCloseFn(self);
    }

    pub fn onFrameStart(self: *Window) !void {
        return try self.onFrameStartFn(self);
    }

    pub fn onFrameEnd(self: *Window) !void {
        return try self.onFrameEndFn(self);
    }
};