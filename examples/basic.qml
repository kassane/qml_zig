import QtQuick 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    id: app
    title: "Basic Example"
    width: 320; height: 480
    color: "lightgray"
    Component.onCompleted: visible = true

    Text {
        id: helloText
        text: "Hello Zig!"
        y: 30
        anchors.horizontalCenter: page.horizontalCenter
        font.pointSize: 24; font.bold: true
    }
}
