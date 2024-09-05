import QtQuick

Rectangle {
    id: button
    color: settings.palette.button
    border.color: settings.palette.base
    radius: 16
    implicitWidth: 50 + settings.fontSize * 5
    implicitHeight: 40

    signal clicked()
    property string text: ""

    states: [
        State {
            name: "idle"
            PropertyChanges { target: button; color: settings.palette.button; border.color: settings.palette.base }
        },
        State {
            name: "pressed"
            PropertyChanges { target: button; color: settings.palette.light; border.color: settings.palette.base }
        },
        State {
            name: "hovered"
            PropertyChanges { target: button; color: settings.palette.light; border.color: settings.palette.base }
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
        font.family: settings.fontFamily
        font.pointSize: settings.fontSize
        color: settings.palette.text
    }
}
