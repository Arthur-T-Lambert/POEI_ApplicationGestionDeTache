import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

/*
 *
 */
Column {
    id: taskList

    property ListModel taskModel

    property int maxHeight
    state: "deployed"

    states: [
        State {
            name: "deployed"
            PropertyChanges { target: listView; height: Math.min(listView.contentHeight, maxHeight) }
        },
        State {
            name: "retracted"
            PropertyChanges { target: listView; height: 0 }
        }
    ]

    Rectangle {
        id: header
        color: application.palette.button
        radius: 10
        height: 30
        width: taskList.width
        border.width: 1.5
        border.color: "black"

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: header.left
            anchors.leftMargin: 8
            text: "ListView"
            color: application.palette.buttonText
        }
        Button {
            height: header.height - 6
            width: header.height - 6
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5

            onPressed: {
                taskList.state = taskList.state === "deployed" ? "retracted" : "deployed"
                buttonText.rotation = buttonText.rotation === 180 ? 0 : 180
            }

            Text {
                id: buttonText
                text: "V"
                anchors.centerIn: parent
                rotation: 180

                Behavior on rotation { NumberAnimation { duration: 500 } }
            }
        }
    }

    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10

        // Pour que ça ne déborde pas
        clip: true

        model: taskList.taskModel

        delegate: TaskDisplay {
            db_id: model.db_id
            title: model.title
            date: model.date
            time: model.time
            description: model.description
            done: model.done
        }

        Behavior on height { NumberAnimation { duration: 500 } }
    }
}
