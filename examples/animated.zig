const QGui = @import("QGuiApplication");
const QQml = @import("QQmlApplicationEngine");
const QUrl = @import("QUrl").QUrl;

pub fn main() anyerror!void {
    QGui.QGuiApplication.init();
    defer QGui.QGuiApplication.quit();

    var engine = QQml.QQmlApplicationEngine.create();
    defer engine.delete();

    // engine.load("../../../examples/animated.qml"); //load file runtime (depedence file)
    //                  and
    const url = QUrl.create("examples/animated.qml"); //load file runtime (depedence file)
    engine.loadUrl(url);
    //                  or
    // engine.loadData(@embedFile("animated.qml")); // load file comptime (qrc equivalent)

    QGui.QGuiApplication.exec();
}
