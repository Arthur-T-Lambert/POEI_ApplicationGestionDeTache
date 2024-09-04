/**
 * @file TaskList.qml
 * @brief A QML component for displaying a list of tasks with a collapsible header.
 *
 * This component defines a column layout for displaying a list of tasks. It includes a header with a button
 * to toggle the visibility of the task list. The list of tasks is shown in a `ListView` that adapts its height
 * based on the component's state.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

/*
 *
 */
Column {
    id: taskList

    /**
     * @brief The model used to fill the list of tasks.
     */
    property ListModel taskModel

    property int maxHeight

    state: "deployed"

    property string title: "ListView"


    /**
     * @brief The states of the task list.
     *
     * - "deployed": The list view is fully visible.
     * - "retracted": The list view is collapsed.
     */
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

    /**
     * @brief A header containing a title and a button to toggle the list view.
     *
     * The header displays the title and includes a button to expand or collapse the list view. The button's
     * rotation indicates whether the list is expanded or collapsed.
     */
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
            text: taskList.title
            color: application.palette.buttonText
        }

        /**
         * @brief A button to toggle the visibility of the task list.
         *
         * When pressed, changes the state of the task list between "deployed" and "retracted".
         */
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

    /**
     * @brief A `ListView` displaying the list of tasks.
     *
     * Displays tasks using a delegate and adapts its height based on the component's state.
     */
    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 10

        // Pour que ça ne déborde pas
        clip: true

        model: taskList.taskModel

        /**
         * @brief A delegate for displaying individual tasks.
         *
         * Uses the `TaskDisplay` component to show each task in the list.
         */
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
