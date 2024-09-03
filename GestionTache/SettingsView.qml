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
    width: 400
    height: 400

    // property var settings: null  // variable maj dans le main

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
        Button {
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            text: "Back"
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

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 10

                /**
                 * @brief Checkbox to toggle dark mode.
                 *
                 * When checked, it changes the application's theme to dark mode.
                 */
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

        /**
         * @brief A group box for font-related settings.
         *
         * Contains controls for adjusting the font size and selecting the font family.
         */
        GroupBox {
            title: "Font Settings"
            Layout.fillWidth: true

            /**
             * @brief A row layout for adjusting the font size.
             *
             * Contains a label, slider for font size selection, and a text element showing the current size.
             */
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

                    /**
                     * @brief Slider to adjust the font size.
                     *
                     * Allows users to select a font size between 10 and 24.
                     */
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

                /**
                 * @brief A row layout for selecting the font family.
                 *
                 * Contains a label and a combo box for font family selection.
                 */
                RowLayout {
                    spacing: 10
                    Layout.fillWidth: true

                    Text {
                        text: "Font Family:"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    /**
                     * @brief ComboBox to select the font family.
                     *
                     * Allows users to choose from a predefined list of font families.
                     */
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
