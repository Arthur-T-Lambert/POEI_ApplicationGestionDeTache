/**
 * @file CustomTextField.qml
 * @brief A QML component that provides a labeled text input field.
 *
 * This component creates a custom text field with a label and a placeholder text.
 * It allows customization of the label, placeholder text, and input field height.
 */

import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material

/**
 * @class CustomTextField
 * @brief A custom text field component with a label and input field.
 *
 * This class creates a Rectangle that contains a label and a text input field.
 * It provides properties to customize the label text, placeholder text, and input field height.
 */
Rectangle {

    /**
     * @brief Default properties
     */
    property string label: "Label"
    property string placeholder: "Enter text"
    property int inputFieldHeight: 35

    id: textFieldWithLabel
    width: 300
    height: inputFieldHeight + 40
    radius: 8


    //SystemPalette { id: palette; colorGroup: SystemPalette.Active }
    //color: palette.window
    //border.color: palette.border
    border.width: 1
    anchors.horizontalCenter: parent.horizontalCenter

    /**
     * @class CustomTextFieldLayout
     * @brief A container for the label and text input field.
     *
     * This section contains a Label and a TextField, arranged vertically.
     */

    Column {
        anchors.fill: parent
        spacing: 5
        padding: 8

        /**
         * @brief Displays the label text above the input field.
         *
         * The text is bold and has a pixel size of 14.
         */
        Label {
            text: label
            //color: palette.windowText
            font.pixelSize: 14
            font.bold: true
        }

        /**
         * @brief The input field for user text input.
         *
         * This field displays a placeholder when empty, and its height is controlled by the `inputFieldHeight` property.
         */
        TextField {
            id: inputField
            width: parent.width - 16
            placeholderText: placeholder
            font.pixelSize: 16
            height: inputFieldHeight
        }
    }

}
