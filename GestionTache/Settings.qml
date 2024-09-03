import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Controls.Material 2.15

QtObject {

    // Propriétés pour les settings
    property bool darkMode: false
    property int fontSize: 14
    property string fontFamily: "Arial"

    function toggleTheme() {
        darkMode = !darkMode
    }
}
