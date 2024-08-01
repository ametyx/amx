const std = @import("std");
const Window = @import("../window.zig").Window;
const Platform = @import("../platform.zig").Platform;

pub const GLPlatform = struct {
    platform: Platform = Platform{
        .createWindowFn = createWindow
    },

    fn createWindow(self: *const Platform, alloc: std.mem.Allocator, title: []const u8) !*Window {
        _ = title;
        _ = self;

        const GLWindow = @import("./gl_window.zig").GLWindow;
        const glWin = GLWindow{ .handle = null };
        const win = try alloc.create(Window);
        win.* = glWin.win;

        return win;
    }
};