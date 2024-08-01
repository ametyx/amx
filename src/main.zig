const std = @import("std");
const amx = @import("amx.zig");

pub fn main() !void {
    const alloc = std.heap.page_allocator;
    const g = try amx.createGame(alloc, "Hello from amx");
    defer alloc.destroy(g);
    
    try g.init();
    try g.run();
}