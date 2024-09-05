/**
 * @file TaskEdit.qml
 * @brief A QML component that provides a user interface for managing tasks.
 *
 * This component creates a UI that allows users to edit name, due date, due time,
 * and description of a task. It also provides buttons for navigating to settings and going back in the stack view.
 *
 * The task data is modified in the database by calling a JavaScript function from TaskStorage singleton.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material

/**
 * @class TaskEdit
 * @brief The main class for the task management UI.
 *
 * This class creates a Rectangle that contains UI elements for modifying tasks and navigation.
 */
Rectangle {
    id: pageRoot
    property int db_id

    property string title
    property string date
    property string time
    property string description

    color: settings.palette.window

    /**
     * @brief A container for input fields and the validate change button.
     *
     * This section contains input fields for task name, due date, due time, and description.
     * It also includes a button to edit the task in the database.
     */
    Column {
        spacing: 20
        padding: 20
        anchors.centerIn: parent

        /**
         * @brief Input field for the task name.
         */
        CustomTextField {
            id: taskNameField
            label: "Titre"
            placeholder: "Titre de la tâche"
            text: pageRoot.title
        }

        /**
         * @brief Input field for the due date of the task.
         */
        CustomTextField {
            id: dueDateField
            label: "Date"
            placeholder: "Date de fin"
            text: pageRoot.date
            calendarButton.visible: true
        }

        /**
         * @brief Input field for the due time of the task.
         */
        CustomTextField {
            id: dueTimeField
            label: "Due Time"
            placeholder: "Enter due time"
            text: pageRoot.time
        }

        /**
         * @brief Input field for the task description.
         */
        CustomTextField {
            id: description
            label: "Description"
            placeholder: "Description"
            inputFieldHeight: 100
            text: pageRoot.description
        }

        /**
         * @brief Button to add a task.
         *
         * When clicked, the task data is edited in the database.
         */
        CustomButton {
            text: "Modifier"
            // font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                console.log("modification dans la db")
                TaskStorage.updateTask(pageRoot.db_id, taskNameField.text, dueDateField.text, dueTimeField.text, description.text);
                stackView.pop();
            }
        }

    }

    /**
     * @brief Button to navigate to the settings page.
     *
     * When clicked, this button pushes the SettingsView.qml page onto the stack view.
     */
    CustomButton {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        text: "Settings"

        onClicked: {
            console.log("Settings button cliecked")
            stackView.push(Qt.resolvedUrl("SettingsView.qml"))
        }
    }

    /**
     * @brief Button to navigate back in the stack view.
     *
     * When clicked, this button pops the current view from the stack view.
     */
    CustomButton {
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin : 10
        text: "Back"

        onClicked: {
            console.log("Settings button cliecked")
            stackView.pop()
        }
    }

}

