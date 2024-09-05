/**
 * @file MainPage.qml
 * @brief The main page of the application that displays task lists and provides navigation controls.
 *
 * This component defines the main page layout of the application, including a header with navigation buttons,
 * sections for different task lists, and functionality to update task data from the database.
 */
import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7
import QtQuick.Controls.Material

Page {
    id: mainPage
    background: Rectangle {
        color: settings.palette.window
    }

    /**
     * @brief Signal emitted when the window size needs to be resized.
     * @param width The new width of the window.
     * @param height The new height of the window.
     */
    signal resizeWindow(width: int, height: int)

    /**
     * @brief A rectangle that contains navigation buttons.
     *
     * Provides buttons for adding new tasks and navigating to the settings page.
     */
    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
        color: settings.palette.window

        /**
         * @brief A button to navigate to the "Add Task" view.
         *
         * When clicked, resizes the window and navigates to the "AddTaskView.qml" page.
         */
        CustomButton {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "Nouvelle tâche"

            onClicked: {
                console.log("Add new button clicked")
                mainPage.resizeWindow(600, 600)
                stackView.push(Qt.resolvedUrl("AddTaskView.qml"))
            }
        }

        /**
         * @class SettingsButton
         * @brief A button to navigate to the settings page.
         *
         * When clicked, navigates to the "SettingsView.qml" page.
         */
        CustomButton {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            text: "Paramètres"

            onClicked: {
                console.log("Settings button cliecked")
                stackView.push(Qt.resolvedUrl("SettingsView.qml"))
            }
        }
    }

    /**
     * @class TaskLists
     * @brief A column layout for displaying task lists.
     *
     * Contains sections for tasks categorized by today, this week, and later.
     */
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 10
        width: 400
        spacing: 15

        /**
         * @brief A task list for tasks due today.
         */
        TaskList {
            title: "Aujourd'hui"
            maxHeight: 300
            width: parent.width
            taskModel: tasksModelToday
        }

        /**
         * @brief A task list for tasks due this week.
         */
        TaskList {
            title: "Cette semaine"
            maxHeight: 300
            width: parent.width
            taskModel: tasksModelWeek
        }

        /**
         * @brief A task list for tasks due later.
         */
        TaskList {
            title: "Plus tard"
            maxHeight: 300
            width: parent.width
            taskModel: tasksModelLater
        }
    }

    /**
     * @brief Model for tasks due today.
     */
    ListModel {
        id : tasksModelToday
    }

    /**
     * @brief Model for tasks due this week.
     */
    ListModel {
        id : tasksModelWeek
    }

    /**
     * @brief Model for tasks due later.
     */
    ListModel {
        id : tasksModelLater
    }

    /**
     * @brief An item responsible for updating the task models.
     *
     * Retrieves tasks from the database and updates the task models accordingly.
     */
    Item {
        id: updateTaskList

        /**
         * @brief Updates the task models with data from the database.
         *
         * Clears existing task models and populates them with the latest data for tasks due today, this week, and later.
         */
        function updated() {
            console.log("tasks updated")

            tasksModelToday.clear();
            let taskListToday = TaskStorage.getTodayTasks();
            for ( let i = 0; i < taskListToday.length; i++ ) {
                tasksModelToday.append({
                    "db_id": taskListToday[i].id,
                    "title": taskListToday[i].title,
                    "date": taskListToday[i].date,
                    "time": taskListToday[i].time,
                    "description": taskListToday[i].description,
                    "done": taskListToday[i].done
                })
            }

            tasksModelWeek.clear();
            let taskListWeek = TaskStorage.getNextWeekTasks();
            for ( let j = 0; j < taskListWeek.length; j++ ) {
                tasksModelWeek.append({
                    "db_id": taskListWeek[j].id,
                    "title": taskListWeek[j].title,
                    "date": taskListWeek[j].date,
                    "time": taskListWeek[j].time,
                    "description": taskListWeek[j].description,
                    "done": taskListWeek[j].done
                })
            }

            tasksModelLater.clear();
            let taskListLater = TaskStorage.getLaterTasks();
            for ( let k = 0; k < taskListLater.length; k++ ) {
                tasksModelLater.append({
                    "db_id": taskListLater[k].id,
                    "title": taskListLater[k].title,
                    "date": taskListLater[k].date,
                    "time": taskListLater[k].time,
                    "description": taskListLater[k].description,
                    "done": taskListLater[k].done
                })
            }
        }

        Connections {
            target: TaskStorage

            function onTaskListUpdated() {
                console.log("Slot !");
                updateTaskList.updated();
            }
        }

    }

    /**
     * @brief Updates the database when the component is completed.
     */
    Component.onCompleted: updateTaskList.updated();
}
