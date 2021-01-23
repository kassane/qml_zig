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

    menuBar: MenuBar {
            Menu {
                title: qsTr("File")
                MenuItem {
                    text: qsTr("&Open")
                    onTriggered: console.log("Open action triggered");
                }
                MenuItem {
                    text: qsTr("Exit")
                    onTriggered: Qt.quit();
                }
            }
    }

    Button {
        text: qsTr("click bait")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter / 2
    }
}
