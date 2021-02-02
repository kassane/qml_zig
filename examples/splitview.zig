usingnamespace @import("QGuiApplication");
usingnamespace @import("QQmlApplicationEngine");
usingnamespace @import("QObject");
usingnamespace @import("QVariant");

pub fn main() anyerror!void {
    QGuiApplication.init();
    defer QGuiApplication.quit();

    var engine = QQmlApplicationEngine.create();
    defer engine.delete();

    engine.loadData(@embedFile("splitview.qml"));
    QGuiApplication.exec();
}
