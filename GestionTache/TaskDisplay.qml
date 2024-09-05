/**
 * @file TaskDisplayItem.qml
 * @brief A QML component for displaying a task item with interactive elements.
 *
 * This component defines an item for displaying task details, including a switch to mark the task as done,
 * and a text label for the task title. It also handles state transitions for visual feedback.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Item {
    id: taskDisplayItem
    height: 30
    opacity: 1

    state: done ? "done" : "active"

    property int db_id
    property string title
    property string date
    property string time
    property string description
    property bool done

    /**
     * @brief Clickable zone to switch to TaskEdit page.
     */
    MouseArea {
        anchors.fill: taskRow
        onClicked: {
            console.log("modif")
            stackView.push(Qt.resolvedUrl("TaskEdit.qml"),
                           {
                               "db_id": taskDisplayItem.db_id,
                               "title": taskDisplayItem.title,
                               "date": taskDisplayItem.date,
                               "time": taskDisplayItem.time,
                               "description": taskDisplayItem.description
                           })
        }
    }

    /**
     * @brief A layout container for the task display.
     *
     * This layout arranges a switch and the task title horizontally.
     */
    Row {
        id: taskRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: 10

        /**
         * @brief A switch to mark the task as done.
         *
         * Changes the task's state and updates its status in the database when checked or unchecked.
         */
        Switch  {
            id: doneSwitch
            checked: taskDisplayItem.done
            property bool init: false

            onCheckedChanged: {
                if (init) {
                    console.log("checked :", checked, "state before :", taskDisplayItem.state)
                    taskDisplayItem.state = checked ? "done" : "active"
                    TaskStorage.updateTaskState(taskDisplayItem.db_id, checked)
                }
            }

            Component.onCompleted: {
                init = true
            }
        }

        Text {
            text: taskDisplayItem.title
            font.bold: true
            font.pointSize: 16
        }
    }

    /**
     * @brief Defines a behavior for the opacity property.
     *
     * Animates changes in opacity over 200 milliseconds.
     */
    Behavior on opacity { NumberAnimation { duration: 200 } }

    /**
     * @brief Defines the states for the task item.
     *
     * - "active": Fully opaque with opacity set to 1.
     * - "done": Slightly transparent with opacity set to 0.4.
     */
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
