const std = @import("std");
const Builder = std.build.Builder;
const Pkg = std.build.Pkg;
const string = []const u8;
const alloc = std.heap.page_allocator;
const fmt_description = "Run the {s} example";

const Pkgs = struct {
    const QObject: Pkg = .{
        .name = "QObject",
        .source = .{ .path = "src/QObject.zig" },
    };
    const QMetaObject: Pkg = .{
        .name = "QMetaObject",
        .source = .{ .path = "src/QMetaObject.zig" },
    };
    const QVariant: Pkg = .{
        .name = "QVariant",
        .source = .{ .path = "src/QVariant.zig" },
    };
    const QQmlContext: Pkg = .{
        .name = "QQmlContext",
        .source = .{ .path = "src/QQmlContext.zig" },
    };
    const QMetaType: Pkg = .{
        .name = "QMetaType",
        .source = .{ .path = "src/QMetaType.zig" },
    };
    const QUrl: Pkg = .{
        .name = "QUrl",
        .source = .{ .path = "src/QUrl.zig" },
    };
    const QQmlApplicationEngine: Pkg = .{
        .name = "QQmlApplicationEngine",
        .source = .{ .path = "src/QQmlApplicationEngine.zig" },
    };
    const QGuiApplication: Pkg = .{
        .name = "QGuiApplication",
        .source = .{ .path = "src/QGuiApplication.zig" },
    };
    const DOtherSide: Pkg = .{
        .name = "DOtherSide",
        .source = .{ .path = "src/DOtherSide.zig" },
    };
};

pub fn build(b: *Builder) !void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

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
    const example = b.addExecutable(name, src);

    //Strip file
    if (mode != .Debug) {
        example.strip = true;
    }

    example.setBuildMode(mode);
    example.setTarget(target);
    example.addPackage(Pkgs.QObject);
    example.addPackage(Pkgs.QVariant);
    example.addPackage(Pkgs.QUrl);
    example.addPackage(Pkgs.QMetaType);
    example.addPackage(Pkgs.QMetaObject);
    example.addPackage(Pkgs.QQmlContext);
    example.addPackage(Pkgs.QGuiApplication);
    example.addPackage(Pkgs.QQmlApplicationEngine);
    example.addPackage(Pkgs.DOtherSide);
    example.addLibPath("zig-out/lib");

    example.linkSystemLibraryName("DOtherSide");
    example.linkLibC();
    example.install();

    const run_cmd = example.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    var descr = std.fmt.allocPrintZ(alloc, fmt_description, .{name}) catch unreachable;
    const run_step = b.step(name, descr);
    run_step.dependOn(&run_cmd.step);
}

fn cmakeBuild(b: *Builder) !void {
    //CMake builds - DOtherSide build
    const DOtherSide_configure = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "-B",
        "zig-out",
        "-S",
        "deps/dotherside",
        "-DCMAKE_BUILD_TYPE=Release",
    });
    const DOtherSide_build = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--build",
        "zig-out",
        "--parallel",
    });

    try DOtherSide_configure.step.make();
    try DOtherSide_build.step.make();
}
