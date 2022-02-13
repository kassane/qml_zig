const QGui = @import("QGuiApplication");
const QQml = @import("QQmlApplicationEngine");

pub fn main() anyerror!void {
    QGui.QGuiApplication.init();
    defer QGui.QGuiApplication.quit();

    var engine = QQml.QQmlApplicationEngine.create();
    defer engine.delete();

    engine.loadData(@embedFile("button.qml"));
    QGui.QGuiApplication.exec();
}
