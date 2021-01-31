usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    engine.loadData(@embedFile("particle.qml"));

    QGuiApplication.exec();
}
