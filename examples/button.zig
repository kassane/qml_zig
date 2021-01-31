// button example
// - the text in the button is set from Zig
// - onClick handler jumps to a Zig callback

const std = @import("std");
usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");
usingnamespace @import("QObject");
usingnamespace @import("QVariant");

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    engine.loadData(@embedFile("button.qml"));

    // set the button value from Zig
    //    const my_button = Button{ .text = "Text from Zig" };
    //   engine.rootContext().setContextProperty("my_button", my_button);

    // Run the app
    QGuiApplication.exec();
}

const Button = struct {
    text: []const u8,
};
