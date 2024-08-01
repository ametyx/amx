const std = @import("std");
const Window = @import("window.zig").Window;

pub const Platform = struct {
    createWindowFn: *const fn (self: *const Platform, alloc: std.mem.Allocator, title: []const u8) anyerror!*Window,

    pub fn createWindow(self: *const Platform, alloc: std.mem.Allocator, title: []const u8) !*Window {
        return try self.createWindowFn(self, alloc, title);
    }
};