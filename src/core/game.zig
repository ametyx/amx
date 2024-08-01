const std = @import("std");
const Window = @import("../platform/window.zig").Window;
const GLPlatform = @import("../platform/gl/gl_platform.zig").GLPlatform;

pub const Game = struct {
    /// Title of the game
    Title: []const u8,
    /// 
    Window: *Window,

    /// Initialize the game
    pub fn init(self: *Game) !void {
        try self.Window.init(self.Title);
    }

    /// Run the game loop
    pub fn run(self: *Game) !void {
        while (!self.Window.shouldClose()) {
            try self.Window.onFrameStart();

            try self.Window.onFrameEnd();
        }
    }

    /// Dispose of the game and clears up memory
    pub fn dispose(self: *Game) void {
        self.Window.dispose();
    }
};

/// Create a game structure that holds the data for the game
pub fn createGame(alloc: std.mem.Allocator, title: []const u8) !*Game {
    const g = try alloc.create(Game);
    g.Title = title;

    // Create GL window
    const gl = GLPlatform{};
    const platform = gl.platform;
    g.Window = try platform.createWindow(alloc, title);

    return g;
}