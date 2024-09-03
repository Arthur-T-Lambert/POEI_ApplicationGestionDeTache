import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Window {
    id: application
    width: 640
    height: 480
    visible: true
    title: qsTr("Gestion de Tâches")

    property Palette palette: paletteLight
    readonly property Palette paletteLight: Palette {
        buttonText: "darkGreen"
        button: "lightBlue"
        window: "white"
        base: "red"
    }
    readonly property Palette paletteDark: Palette {
        buttonText: "red"
        button: "DarkBlue"
        window: "black"
        base: "blue"
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 400
        spacing: 15

        TaskList {
            maxHeight: 300
            width: parent.width
        }
        TaskList {
            maxHeight: 300
            width: parent.width
        }
        TaskList {
            maxHeight: 300
            width: parent.width
        }
    }
}
