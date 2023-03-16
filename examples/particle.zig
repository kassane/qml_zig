const Qt = @import("Qt");
const string = []u8;

pub fn main() anyerror!void {
    Qt.QGuiApplication.init();
    defer Qt.QGuiApplication.quit();

    var engine = Qt.QQmlApplicationEngine.create();
    defer engine.delete();
    engine.loadData(@embedFile("particle.qml"));

    // var context = engine.rootContext();

    Qt.QGuiApplication.exec();
}

// const Control = struct {
//     pub fn textReleased(self: *Control, text: QO.QObject) void {}

//     pub fn emit(self: *Control, x: i8, y: i8) void {}

//     pub fn done(self: *Control, emitter: QO.QObject) void {}
// };
