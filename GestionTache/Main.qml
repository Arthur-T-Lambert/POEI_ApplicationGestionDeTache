import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material
import QtQuick.Layouts 6.7
import "tasklist.js" as Database
import ".."

Window {
    id: application
    width: 640
    height: 480
    visible: true
    title: qsTr("Gestion de Tâches")

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: TaskListPage {}
    }

    Settings {
        id: settings
    }
}
