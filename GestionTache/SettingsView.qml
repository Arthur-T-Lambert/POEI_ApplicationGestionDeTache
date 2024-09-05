/**
 * @file SettingsPage.qml
 * @brief A QML component that provides a user interface for adjusting application settings.
 *
 * This component defines a page with settings for toggling the dark mode, adjusting the font size,
 * and selecting the font family. It also includes a back button to navigate away from the settings page.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts
import ".."


Page {
    width: 400 + settings.fontSize * 5
    height: 400
    background: Rectangle {
        color: settings.palette.window
    }

    /**
     * @class SettingsLayout
     * @brief A layout container for the settings controls.
     *
     * This section contains a back button and settings grouped by theme and font settings.
     */
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        /**
         * @brief Button to navigate back in the stack view.
         *
         * When clicked, this button pops the current view from the stack view.
         */
        CustomButton {
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            text: "Retour"
            onClicked: {
                console.log("Back button clicked")
                stackView.pop()
            }
        }

        /**
         * @class ThemeGroup
         * @brief A group box for theme-related settings.
         *
         * Contains controls for toggling dark mode.
         */
        GroupBox {
            title: "Theme"
            Layout.fillWidth: true

            background: Rectangle {
                y: parent.topPadding - parent.bottomPadding
                width: parent.width
                height: parent.height - parent.topPadding + parent.bottomPadding
                color: "transparent"
                border.color: settings.palette.alternateBase
                radius: 2
            }
            label: Label {
                x: parent.leftPadding
                width: parent.availableWidth
                text: parent.title
                font.bold: true
                font.pointSize: settings.fontSize
                font.family: settings.fontFamily
                color: settings.palette.text
                elide: Text.ElideRight
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                /**
                 * @brief Checkbox to toggle dark mode.
                 *
                 * When checked, it changes the application's theme to dark mode.
                 */
                CheckBox {
                    property bool init: false

                    onCheckedChanged: {
                        if (init) {
                            settings.toggleTheme()
                            console.log("Settings darkmode :", settings.darkMode)
                        }
                    }

                    Component.onCompleted: {
                        checked = settings.darkMode
                        init = true
                    }
                }

                Text {
                    text: "Mode sombre"
                    font.pointSize: settings.fontSize
                    font.family: settings.fontFamily
                    color: settings.palette.text
                }
            }
        }

        /**
         * @brief A group box for font-related settings.
         *
         * Contains controls for adjusting the font size and selecting the font family.
         */
        GroupBox {
            title: "Paramètre de la police"
            Layout.fillWidth: true

            background: Rectangle {
                y: parent.topPadding - parent.bottomPadding
                width: parent.width
                height: parent.height - parent.topPadding + parent.bottomPadding
                color: "transparent"
                border.color: settings.palette.alternateBase
                radius: 2
            }
            label: Label {
                x: parent.leftPadding
                width: parent.availableWidth
                text: parent.title
                font.bold: true
                font.pointSize: settings.fontSize
                font.family: settings.fontFamily
                color: settings.palette.text
                elide: Text.ElideRight
            }

            /**
             * @brief A row layout for adjusting the font size.
             *
             * Contains a label, slider for font size selection, and a text element showing the current size.
             */
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                ColumnLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: "Taille de la police:"
                        font.pointSize: settings.fontSize
                        font.family: settings.fontFamily
                        color: settings.palette.text
                        Layout.alignment: Qt.AlignVCenter
                    }

                    RowLayout
                    {
                        /**
                         * @brief Slider to adjust the font size.
                         *
                         * Allows users to select a font size between 8 and 16.
                         */
                        Slider {
                            id: fontSizeSlider
                            from: 8
                            to: 16
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
                            font.pointSize: settings.fontSize
                            font.family: settings.fontFamily
                            color: settings.palette.text
                        }
                    }
                }

                /**
                 * @brief A row layout for selecting the font family.
                 *
                 * Contains a label and a combo box for font family selection.
                 */
                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: "Type de police:"
                        Layout.alignment: Qt.AlignVCenter
                        font.pointSize: settings.fontSize
                        font.family: settings.fontFamily
                        color: settings.palette.text
                    }

                    /**
                     * @brief ComboBox to select the font family.
                     *
                     * Allows users to choose from a predefined list of font families.
                     */
                    ComboBox {
                        id: fontComboBox
                        font.pointSize: settings.fontSize
                        font.family: settings.fontFamily
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
