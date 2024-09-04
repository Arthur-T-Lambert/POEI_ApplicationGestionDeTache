pragma Singleton

import QtQml
import QtQuick
import QtQuick.LocalStorage

QtObject {
    id: storage

    /** type:object the cached database, only to be accessed through functions
      */
    property var _db

    /** type:object the cached task list, to avoid multiple accesses to the database if not necessary
      */
    property var _tl

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

    function _taskList()
    {
        if ( _tl ) {
            console.log("_taskList() cached");
            return _tl;
        }

        try {
            _tl = []
            storage._database().transaction(function(tx){
                let results =  tx.executeSql("SELECT * FROM tasks ORDER BY date, time ASC")
                for (let i = 0; i < results.rows.length; i++) {
                    let row = results.rows.item(i);
                    _tl.push({ "id" : row.id,
                               "title" : row.title,
                               "date" : row.date,
                               "time" : row.time,
                               "description" : row.description? row.description : "",
                               "done" : (row.done === 0 ? false : true)
                             });
                }
            })
            console.log("_taskList() updated");
            return _tl;
        }
        catch(err) {
            console.error("Error executing SELECT request : " + err);
        }
        return [];
    }

    signal taskListUpdated()

    /** Adds a new task to the database. At creation the task is always not completed.
      * @param type:string title the title (or name) of the task. mus tbe a non-empty string.
      * @param type:string date the due date of the task in the form "yyyy-mm-dd"
      * @param type:string time the due time in the day in the form "hh:mm". Can be an empty string,
                                in wich case the due time is assumed to be "23:59" (i.e. the last minute)
      * @param type:string description a brief descxription, or notes, about the task. Can be an empty string.
      * @return type:int the unique id of the created entry, or -1 if failure
      */
    function addTask(title, date, time, description)
    {
        if (   typeof title !== "string"
            || typeof date !== "string"
            || typeof time !== "string"
            || typeof description !== "string" ) {
            console.error("invalid parameter to addTask()");
            return -1;
        }
        if ( title === "" ) {
            console.error("empty title in addTask()");
            return -1;
        }
        // Checks that the date is valid - not perfect (accepts Feb 30) but good enough
        let ms = Date.parse(date);
        if ( isNaN(ms) ) {
            console.error("invalid date in addTask()");
            return -1;
        }
        // convert to canonical form
        let d = new Date(ms);
        date = d.toLocaleDateString(Qt.locale("fr_FR"), "yyyy-MM-dd");

        if ( time === "" ) {
            time = "23:59";
        }
        else {
            // Regular expression for the format "hh:mm"
            let re = /^([01][0-9]|2[0-3])\:[0-5][0-9]$/;
            if ( ! re.match(time) ) {
                console.error("invalid time if addTask()");
                return -1;
            }
        }

        // clears the taskList cache, as it will be no more valid
        _tl = null;
        try {
            let results;
            storage._database().transaction(function(tx){
                tx.executeSql("INSERT INTO tasks (title, date, time,
                          description, done) VALUES(?,?,?,?,?);",
                              [title, date, time, description, 0]);
                results = tx.executeSql("SELECT * FROM tasks ORDER BY id DESC LIMIT 1");
            });
            console.log(results);
            taskListUpdated();
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
      * @return type:bool true if success, false else
      */
    function updateTask(id, title, date, time, description)
    {
        // clears the taskList cache, as it will be no more valid
        _tl = null;
        try {
            storage._database().transaction(function(tx) {
                tx.executeSql("UPDATE tasks set title=?, date=?, time=?,
                          description=? WHERE id=?",
                              [title, date, time, description, id]);
            })
            taskListUpdated();
            return true;
        }
        catch(err) {
            console.error("Error executing UPDATE request : " + err);
        }
        return false;
    }

    /** Updates a given task in the database, but only on its completion status (done / not done)
      * @param type:int id the unique id of the entry in the database
      * @param type:int done a boolean value (1 or 0) indicating if the task is done
      * @return type:bool true if success, false else
      */
    function updateTaskState(id, done)
    {
        // clears the taskList cache, as it will be no more valid
        _tl = null;
        try {
            storage._database().transaction(function (tx) {
                tx.executeSql("UPDATE tasks set done=? WHERE id=?", [done, id])
            })
            taskListUpdated();
            return true;
        }
        catch(err) {
            console.error("Error executing UPDATE request : " + err);
        }
        return false;
    }

    /** completely clears the database. DO NOT DELETE the database itself
      * @return type:bool true if successful, false else
      */
    function deleteTasks() {
        // clears the taskList cache, as it will be no more valid
        _tl = null;
        try {
            storage._database().transaction(function(tx){
                tx.executeSql("DELETE FROM tasks")
            })
            taskListUpdated();
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
        // clears the taskList cache, as it will be no more valid
        _tl = null;
        try {
            storage._database().transaction(function(tx){
                tx.executeSql("DELETE FROM tasks WHERE done = 1")
            })
            taskListUpdated();
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
        // clears the taskList cache, as it will be no more valid
        _tl = null;
        try {
            storage._database().transaction(function (tx) {
                tx.executeSql("DELETE FROM tasks WHERE id = ?", [id])
            })
            taskListUpdated();
            return true;
        }
        catch(err) {
            console.error("Error executing DELETE request : " + err);
        }
        return false;
    }

    /** Obtain the complete list of tasks known. The tasks are sorted in due date ascending order.
      * @return type:object the list (array) of task objects
      */
    function getAllTasks()
    {
        return _taskList();
    }

    /** Obtain the list of tasks due today or before. The tasks are sorted in due date ascending order.
      * @return type:object the list (array) of task objects
      */
    function getTodayTasks()
    {
        let taskList = _taskList();
        if ( !taskList || taskList === [] ) {
            return [];
        }

        let todayTasks = [];
        let todayStr = new Date().toLocaleString(Qt.locale("fr_FR"), "yyyy-MM-dd");
        console.log("getTodayTasks() " + todayStr);
        for ( let i = 0; i < taskList.length; i++ ) {
            if ( taskList[i].date <= todayStr ) {
                todayTasks.push(taskList[i]);
            }
        }

        return todayTasks;
    }

    /** Obtain the list of tasks due next week. The tasks are sorted in due date ascending order.
      * @return type:object the list (array) of task objects
      */
    function getNextWeekTasks()
    {
        let taskList = _taskList();
        if ( !taskList || taskList === [] ) {
            return [];
        }

        let nextWeekTasks = [];
        let today = new Date();
        let todayStr = today.toLocaleString(Qt.locale("fr_FR"), "yyyy-MM-dd");
        let nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 7, 23, 59);
        let nextWeekStr = nextWeek.toLocaleDateString(Qt.locale("fr_FR"), "yyyy-MM-dd");
        console.log("getNextWeekStr() " + nextWeekStr);
        for ( let i = 0; i < taskList.length; i++ ) {
            if ( taskList[i].date > todayStr
                 && taskList[i].date <= nextWeekStr ) {
                nextWeekTasks.push(taskList[i]);
            }
        }

        return nextWeekTasks;
    }

    /** Obtain the list of tasks due later than next week. The tasks are sorted in due date ascending order.
      * @return type:object the list (array) of task objects
      */
    function getLaterTasks()
    {
        let taskList = _taskList();
        if ( !taskList || taskList === [] ) {
            return [];
        }

        let laterTasks = [];
        let today = new Date();
        let nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 7, 23, 59);
        let nextWeekStr = nextWeek.toLocaleDateString(Qt.locale("fr_FR"), "yyyy-MM-dd");
        console.log("getLaterTasks() " + nextWeekStr)
        for ( let i = 0; i < taskList.length; i++ ) {
            if ( taskList[i].date > nextWeekStr ) {
                laterTasks.push(taskList[i]);
            }
        }

        return laterTasks;
    }

    function dump()
    {
        let taskList = _taskList();

        for ( let i = 0; i < taskList.length; i++ ) {
            console.log(taskList[i].id + " : "+ taskList[i].title + " " + taskList[i].date + " " + taskList[i].time + " " + taskList[i].done);
        }

    }
}
