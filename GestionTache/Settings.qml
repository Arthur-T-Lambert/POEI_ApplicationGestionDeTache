/**
 * @file Settings.qml
 * @brief A QML component that provides application settings such as theme and font customization.
 *
 * This component defines properties for managing application settings, such as dark mode, font size,
 * font family, and color palettes for light and dark themes. It includes a function to toggle the theme
 * between light and dark modes.
 */

import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material 2.15

QtObject {
    // Propriétés pour les settings
    property bool darkMode: false
    property int fontSize: 14
    property string fontFamily: "Arial"

    /**
     * @function toggleTheme
     * @brief A function to toggle the application theme between light and dark modes.
     *
     * This function switches the `darkMode` property between `true` and `false`.
     */
    function toggleTheme() {
        darkMode = !darkMode
    }

    /**
     * @property palette
     * @brief A property that holds the current color palette for the application.
     *
     * Default value is `paletteLight`.
     */
    property Palette palette: paletteLight

    /**
     * @property paletteLight
     * @brief A readonly property that defines the color palette for light mode.
     *
     * The `Palette` object contains color definitions for various UI elements such as `buttonText`, `button`,
     * `window`, and `base`.
     */
    readonly property Palette paletteLight: Palette {
        buttonText: "darkGreen"
        button: "lightBlue"
        window: "white"
        base: "red"
    }

    /**
     * @property paletteDark
     * @brief A readonly property that defines the color palette for dark mode.
     *
     * The `Palette` object contains color definitions for various UI elements such as `buttonText`, `button`,
     * `window`, and `base`.
     */
    readonly property Palette paletteDark: Palette {
        buttonText: "red"
        button: "DarkBlue"
        window: "black"
        base: "blue"
    }
}
