let getConnection = require('./login');


function appendCallendar() {
    scheduler.config.drag_move = false;
    scheduler.config.drag_resize = false;
    scheduler.config.collision_limit = 2;
    scheduler.init('scheduler_here', new Date(), "week");
    var evs = scheduler.getEvents();
    for(event in evs){
      scheduler.deleteEvent(evs[event].id)
    };
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT c.startTime, c.duration, l.name, e1.firstName as aFirstName, e1.lastName as aLastName , e2.firstName as bFirstName, e2.lastName as bLastName, g.description FROM classes AS c INNER JOIN groups AS g ON c.group_ID = g.group_ID INNER JOIN locations AS l ON g.location_ID = l.location_ID INNER JOIN employees AS e1 ON c.firstInstructor_ID = e1.employee_ID INNER JOIN employees AS e2 ON c.secondInstructor_ID = e2.employee_ID ORDER BY startTime;', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                scheduler.addEvent({
                    start_date: (rows[row].startTime.getDate() + "-" + (rows[row].startTime.getMonth() + 1) + "-" + rows[row].startTime.getFullYear() + " " + rows[row].startTime.getHours() + ":" + rows[row].startTime.getMinutes()),
                    end_date: (rows[row].startTime.getDate() + "-" + (rows[row].startTime.getMonth() + 1) + "-" + rows[row].startTime.getFullYear() + " " + (rows[row].startTime.getHours() + rows[row].duration) + ":" + rows[row].startTime.getMinutes()),
                    text: (rows[row].name + ", " + rows[row].description + ", " + rows[row].aFirstName + ", " + rows[row].aLastName + ", " + rows[row].bFirstName + " " + rows[row].bLastName)
                })
            }
            connection.release()
        });
    })
}

document.getElementById('button-classes').addEventListener('click', (event) => {
    appendCallendar()
})
