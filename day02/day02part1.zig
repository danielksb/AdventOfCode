const std = @import("std");

fn next_range(reader: anytype, buffer: []u8) !?[]const u8 {
    const range = try reader.readUntilDelimiterOrEof(
        buffer,
        ',',
    ) orelse return null;
    return range;
}

const Range = struct {
    start: usize,
    end: usize,
};

fn parse_range(range: []const u8) !Range {
    const dash_index = std.mem.indexOf(u8, range, "-") orelse
        return error.InvalidInput;
    const start_str = range[0..dash_index];
    const end_str = range[dash_index + 1 ..];

    const start = try std.fmt.parseInt(usize, start_str, 10);
    const end = try std.fmt.parseInt(usize, end_str, 10);

    return .{ .start = start, .end = end };
}

fn is_invalid_id(id: usize, alloc: std.mem.Allocator) !bool {
    const id_str = try std.fmt.allocPrint(alloc, "{d}", .{id});
    defer alloc.free(id_str);

    if (id_str.len % 2 != 0) {
        return false;
    }

    var start_idx: usize = 0;
    var mid_idx: usize = id_str.len / 2;

    while (mid_idx < id_str.len) : (mid_idx += 1) {
        if (id_str[start_idx] != id_str[mid_idx]) {
            return false;
        }
        start_idx += 1;
    }

    return true;
}

fn find_invalid_ids(range: Range, alloc: std.mem.Allocator) !std.ArrayList(usize) {
    var invalid_ids = std.ArrayList(usize).init(alloc);

    for (range.start..range.end + 1) |id| {
        if (try is_invalid_id(id, alloc)) {
            try invalid_ids.append(id);
        }
    }

    return invalid_ids;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();
    var argv = try std.process.argsWithAllocator(alloc);

    defer argv.deinit();
    const prog_name = argv.next() orelse "day02.zig";
    const filename = argv.next() orelse {
        std.debug.print("Usage: {s} <filename>\n", .{prog_name});
        return;
    };

    const file = try std.fs.cwd().openFile(filename, .{ .mode = .read_only });
    defer file.close();

    const reader = file.reader();
    var buffer: [std.math.pow(usize, 2, 12)]u8 = undefined;

    var sum: usize = 0;
    while (true) {
        const range_string = try next_range(reader, &buffer) orelse break;
        const range = parse_range(range_string) catch {
            continue;
        };
        const invalid_ids = try find_invalid_ids(range, alloc);
        defer invalid_ids.deinit();

        std.debug.print("{d}-{d} has {d} invalid IDs: {any}\n", .{ range.start, range.end, invalid_ids.items.len, invalid_ids.items });

        for (invalid_ids.items) |id| {
            sum += id;
        }
    }
    std.debug.print("Sum of invalid IDs: {d}\n", .{sum});
}

const expect = std.testing.expect;

test "invalid id" {
    try expect(try is_invalid_id(55, std.testing.allocator) == true);
    try expect(try is_invalid_id(6464, std.testing.allocator) == true);
    try expect(try is_invalid_id(123123, std.testing.allocator) == true);
}

test "valid ids" {
    try expect(try is_invalid_id(121123, std.testing.allocator) == false);
    try expect(try is_invalid_id(550, std.testing.allocator) == false);
    try expect(try is_invalid_id(111, std.testing.allocator) == false);
}
