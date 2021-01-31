import QtQuick 2.2
import QtQuick.Controls 2.2

ApplicationWindow {
    width: 400
    height: 400
    visible: true

    Button {
        id: button
        text: "A button you can click on"
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: button.down ? "#d6d6d6" : "#f6f6f6"
            border.color: "#26282a"
            border.width: 1
            radius: 4
        }
    }
}
