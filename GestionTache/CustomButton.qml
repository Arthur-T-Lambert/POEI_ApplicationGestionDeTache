import QtQuick

Rectangle {
    id: button
    width: 100
    height: 50
    color: "lightBlue"
    border.color: "blue"
    radius: 10

    signal clicked()
    property string text: "Cliquez-moi"
    property int textSize: 20
    property string textColor: "black"
    property string buttoncolor: "lighBlue"
    property string borderColor: "blue"

    states: [
        State {
            name: "idle"
            PropertyChanges { target: button; color: "lightBlue"; border.color: "blue" }
        },
        State {
            name: "pressed"
            PropertyChanges { target: button; color: "blue"; border.color: "darkBlue" }
        },
        State {
            name: "hovered"
            PropertyChanges { target: button; color: "lightGreen"; border.color: "darkGreen" }
        }
    ]

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: { button.clicked(); }

        onPressed: { button.state = "pressed" }

        onReleased: { if (button.state === "pressed") button.state = "hovered" }

        onEntered: { if (button.state !== "pressed") button.state = "hovered" }

        onExited: { button.state = "idle" }
    }

    Text {
        anchors.centerIn: parent
        text: button.text
        color: button.textColor
        font.pixelSize: button.textSize
    }
}
