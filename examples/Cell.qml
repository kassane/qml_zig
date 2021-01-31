import QtQuick 2.2

Cell {
    id: container
    property alias cellColor: rectangle.color
    signal clicked(cellColor: color)

    width: 40; height: 25

    Rectangle {
        id: rectangle
        border.color: "white"
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked(container.cellColor)
    }
}
