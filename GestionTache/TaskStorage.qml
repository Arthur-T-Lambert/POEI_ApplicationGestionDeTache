pragma Singleton

import QtQml
import QtQuick
import QtQuick.LocalStorage

QtObject {
    id: storage

    property var _db

    function _database()
    {
        if (_db) return _db

        try {
            let db = LocalStorage.openDatabaseSync("TaskList", "1.0", "TaskList app database")

            db.transaction(function (tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS tasks (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    title TEXT,
                    date STRING,
                    time STRING,
                    description TEXT,
                    done INTEGER
                )');
            })

            _db = db
        } catch (error) {
            console.log("Error opening database: " + error)
        };
        return _db
    }

    function addTask(title, date, time, description, done)
    {
        try {
            let results;
            storage._database().transaction(function(tx){
                tx.executeSql("INSERT INTO tasks (title, date, time,
                          description, done) VALUES(?,?,?,?,?);",
                              [title, date, time, description, done]);
                results = tx.executeSql("SELECT * FROM tasks ORDER BY id DESC LIMIT 1");
            });
            console.log(results);
            return results.rows.item(0).id;
        }
        catch(err) {
            console.error("Error executing INSERT request : " + err);
        }
        return -1;
    }

    function updateTask(id, title, date, time, description, done)
    {
        try {
            storage._database().transaction(function(tx) {
                tx.executeSql("UPDATE tasks set title=?, date=?, time=?,
                          description=? done=? WHERE id=?",
                              [title, date, time, description, done, id]);
            })
            return true;
        }
        catch(err) {
            console.error("Error executing UPDATE request : " + err);
        }
        return false;
    }

    function getTasks()
    {
        try {
            let tasks = []
            storage._database().transaction(function(tx){
                let results =  tx.executeSql("SELECT * FROM tasks ORDER BY date, time ASC")
                for (let i = 0; i < results.rows.length; i++) {
                    let row = results.rows.item(i)
                    tasks.push({
                                   "id" : row.id,
                                   "title" : row.title,
                                   "date" : row.date,
                                   "time" : row.time,
                                   "description" : row.description? row.description : "",
                                   "done" : (row.done === 0 ? false : true)
                               })
                }
            })
            return tasks;
        }
        catch(err) {
            console.error("Error executing SELECT request : " + err);
        }
        return [];
    }

    function deleteTasks() {
        try {
            storage._database().transaction(function(tx){
                tx.executeSql("DELETE FROM tasks")
            })
            return true;
        }
        catch(err) {
            console.error("Error executing DELETE request : " + err);
        }
        return false;
    }

    function deleteDoneTasks() {
        try {
            storage._database().transaction(function(tx){
                tx.executeSql("DELETE FROM tasks WHERE done = 1")
            })
            return true;
        }
        catch(err) {
            console.error("Error executing DELETE request : " + err);
        }
        return false;
    }

    function deleteTask(id) {
        try {
            storage._database().transaction(function (tx) {
                tx.executeSql("DELETE FROM tasks WHERE id = ?", [id])
            })
            return true;
        }
        catch(err) {
            console.error("Error executing DELETE request : " + err);
        }
        return false;
    }

    function updateTaskState(id, done) {
        try {
            storage._database().transaction(function (tx) {
                tx.executeSql("UPDATE tasks set done=? WHERE id=?", [done, id])
            })
            return true;
        }
        catch(err) {
            console.error("Error executing UPDATE request : " + err);
        }
        return false;
    }
}
