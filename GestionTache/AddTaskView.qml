import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material



Rectangle {
    //Settings {id: settingsPage}
    //TODO lien avec BDD
    //signal addTaskSignal(string name, string dueDate, string description)

    width: parent.width
    height: parent.height
    //color: palette.window
    anchors.fill: parent

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
                //TODO
            }
        }
        Button {
            //text: settingsPage.darkMode ? "Switch to Light Mode" : "Switch to Dark Mode"
            onClicked: {
                //settingsPage.toggleTheme()
            }
            anchors.horizontalCenter: parent.horizontalCenter
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

