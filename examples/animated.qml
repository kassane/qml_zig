import QtQuick 2.2
import QtQuick.Controls 1.4

ApplicationWindow {
    id: app
    title: "Animated [ZIG]- Example"
    width: 300; height: 200
    color: "lightgray"
    Component.onCompleted: visible = true

        Item {
        id: root
        anchors.fill: parent

        Rectangle {
            id: rect
            width: parent.width/6
            height: width
            color: "green"
        }

        states: [
            State {
                name: "right"
                AnchorChanges { target: rect; anchors.right: root.right }
            },
            State {
                name: "left"
                AnchorChanges { target: rect; anchors.left: root.left }
            }
        ]

        transitions: Transition {
            AnchorAnimation { duration: 500 }
        }

        Timer {
            running: true; repeat: true; interval: 1000
            onTriggered: root.state = root.state === "right" ? "left" : "right"
        }
    }    
}