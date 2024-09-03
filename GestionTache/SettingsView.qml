import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts
import ".."


Page {
    width: 400
    height: 400

    // property var settings: null  // variable maj dans le main

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Button {
            // anchors.top: parent.top
            // anchors.left: parent.left
            //anchors.leftMargin : 10
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            text: "Back"

            onClicked: {
                console.log("Settings button cliecked")
                stackView.pop()
            }
        }

        GroupBox {
            title: "Theme"
            Layout.fillWidth: true

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                CheckBox {
                    text: "Dark Mode"
                    checked: settings.darkMode
                    onCheckedChanged: {

                        settings.toggleTheme()
                        console.log(settings.darkMode)
                    }
                }
            }
        }

        GroupBox {
            title: "Font Settings"
            Layout.fillWidth: true

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: "Font Size:"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Slider {
                        id: fontSizeSlider
                        from: 10
                        to: 24
                        stepSize: 1
                        value: settings.fontSize
                        onValueChanged: {
                            settings.fontSize = value
                            console.log(settings.fontSize)
                        }
                        Layout.fillWidth: true
                    }

                    Text {
                        text: settings.fontSize.toString()
                        Layout.alignment: Qt.AlignVCenter

                    }
                }

                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: "Font Family:"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    ComboBox {
                        id: fontComboBox
                        font.pointSize: 10
                        padding: 2
                        model: ["Arial", "Courier New", "Times New Roman", "Verdana"]
                        currentIndex: 0  // Police par défaut
                        onCurrentTextChanged: {
                            settings.fontFamily = currentText
                            console.log(settings.fontFamily)

                        }
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
