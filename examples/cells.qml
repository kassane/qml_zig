import QtQuick 2.2
import QtQuick.Controls 2.2

ApplicationWindow {
    id: page
    width: 320; height: 480
    color: "lightgray"
    visible: true

    // Inline component - not sure how to auto include yet
    // TODO - make it work with importing components !
    component Cell: Item {
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

    Text {
        id: helloText
        text: "Hello world!"
        y: 30
        anchors.horizontalCenter: page.horizontalCenter
        font.pointSize: 24; font.bold: true
    }

    Grid {
        id: colorPicker
        x: 4; anchors.bottom: page.bottom; anchors.bottomMargin: 4
        rows: 2; columns: 3; spacing: 3

        Cell { cellColor: "red"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "green"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "blue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "yellow"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "steelblue"; onClicked: helloText.color = cellColor }
        Cell { cellColor: "black"; onClicked: helloText.color = cellColor }
    }
}

