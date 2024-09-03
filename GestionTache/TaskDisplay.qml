import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Item {
    id: taskDisplayItem
    width: parent.width
    height: 30
    opacity: 1

    state: "active"

    property int id
    property string title
    property string date
    property string time
    property string description
    property bool done

    // Zone de click pour la modification de la tache
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: { console.log("modif") }

        onPressed: {  }

        onReleased: {  }

        onEntered: {  }

        onExited: {  }
    }

    Row {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 10

        Switch  {
             onCheckedChanged: { taskDisplayItem.state = checked ? "done" : "active"
                 console.log("done")
                 Database.updateStatus(taskDisplayItem.id, checked)
             }
        }

        Text {
            text: taskDisplayItem.title
            font.bold: true
            font.pointSize: 16
        }
    }


    Behavior on opacity { NumberAnimation { duration: 200 } }

    states: [
        State {
            name: "active"
            PropertyChanges { target: taskDisplayItem; opacity: 1 }
        },
        State {
            name: "done"
            PropertyChanges { target: taskDisplayItem; opacity: 0.4 }
        }
    ]
}
