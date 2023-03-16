const Qt = @import("Qt");
const QUrl = Qt.QUrl;

pub fn main() anyerror!void {
    Qt.QGuiApplication.init();
    defer Qt.QGuiApplication.quit();

    var engine = Qt.QQmlApplicationEngine.create();
    defer engine.delete();

    // engine.load("../../../examples/animated.qml"); //load file runtime (depedence file)
    //                  and
    const url = QUrl.create("examples/animated.qml"); //load file runtime (depedence file)
    engine.loadUrl(url);
    //                  or
    // engine.loadData(@embedFile("animated.qml")); // load file comptime (qrc equivalent)

    Qt.QGuiApplication.exec();
}
