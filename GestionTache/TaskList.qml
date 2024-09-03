import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Item {
    property int maxH: 400
    property int minH: 20

    states: [
        State {
            name: "deployed"
            PropertyChanges { target: taskListView;  }
        },
        State {
            name: "retracted"
            PropertyChanges { target: taskListView;  }
        }
    ]

    Rectangle {
        id: header
        anchors.top: parent.top
        color: application.palette.button
        radius: 10
        height: minH
        anchors.left: parent.left
        anchors.right: parent.right

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: "ListView"
            color: application.palette.buttonText
        }
        Button {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
        }
    }

    ListView {
        id: listView
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        highlightFollowsCurrentItem: true
        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }

        focus: true

        model: ListModel {
            ListElement { name: "Alice"; descr: "20" }
            ListElement { name: "Bob"; descr: "28" }
            ListElement { name: "Charlie"; descr: "42" }
        }

        delegate: Item {
            id: rect
            width: parent.width
            height: 50

            Text {
                text: model.name
                font.pointSize: 20
                anchors.centerIn: parent
            }

            SequentialAnimation {
                id: colorAnim
                ColorAnimation { target: rect; property: "color"; to: "green"; duration: 200 }
                ColorAnimation { target: rect; property: "color"; to: "white"; duration: 600 }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Clicked on", model.name)
                    listView.currentIndex = index
                }
            }
        }
    }
}
