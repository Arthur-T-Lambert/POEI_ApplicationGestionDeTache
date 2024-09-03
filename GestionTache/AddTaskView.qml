import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material
import "tasklist.js" as Database


Rectangle {
    //Settings {id: settingsPage}
    //TODO lien avec BDD
    //signal addTaskSignal(string name, string dueDate, string description)

    width: parent.width
    height: parent.height
    //color: palette.window
    //anchors.fill: parent

    Column {
        spacing: 20
        padding: 20
        anchors.centerIn: parent

        CustomTextField {
            id: taskNameField
            label: "Task Name"
            placeholder: "Enter task name"
        }

        CustomTextField {
            id: dueDateField
            label: "Due Date"
            placeholder: "Enter due date"
        }

        CustomTextField {
            id: dueTimeField
            label: "Due Time"
            placeholder: "Enter due time"
        }

        CustomTextField {
            id: description
            label: "Task Description"
            placeholder: "Enter description"
            inputFieldHeight: 100
        }

        Button {
            text: "Add Task"
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                console.log("insertion dans la db")
                //Database.add(taskNameField.text, dueDateField.text, dueTimeField.text, description.text, true)
            }
        }

    }

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
    //TODO back button et stackview
    // Button {
    //     text: "Settings"
    //     anchors.top: parent.top
    //     anchors.right: parent.right
    //     onClicked: stackView.push(settingsPage)  // Affiche la page des paramètres
    // }

}

