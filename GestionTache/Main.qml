/**
 * @file main.qml
 * @brief The main entry point for the application.
 *
 * This file defines the main window of the application and sets up the primary components including the
 * `StackView` for navigation and the `Settings` component. It also handles resizing of the main window.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material
import QtQuick.Layouts 6.7
import ".."

/**
 * @class ApplicationWindow
 * @brief The main window of the application.
 *
 * This window serves as the main container for the application. It includes a `StackView` for managing
 * navigation between different views and a `Settings` component for managing application settings.
 */
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

    /**
     * @brief The settings component of the application.
     *
     * Provides configuration options for the application. This instance can be used to access or modify
     * application settings.
     */
    Settings {
        id: settings
    }

    /**
     * @brief Connects the resizeWindow function to the resizeWindow signal from the current item in the StackView.
     *
     * This function is called when the current item in the `StackView` emits a `resizeWindow` signal, allowing
     * the main window's size to be adjusted dynamically.
     */
    Component.onCompleted: {
        stackView.currentItem.resizeWindow.connect(resizeWindow)
    }

    /**
     * @brief Resizes the main window to the specified width and height.
     *
     * @param newWidth The new width of the main window.
     * @param newHeight The new height of the main window.
     */
    function resizeWindow(newWidth, newHeight) {
        application.width = newWidth
        application.height = newHeight
    }
}
