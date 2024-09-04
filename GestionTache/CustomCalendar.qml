import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

Window {
    id: calendarWindow
    width: 400
    height: 400
    visible: true
    title: qsTr("Calendar Example")

    property var selectedDate: new Date(2024, 9, 1) // Date par défaut
    property int selectedDay: selectedDate.getDate() // Numéro du jour

    signal dateSelected(date selectedDate) // Signal pour la date

    ColumnLayout {
        spacing: 10
        anchors.fill: parent

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            Button {
                text: "<"
                onClicked: {
                    let newDate = new Date(selectedDate)
                    newDate.setMonth(selectedDate.getMonth() - 1)
                    selectedDate = newDate
                }
            }

            Text {
                text: Qt.formatDateTime(selectedDate, "MMMM yyyy")
                font.pixelSize: 20
            }

            Button {
                text: ">"
                onClicked: {
                    let newDate = new Date(selectedDate)
                    newDate.setMonth(selectedDate.getMonth() + 1)
                    selectedDate = newDate
                }
            }
        }

        DayOfWeekRow {
            locale: gridCalendar.locale
            Layout.fillWidth: true
        }

        MonthGrid {
            id: gridCalendar
            month: selectedDate.getMonth()
            year: selectedDate.getFullYear()
            locale: Qt.locale("en_US")
            Layout.fillWidth: true
            delegate: Text {
                opacity: month === gridCalendar.month ? 1 : 0.2
                text: day
                font: gridCalendar.font
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: -5
                    radius: 25
                    color: "blue"
                    opacity: 0.2
                    visible: selectedDate.getDate() === date.getDate()
                }
            }

            onClicked: (date) => {
                selectedDate = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), date.getDate())
                dateSelected(selectedDate) // émission signal date sélectionnée
            }
        }

        Button {
            text: "OK"
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            onClicked: calendarWindow.close()
        }
    }


}
