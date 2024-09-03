
/** @property _taskList
  * @brief This property is always up-to-date with the complete current list of tasks,
  *   including at the start of the application. It is updated automatically by each
  *   update of the task list, in parallel with the persistent database. Therefore,
  *   at the start of the application, it will contain the correct list, as memorized
  *   the last time the application was used.
  */
var _taskList = [];

/** @fn init()
  * @brief This function is to be called once at the start of application to initialize
  *   the database and synchronize it with the internal storage('_taskList')
  */
function init()
{
    // Synchronize the internal storage
    _taskList = TaskStorage.getTasks();
    // "Signals" the task list has been updated
    tasks.updated();
}

/** @fn add(title, date, time, description, done)
  * @brief add a new task to the database, initialised with all the needed data
  * @param type:string title : the title of the task (any non-empty string)
  * @param type:string date : the due date of the task, in the form "yyyy-mm-dd"
  * @param type:string time : the due time in the day, in the form "hh:mm" or
  *                           an empty string, in which case the time will take the value "23:59"
  * @param type:string description : a description, or notes, attached to the task (can be an empty
  *                                  string)
  * @param type:bool done : a boolean indicating if the task has been completed
  * @return type:int id : the unique id of the taks just created, or -1 if failed.
  */
function add(title, date, time, description, done)
{
    let id = 0;
    // small type check to compensate for the lack of it in js...
    if (   typeof title == "string"
        && title !== ""
        && typeof done == "boolean"
        && typeof date == "string"
        && typeof time == "string"
        && typeof description == "string") {
        if ( time === "" ) {
            time = "23:59";
        }
        // check for correct format of date and time
        // WARNING ! This is not ok, nothing prevents to enter month 19, for example.
        let dateRegexp = /^[0-9]{4}\-[01][0-9]\-[0-3][0-9]$/;
        let timeRegexp = /^[0-2][0-9]\:[0-5][0-9]$/;
        if (   dateRegexp.test(date)
            && timeRegexp.test(time) ) {
            // update the db
            id = TaskStorage.addTask(title, date, time, description, (done ? 1 : 0));
            // sync with local storage
            _taskList = TaskStorage.getTasks();
            // signals the update
            tasks.updated();
            return id;
        }
        else {
            console.error("TaskList.add() : date or time do not match formats \"yyyy-mm-dd\" or \"hh:mm\"");
        }
        console.error("TaskList.add() : one of the param has not the correct type")
    }
    return -1;
}

/** @fn update(id, title, date, time, description, done)
  * @brief updates a task of a given id
  * @param type:int id : the id of the task to update
  * @param type:string title : the title of the task (any non-empty string)
  * @param type:string date : the due date of the task, in the form "yyyy-mm-dd"
  * @param type:string time : the due time in the day, in the form "hh:mm" or
  *                      an empty string, in which case the time will take the value "23:59"
  * @param type:string description : a description, or notes, attached to the task (can be an empty
  *                               string)
  * @param type:bool done : a boolean indicating if the task has been completed
  * @return type:bool : 'true' if success, 'false' if failed.
  */
function update(id, title, date, time, description, done)
{
    // small type check to compensate for the lack of it in js...
    if (   typeof title == "string"
        && title !== ""
        && typeof done == "boolean"
        && typeof date == "string"
        && typeof time == "string"
        && typeof description == "string") {
        if ( time === "" ) {
            time = "23:59";
        }
        // check for correct format of date and time
        // WARNING ! This is not ok, nothing prevents to enter month 19, for example.
        let dateRegexp = /^[0-9]{4}\-[01][0-9]\-[0-3][0-9]$/;
        let timeRegexp = /^[0-2][0-9]\:[0-5][0-9]$/;
        if (   dateRegexp.test(date)
            && timeRegexp.test(time) ) {
            // update the db
            if ( TaskStorage.updateTask(id, title, date, time, description, (done ? 1 : 0) ) ) {
                // sync with local storage
                _taskList = TaskStorage.getTasks();
                // signals the update
                tasks.updated();
                return true;
            }
            else {
                console.error("TaskList.update() : updateTask() returned false.");
            }
        }
        else {
            console.error("TaskList.update() : date or time do not match formats \"yyyy-mm-dd\" or \"hh:mm\"");
        }
        console.error("TaskList.update() : one of the param has not the correct type")
    }
    return false;
}

/** @fn updateStatus(id, done)
  * @brief updates a task of a given id, but only the status (done or not done)
  * @param type:int id : the id of the task to update
  * @param type:bool done : a boolean indicating if the task has been completed
  * @return type:bool : 'true' if success, 'false' if failed.
  */
function updateStatus(id, title, date, time, description, done)
{
    // small type check to compensate for the lack of it in js...
    if ( typeof done == "boolean" ) {
        if ( TaskStorage.updateTaskStatus(id, (done ? 1 : 0) ) ) {
            // sync with local storage
            _taskList = TaskStorage.getTasks();
            // signals the update
            tasks.updated();
            return true;
        }
        else {
            console.error("TaskList.update() : updateTask() returned false.");
        }
        console.error("TaskList.update() : one of the param has not the correct type")
    }
    return false;
}

