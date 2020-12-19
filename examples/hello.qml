import QtQuick 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    id: app
    title: "Hello World [ZIG]- Example"
    width: 300; height: 200
    color: "lightgray"
    Component.onCompleted: visible = true

    Text {
        text: "Hello world!\n Qml on Zig"
        y: 30
        anchors.horizontalCenter: app.contentItem.horizontalCenter
        font.pointSize: 24; font.bold: true
    }
}
