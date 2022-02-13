const QGui = @import("QGuiApplication");
const QQml = @import("QQmlApplicationEngine");
const QO = @import("QObject");
const QV = @import("QVariant");

const string = []u8;

pub fn main() anyerror!void {
    QGui.QGuiApplication.init();
    defer QGui.QGuiApplication.quit();

    var engine = QQml.QQmlApplicationEngine.create();
    defer engine.delete();
    engine.loadData(@embedFile("particle.qml"));

    // var context = engine.rootContext();

    QGui.QGuiApplication.exec();
}

// const Control = struct {
//     pub fn textReleased(self: *Control, text: QO.QObject) void {}

//     pub fn emit(self: *Control, x: i8, y: i8) void {}

//     pub fn done(self: *Control, emitter: QO.QObject) void {}
// };
