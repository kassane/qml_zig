usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");
usingnamespace @import("QObject");
usingnamespace @import("QVariant");

const string = []u8;

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();
    engine.loadData(@embedFile("particle.qml"));

    var context = engine.rootContext();

    QGuiApplication.exec();
}

const Control = struct {
    pub fn textReleased(self: *Control, text: QObject) void {}

    pub fn emit(self: *Control, x: i8, y: i8) void {}

    pub fn done(self: *Control, emitter: QObject) void {}
};
