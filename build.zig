const std = @import("std");
const Builder = std.build.Builder;
const Pkg = std.build.Pkg;

const Pkgs = struct {
    const QObject: Pkg = .{
        .name = "QObject",
        .path = "src/QObject.zig",
    };
    const QMetaObject: Pkg = .{
        .name = "QMetaObject",
        .path = "src/QMetaObject.zig",
    };
    const QVariant: Pkg = .{
        .name = "QVariant",
        .path = "src/QVariant.zig",
    };
    const QQmlContext: Pkg = .{
        .name = "QQmlContext",
        .path = "src/QQmlContext.zig",
    };
    const QMetaType: Pkg = .{
        .name = "QMetaType",
        .path = "src/QMetaType.zig",
    };
    const QUrl: Pkg = .{
        .name = "QUrl",
        .path = "src/QUrl.zig",
    };
    const QQmlApplicationEngine: Pkg = .{
        .name = "QQmlApplicationEngine",
        .path = "src/QQmlApplicationEngine.zig",
    };
    const QGuiApplication: Pkg = .{
        .name = "QGuiApplication",
        .path = "src/QGuiApplication.zig",
    };
    const DOtherSide: Pkg = .{
        .name = "DOtherSide",
        .path = "src/DOtherSide.zig",
    };
};

pub fn build(b: *Builder) !void {
    const mode = b.standardReleaseOptions();
    const target = b.standardTargetOptions(.{});

    try cmakeBuild(b);
    try animated(b, mode, target);
    try hello(b, mode, target);
}

fn animated(b: *Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget) !void {
    //Example 1
    const hello_example = b.addExecutable("Animated", "examples/animated.zig");
    if (mode != .Debug) {
        hello_example.strip = true;
    }
    hello_example.setBuildMode(mode);
    hello_example.setTarget(target);
    hello_example.addPackage(Pkgs.QObject);
    hello_example.addPackage(Pkgs.QVariant);
    hello_example.addPackage(Pkgs.QUrl);
    hello_example.addPackage(Pkgs.QMetaType);
    hello_example.addPackage(Pkgs.QMetaObject);
    hello_example.addPackage(Pkgs.QQmlContext);
    hello_example.addPackage(Pkgs.QGuiApplication);
    hello_example.addPackage(Pkgs.QQmlApplicationEngine);
    hello_example.addPackage(Pkgs.DOtherSide);
    hello_example.addLibPath("deps/dotherside/build/lib");
    hello_example.linkSystemLibraryName("DOtherSide");
    hello_example.linkLibC();
    hello_example.install();

    const run_cmd = hello_example.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("Animated", "Run the animated example");
    run_step.dependOn(&run_cmd.step);
}

fn hello(b: *Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget) !void {
    //Example 2
    const hello_example = b.addExecutable("Hello", "examples/hello.zig");
    if (mode != .Debug) {
        hello_example.strip = true;
    }
    hello_example.setBuildMode(mode);
    hello_example.setTarget(target);
    hello_example.addPackage(Pkgs.QObject);
    hello_example.addPackage(Pkgs.QVariant);
    hello_example.addPackage(Pkgs.QUrl);
    hello_example.addPackage(Pkgs.QMetaType);
    hello_example.addPackage(Pkgs.QMetaObject);
    hello_example.addPackage(Pkgs.QQmlContext);
    hello_example.addPackage(Pkgs.QGuiApplication);
    hello_example.addPackage(Pkgs.QQmlApplicationEngine);
    hello_example.addPackage(Pkgs.DOtherSide);
    hello_example.addLibPath("deps/dotherside/build/lib");
    hello_example.linkSystemLibrary("DOtherSide");
    hello_example.linkLibC();
    hello_example.install();

    const run_widget = hello_example.run();
    run_widget.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_widget.addArgs(args);
    }

    const widget_step = b.step("hello", "Run the Hello example");
    widget_step.dependOn(&run_widget.step);
}

fn cmakeBuild(b: *Builder) !void {
    //CMake builds - DOtherSide build
    const DOtherSide_configure = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "-B",
        "deps/dotherside/build",
        "-S",
        "deps/dotherside",
        "-DCMAKE_BUILD_TYPE=Release",
    });
    const DOtherSide_build = b.addSystemCommand(&[_][]const u8{
        "cmake",
        "--build",
        "deps/dotherside/build",
        "-j",
    });

    // Note: If it is not necessary to compile DOtherSide library, please comment on these two lines.
    try DOtherSide_configure.step.make();
    try DOtherSide_build.step.make();
}
