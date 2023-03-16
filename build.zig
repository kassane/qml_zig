const std = @import("std");
const Builder = std.Build.Builder;
const Pkg = std.build.Pkg;
const string = []const u8;
const fmt_description = "Run the {s} example";

pub fn build(b: *Builder) !void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    // Note: If it is not necessary to compile DOtherSide library, please comment on this line.
    try cmakeBuild(b);

    // Original examples
    try makeExample(b, mode, target, "examples/animated.zig", "Animated");
    try makeExample(b, mode, target, "examples/hello.zig", "Hello");

    // More examples
    try makeExample(b, mode, target, "examples/button.zig", "Button");

    // Copypasta from the Go QML eamples https://github.com/go-qml/qml/tree/v1/examples
    try makeExample(b, mode, target, "examples/particle.zig", "Particle");
    try makeExample(b, mode, target, "examples/layouts.zig", "Layouts");
    try makeExample(b, mode, target, "examples/splitview.zig", "Splits");
    try makeExample(b, mode, target, "examples/tableview.zig", "Tables");

    // Cloned simple examples from the Qml doco
    try makeExample(b, mode, target, "examples/cells.zig", "Cells");
}

fn makeExample(b: *Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget, src: string, name: string) !void {
    const example = b.addExecutable(.{
        .name = name,
        .root_source_file = .{ .path = src },
        .optimize = mode,
        .target = target,
    });

    //Strip file
    if (mode != .Debug) {
        example.strip = true;
    }

    // Module
    const Qt = b.createModule(.{
        .source_file = .{ .path = "src/Qt.zig" },
    });

    example.addModule("Qt", Qt);
    example.addLibraryPath("zig-cache/lib");

    example.linkSystemLibraryName("DOtherSide");
    example.linkLibC();
    example.install();

    const run_cmd = example.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    var descr = b.fmt(fmt_description, .{name});
    const run_step = b.step(name, descr);
    run_step.dependOn(&run_cmd.step);
}

fn cmakeBuild(b: *Builder) !void {
    //CMake builds - DOtherSide build
    const DOtherSide_configure = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "-B",
        "zig-cache",
        "-S",
        "deps/dotherside",
        "-DCMAKE_BUILD_TYPE=Release",
    });
    const DOtherSide_build = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--build",
        "zig-cache",
        "--parallel",
    });

    try DOtherSide_configure.step.make();
    try DOtherSide_build.step.make();
}