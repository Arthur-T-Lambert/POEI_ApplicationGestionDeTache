import QtQuick 6.7
import QtQuick.Controls 6.7
import QtQuick.Layouts 6.7
import "tasklist.js" as Database

Window {
    id: application
    width: 640
    height: 480
    visible: true
    title: qsTr("Gestion de Tâches")

    property Palette palette: paletteLight
    readonly property Palette paletteLight: Palette {
        buttonText: "darkGreen"
        button: "lightBlue"
        window: "white"
        base: "red"
    }
    readonly property Palette paletteDark: Palette {
        buttonText: "red"
        button: "DarkBlue"
        window: "black"
        base: "blue"
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        width: 400
        spacing: 15

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
