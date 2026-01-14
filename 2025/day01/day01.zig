const std = @import("std");

fn nextLine(reader: anytype, buffer: []u8) !?[]const u8 {
    const line = (try reader.readUntilDelimiterOrEof(
        buffer,
        '\n',
    )) orelse return null;
    // trim annoying windows-only carriage return character
    if (@import("builtin").os.tag == .windows) {
        return std.mem.trimRight(u8, line, "\r");
    } else {
        return line;
    }
}

fn parse_step(line: []const u8) !i32 {
    const steps = try std.fmt.parseInt(i32, line[1..], 10);
    switch (line[0]) {
        'L' => {
            return -steps;
        },
        'R' => {
            return steps;
        },
        else => {
            return error.InvalidInput;
        },
    }
}

const Dial = struct {
    position: u32,
    zeroes: u32,
};

//fn turn_dial(dial: &Dial)

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var argv = try std.process.argsWithAllocator(alloc);
    defer argv.deinit();
    const prog_name = argv.next() orelse "day01.zig";
    const filename = argv.next() orelse {
        std.debug.print("Usage: {s} <filename> [<start>]\n", .{prog_name});
        return;
    };
    const start = argv.next() orelse "0";
    const start_pos = try std.fmt.parseInt(i32, start, 10);

    var file = try std.fs.cwd().openFile(filename, .{ .mode = .read_only });
    defer file.close();
    var buffer: [std.math.pow(usize, 2, 12)]u8 = undefined;
    var f_reader: std.fs.File.Reader = file.reader();
    std.debug.print("The dial starts by pointing at {d}.\n", .{start_pos});
    var current_pos: i32 = start_pos;
    var zeroes: i32 = 0;
    while (true) {
        const line = try nextLine(&f_reader, &buffer) orelse break;
        if (line.len < 2) {
            continue;
        }
        const steps = try parse_step(line);

        const new_pos = current_pos + steps;

        var hits_zero: i32 = 0;
        if (steps <= 0) {
            const rotations: i32 = @divTrunc(100 - new_pos, 100);
            // std.debug.print("pos {d} -> {d}, rotations: {d}\n", .{ current_pos, new_pos, rotations });
            if (current_pos == 0) {
                hits_zero = rotations - 1;
            } else {
                hits_zero = rotations;
            }
        } else {
            hits_zero = @divTrunc(new_pos, 100);
        }

        current_pos = @mod(new_pos + 100, 100);
        zeroes += hits_zero;

        std.debug.print("The dial is rotated {s} to point at {d}", .{ line, current_pos });
        if (hits_zero > 0) {
            std.debug.print("; during this rotation, it points at zero {d} times.\n", .{hits_zero});
        } else {
            std.debug.print(".\n", .{});
        }
    }
    std.debug.print("zeroes: {d}\n", .{zeroes});
}
