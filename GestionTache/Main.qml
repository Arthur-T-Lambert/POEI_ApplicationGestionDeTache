import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material
import ".."

ApplicationWindow {
    visible: true
    width: 600
    height: 600
    title: "Add Task"

    //TODO add stackview

    // Settings {
    //     id: settings

    // }

    AddTaskView {
        id: addTaskView
    }

    // SettingsView {
    //     settings: settings
    // }

}
