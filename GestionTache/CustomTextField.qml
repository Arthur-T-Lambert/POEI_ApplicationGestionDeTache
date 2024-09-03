import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material

Rectangle {

    property string label: "Label"
    property string placeholder: "Enter text"
    property int inputFieldHeight: 30

    id: textFieldWithLabel
    width: 300
    height: inputFieldHeight + 40
    radius: 8

    //SystemPalette { id: palette; colorGroup: SystemPalette.Active }
    //color: palette.window
    //border.color: palette.border
    border.width: 1
    anchors.horizontalCenter: parent.horizontalCenter

    Column {
        anchors.fill: parent
        spacing: 5
        padding: 8

        Label {
            text: label
            //color: palette.windowText
            font.pixelSize: 14
            font.bold: true
        }

        TextField {
            id: inputField
            width: parent.width - 16
            placeholderText: placeholder
            padding: 10
            font.pixelSize: 16
            height: inputFieldHeight
        }
    }

}
