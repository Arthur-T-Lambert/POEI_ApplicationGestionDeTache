pragma Singleton

import QtQml
import QtQuick
import QtQuick.LocalStorage

QtObject {
    id: storage

    /** type:object the cached database, only to be accessed through functions
      */
    property var _db

    /** Access to the database : returns the cached database if already open, otherwise
      * opens it.
      * @return type:object the open database
      */
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

    /** Adds a new task to the database
      * @param type:string title the title (or name) of the task. mus tbe a non-empty string.
      * @param type:string date the due date of the task in the form "yyyy-mm-dd"
      * @param type:string time the due time in the day in the form "hh:mm". Can be an empty string,
                                in wich case the due time is assumed to be "23:59" (i.e. the last minute)
      * @param type:string description a brief descxription, or notes, about the task. Can be an empty string.
      * @param type:int done a boolean value (1 or 0) indicating if the task is done (probably 0 at creation...)
      * @return type:int the unique id of the created entry, or -1 if failure
      */
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

    /** Updates a given task in the database
      * @param type:int id the unique id of the entry in the database
      * @param type:string title the new title (or name) of the task. mus tbe a non-empty string.
      * @param type:string date the new due date of the task in the form "yyyy-mm-dd"
      * @param type:string time the new due time in the day in the form "hh:mm". Can be an empty string,
                                in wich case the due time is assumed to be "23:59" (i.e. the last minute)
      * @param type:string description a new brief descxription, or notes, about the task. Can be an empty string.
      * @param type:int done a boolean value (1 or 0) indicating if the task is done
      * @return type:bool true if success, false else
      */
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

    /** Obtain the complete list of tasks known. The tasks are sorted in due date ascending order.
      * @return type:object the array of task objects
      */
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

    /** completely clears the database. DO NOT DELETE the database itself
      * @return type:bool true if successful, false else
      */
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

    /** completely clears the database from tasks marked as done (completed)
      * @return type:bool true if successful, false else
      */
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

    /** removes the task of given id from the database.
      * @param type:int id the unique id of the task to be removed
      * @return type:bool true if successful, false else
      */
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

    /** Updates a given task in the database, but only on its completion status (done / not done)
      * @param type:int id the unique id of the entry in the database
      * @param type:int done a boolean value (1 or 0) indicating if the task is done
      * @return type:bool true if success, false else
      */
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
