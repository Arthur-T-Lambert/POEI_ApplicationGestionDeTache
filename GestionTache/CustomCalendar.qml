/**
 * @file CustomCalendar.qml
 * @brief The main window of the calendar.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7

/**
 * @class CustomCalendar
 * @brief The customed view of a calendar.
 *
 * This window contains the user interface elements to display and select a date in a calendar.
 */
Window {
    id: calendarWindow
    width: 400
    height: 400
    visible: true
    title: qsTr("Calendar Example")

    property var selectedDate: new Date(2024, 9, 1) // Date par défaut
    property int selectedDay: selectedDate.getDate() // Numéro du jour

    /**
     * @signal dateSelected
     * @brief Signal emitted when a date is selected.
     * @param date The selected date on the calendar.
     */
    signal dateSelected(date selectedDate) // Signal pour la date

    ColumnLayout {
        spacing: 10
        anchors.fill: parent

        /**
         * @class RowLayout
         * @brief Horizontal layout for navigation buttons and month title.
         */
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 10

            /**
             * @brief Navigates to the previous month.
             */
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

            /**
             * @brief Navigates to the next month.
             */
            Button {
                text: ">"
                onClicked: {
                    let newDate = new Date(selectedDate)
                    newDate.setMonth(selectedDate.getMonth() + 1)
                    selectedDate = newDate
                }
            }
        }

        /**
         * @brief Displays the days of the week.
         */
        DayOfWeekRow {
            locale: gridCalendar.locale
            Layout.fillWidth: true
        }

        /**
         * @brief Displays the days of the month in a grid.
         */
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

            /**
             * @brief Emitted when the user clicks on a date.
             * @param date The clicked date.
             */
            onClicked: (date) => {
                selectedDate = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), date.getDate())
                dateSelected(selectedDate) // émission signal date sélectionnée
            }
        }

        /**
         * @brief Closes the calendar window when clicked.
         */
        Button {
            text: "OK"
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            onClicked: calendarWindow.close()
        }
    }


}
