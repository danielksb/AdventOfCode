const std = @import("std");
const ArrayList = std.ArrayList;

const SIZE: usize = 1000000;
const VALUES_MAX: u32 = 10000;
const MEASUREMENTS: usize = 100;

fn calc(values: ArrayList(u32), sorted: *ArrayList(u32), result: *ArrayList(u32)) !void {
    // const stdout = std.io.getStdOut().writer();
    try sorted.insertSlice(0, values.items);
    std.mem.sort(u32, sorted.items, {}, comptime std.sort.asc(u32));
    // try stdout.print("values: {any}\n", .{values.items});
    // try stdout.print("sorted: {any}\n", .{sorted.items});
    for (0..values.items.len) |i| {
        if (values.items[i] != sorted.items[i]) {
            try result.append(@intCast(i));
        }
    }
    // try stdout.print("result: {any}\n", .{result.items});
}

pub fn main() !void {
    var rng: std.Random.DefaultPrng = .init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const stdout = std.io.getStdOut().writer();
    var gpa = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var values = try ArrayList(u32).initCapacity(alloc, SIZE);
    defer values.deinit();
    var sorted = try ArrayList(u32).initCapacity(alloc, SIZE);
    defer sorted.deinit();
    var result = try ArrayList(u32).initCapacity(alloc, SIZE);
    defer result.deinit();

    for (0..SIZE) |_| {
        const value = rng.random().intRangeAtMost(u32, 0, VALUES_MAX);
        try values.append(value);
    }

    try stdout.print("Running benchmark...\n", .{});

    const start = std.time.nanoTimestamp();
    for (0..MEASUREMENTS) |_| {
        try calc(values, &sorted, &result);
        sorted.clearRetainingCapacity();
        result.clearRetainingCapacity();
    }
    const end = std.time.nanoTimestamp();
    const seconds = @as(f64, @floatFromInt(end - start)) / 1_000_000_000.0;
    const avgTime = seconds / @as(f64, MEASUREMENTS);
    try stdout.print("Benchmark completed in {d:.4} seconds\n", .{avgTime});
}
