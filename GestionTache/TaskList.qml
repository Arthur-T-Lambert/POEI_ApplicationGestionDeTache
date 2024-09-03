import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Column {
    id: taskList

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

        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: header.left
            anchors.leftMargin: 8
            text: "ListView"
            color: application.palette.buttonText
        }
        Button {
            height: header.height - 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            width: header.height - 5

            onPressed: taskList.state = taskList.state === "deployed" ? "retracted" : "deployed"
        }
    }

    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10

        clip: true

        model: ListModel {
            ListElement { name: "Alice"; descr: "20" }
            ListElement { name: "Bob"; descr: "28" }
            ListElement { name: "Char"; descr: "42" }
            ListElement { name: "Charl"; descr: "42" }
            ListElement { name: "Charli"; descr: "42" }
            ListElement { name: "Charlie"; descr: "42" }
        }

        delegate: Item {
            id: rect
            width: parent.width
            height: 30

            Text {
                text: model.name
                font.pointSize: 16
                anchors.centerIn: parent
            }
        }

        Behavior on height { NumberAnimation { duration: 500 } }
    }
}
