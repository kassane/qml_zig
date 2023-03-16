const Qt = @import("Qt");

pub fn main() anyerror!void {
    Qt.QGuiApplication.init();
    defer Qt.QGuiApplication.quit();

    var engine = Qt.QQmlApplicationEngine.create();
    defer engine.delete();

    engine.loadData(@embedFile("splitview.qml"));
    Qt.QGuiApplication.exec();
}
