import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7
import QtQuick.Controls.Material
import "tasklist.js" as Database

Page {
    id: mainPage
    anchors.fill: parent
    signal resizeWindow(width: int, height: int)

    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 50

        Button {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "Add new"

            onClicked: {
                console.log("Add new button clicked")
                mainPage.resizeWindow(600, 600)
                stackView.push(Qt.resolvedUrl("AddTaskView.qml"))
            }
        }
        Button {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            text: "Settings"

            onClicked: {
                console.log("Settings button cliecked")
                stackView.push(Qt.resolvedUrl("SettingsView.qml"))
            }
        }
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: header.bottom
        anchors.topMargin: 10
        width: 400
        spacing: 15

        //Correction Masoo mais ça marche pas :(
        // anchors.left: parent.left
        // anchors.right: parent.right
        // anchors.leftMargin: 30
        // anchors.rightMargin: 30
        // anchors.top: header.bottom
        // anchors.topMargin: 10
        // spacing: 15

        TaskList {
            maxHeight: 300
            width: parent.width
            taskModel: tasksModelToday
        }
        TaskList {
            maxHeight: 300
            width: parent.width
            taskModel: tasksModelWeek
        }
        TaskList {
            maxHeight: 300
            width: parent.width
            taskModel: tasksModelLater
        }
    }

    ListModel {
        id : tasksModelToday
    }
    ListModel {
        id : tasksModelWeek
    }
    ListModel {
        id : tasksModelLater
    }

    Item {
        id: tasks

        function updated() {
            console.log("tasks updated")

            tasksModelToday.clear();
            let taskListToday = Database.todayTaskList();
            for ( let i = 0; i < taskListToday.length; i++ ) {
                tasksModelToday.append({
                    "id": taskListToday[i].id,
                    "title": taskListToday[i].title,
                    "date": taskListToday[i].date,
                    "time": taskListToday[i].time,
                    "description": taskListToday[i].description,
                    "done": taskListToday[i].done
                })
            }

            tasksModelWeek.clear();
            let taskListWeek = Database.todayTaskList();
            for ( let j = 0; j < taskListWeek.length; j++ ) {
                tasksModelToday.append({
                    "id": taskListWeek[j].id,
                    "title": taskListWeek[j].title,
                    "date": taskListWeek[j].date,
                    "time": taskListWeek[j].time,
                    "description": taskListWeek[j].description,
                    "done": taskListWeek[j].done
                })
            }

            tasksModelLater.clear();
            let taskListLater = Database.todayTaskList();
            for ( let k = 0; k < taskListLater.length; k++ ) {
                tasksModelLater.append({
                    "id": taskListLater[k].id,
                    "title": taskListLater[k].title,
                    "date": taskListLater[k].date,
                    "time": taskListLater[k].time,
                    "description": taskListLater[k].description,
                    "done": taskListLater[k].done
                })
            }
        }
    }

    Component.onCompleted: Database.init();
}
