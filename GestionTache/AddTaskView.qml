/**
 * @file AddTaskView.qml
 * @brief A QML component that provides a user interface for managing tasks.
 *
 * This component creates a UI that allows users to add tasks with a name, due date, due time,
 * and description. It also provides buttons for navigating to settings and going back in the stack view.
 *
 * The task data is inserted into a database by calling a JavaScript function from `tasklist.js`.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material
import ".."
/**
 * @class AddTaskView
 * @brief The main class for the task management UI.
 *
 * This class creates a Rectangle that contains UI elements for adding tasks and navigation.
 */
Rectangle {

    /**
     * @brief A container for input fields and the add task button.
     *
     * This section contains input fields for task name, due date, due time, and description.
     * It also includes a button to add a task to the database.
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
        }

        /**
         * @brief Input field for the due date of the task.
         */
        CustomTextField {
            id: dueDateField
            label: "Date"
            placeholder: "Date de fin"
            calendarButton.visible: true
        }

        /**
         * @brief Input field for the due time of the task.
         */
        CustomTextField {
            id: dueTimeField
            label: "Due Time"
            placeholder: "Enter due time"
        }


        /**
         * @brief Input field for the task description.
         */
        CustomTextField {
            id: description
            label: "Description"
            placeholder: "Description"
            inputFieldHeight: 100
        }

        /**
         * @brief Button to add a task.
         *
         * When clicked, the task data is added to the database.
         */
        Button {
            text: "Ajouter"
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                console.log("insertion dans la db")
                TaskStorage.addTask(taskNameField.text, dueDateField.text, "", description.text);
                stackView.pop();
            }
        }

    }

    /**
     * @brief Button to navigate to the settings page.
     *
     * When clicked, this button pushes the SettingsView.qml page onto the stack view.
     */
    Button {
        anchors.top: parent.top
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
    Button {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin : 10
        text: "Back"

        onClicked: {
            console.log("Settings button cliecked")
            stackView.pop()
        }
    }

}

