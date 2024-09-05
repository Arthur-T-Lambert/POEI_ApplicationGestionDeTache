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
    id: root

    property bool darkMode: false
    property int fontSize: 10
    property string fontFamily: "Arial"

    /**
     * @function toggleTheme
     * @brief A function to toggle the application theme between light and dark modes.
     *
     * This function switches the `darkMode` property between `true` and `false`.
     */
    function toggleTheme() {
        settingsValues.darkMode = !settingsValues.darkMode
    }

    /**
     * @property palette
     * @brief A property that holds the current color palette for the application.
     *
     * Default value is `paletteLight`.
     */
    property Palette palette: settingsValues.darkMode ? paletteDark : paletteLight

    /**
     * @property paletteLight
     * @brief A readonly property that defines the color palette for light mode.
     *
     * The `Palette` object contains color definitions for various UI elements such as `buttonText`, `button`,
     * `window`, and `base`.
     */
    readonly property Palette paletteLight: Palette {
        buttonText: "black"
        button: "#C9C8C8"
        light : "#BFBEBE"
        window: "white"
        base: "#333333"
        alternateBase: "#242323"
        brightText: "black"
        highlight: "green"
        text: "black"
        highlightedText: "red"
    }

    /**
     * @property paletteDark
     * @brief A readonly property that defines the color palette for dark mode.
     *
     * The `Palette` object contains color definitions for various UI elements such as `buttonText`, `button`,
     * `window`, and `base`.
     */
    readonly property Palette paletteDark: Palette {
        buttonText: "white"
        button: "#2E2E2E"
        light : "#383838"
        window: "#282828"
        base: "#2E2E2E"
        alternateBase: "white"
        brightText: "white"
        highlight: "green"
        text: "white"
        highlightedText: "red"
    }
}
