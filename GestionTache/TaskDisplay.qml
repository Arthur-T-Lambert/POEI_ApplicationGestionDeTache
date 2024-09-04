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

    /**
     * @brief A layout container for the task display.
     *
     * This layout arranges a switch and the task title horizontally.
     */
    Row {
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