/** @fn completeTaskList()
  * @brief Simple accessor to the internal storage of the task list (which is a mirror
  *        to the persistent task list database)
  * @return type:object[] complete known task list
  */
function completeTaskList()
{
    return _taskList;
}

/** @fn todayTaskList()
  * @brief Returns the task list, but only the tasks which due date is today or a former date
  * @return type:object[] partial task list
  */
function todayTaskList()
{
    let todayTasks = [];

    let today = new Date().toLocaleString(Qt.locale("fr_FR"), "yyyy-MM-dd");
    console.log("today = " + today);
    for ( let i = 0; i < _taskList.length; i++ ) {
        if ( _taskList[i].date <= today ) {
            todayTasks.push({"id": _taskList[i].id,
                             "title": _taskList[i].title,
                             "date": _taskList[i].date,
                             "time": _taskList[i].time,
                             "description": _taskList[i].description,
                             "done": _taskList[i].done,
                            });
        }
    }
    console.log("tasks due today or before :" + todayTasks.length)
    return todayTasks;
}

/** @fn nextWeekTaskList()
  * @brief Returns the task list, but only the tasks which due date is next week
  * @return type:object[] partial task list
  */
function nextWeekTaskList()
{
    let nextWeekTasks = [];

    let today = new Date();
    today.setHours(23); today.setMinutes(59);
    let todayStr = today.toLocaleDateString(Qt.locale("fr_FR"), "yyyy-MM-dd");
    console.log("today : " + todayStr)
    let nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDay() + 7, 23, 59);
    let nextWeekStr = nextWeek.toLocaleDateString(Qt.locale("fr_FR"), "yyyy-MM-dd");
    console.log("next week = " + nextWeekStr);
    for ( let i = 0; i < _taskList.length; i++ ) {
        if ( _taskList[i].date > todayStr
             && _taskList[i].date <= nextWeekStr ) {
            nextWeekTasks.push({"id": _taskList[i].id,
                                "title": _taskList[i].title,
                                "date": _taskList[i].date,
                                "time": _taskList[i].time,
                                "description": _taskList[i].description,
                                "done": _taskList[i].done,
                               });
        }
    }
    console.log("tasks due next week :" + nextWeekTasks.length)
    return nextWeekTasks;
}

/** @fn laterTaskList()
  * @brief Returns the task list, but only the tasks which due date is later than the next week
  * @return type:object[] partial task list
  */
function laterTaskList()
{
    let laterTasks = [];

    let today = new Date()
    let nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDay() + 7, 23, 59);
    let nextWeekStr = nextWeek.toLocaleDateString(Qt.locale("fr_FR"), "yyyy-MM-dd");
    console.log("today = " + today);
    console.log("next week = " + nextWeekStr);
    for ( let i = 0; i < _taskList.length; i++ ) {
        if ( _taskList[i].date > nextWeekStr ) {
            laterTasks.push({"id": _taskList[i].id,
                             "title": _taskList[i].title,
                             "date": _taskList[i].date,
                             "time": _taskList[i].time,
                             "description": _taskList[i].description,
                             "done": _taskList[i].done,
                            });
        }
    }
    console.log("tasks due later :" + laterTasks.length)
    return laterTasks;
}

// Debug function : just dumps the content of the db on the console.
function dump()
{
    for ( let i = 0; i < _taskList.length; i++ ) {
        console.log(_taskList[i].id + " : "+ _taskList[i].title + " " + _taskList[i].date + " " + _taskList[i].time + " " + _taskList[i].done);
    }
}

/** @fn removeTask(id)
  * @brief Remove the task of given id from the database.
  * @param int id: the id of the task (originated from the database)
  * @return type:bool true if success, false else
  */
function removeTask(id)
{
    let res = TaskStorage.deleteTask(id);
    if ( res ) {
        _taskList = TaskStorage.getTasks();
        tasks.updated();
        return true;
    }
    return false;
}

/** @fn removeDoneTasks()
  * @brief Removes all the tasks with the attribute 'done' (== completed)
  *         to true from the database.
  * @return type:bool true if success, false else
  */
function removeDoneTasks()
{
    let res = TaskStorage.deleteDoneTasks();
    if ( res ) {
        _taskList = TaskStorage.getTasks();
        tasks.updated();
        return true;
    }
    return false;
}

/** @fn clear()
  * @brief Clears the database and the local storage. DO NOT DELETE THE DATABASE ! Clears only the table.
  * @return type:bool true if success, false else
  */
function clear()
{
    let res = TaskStorage.deleteTasks();
    if ( res ) {
        _taskList = [];
        tasks.updated();
        return true;
    }
    return false;
}
