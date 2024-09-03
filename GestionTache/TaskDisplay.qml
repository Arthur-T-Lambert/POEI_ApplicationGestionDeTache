import QtQuick 6.7
import "tasklist.js" as Database

Item {
    id: taskDisplayItem
    width: parent.width
    height: 30

    state: "active"

    Text {
        text: model.name
        font.pointSize: 16
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {  }

        onPressed: {  }

        onReleased: {  }

        onEntered: {  }

        onExited: {  }
    }

    states: [
        State {
            name: "active"
            PropertyChanges {  }
        },
        State {
            name: "completed"
            PropertyChanges {  }
        }
    ]
}
