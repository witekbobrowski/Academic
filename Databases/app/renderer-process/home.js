let getConnection = require('./login');

let today = new Date()
let date = (today.getDay() + '/' + (today.getMonth() + 1) + "/" + today.getFullYear())
document.getElementById('time').innerHTML = date

//MARK: VIEW & ORDER BY & 2x INNER JOIN
function appendTodayList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT t.startTime, t.duration, t.group_ID, g.description, t.firstInstructor_ID, l.name, e1.firstName as aFirstName, e1.lastName as aLastName, e2.firstName as bFirstName, e2.lastName as bLastName FROM todays_classes AS t INNER JOIN groups AS g ON t.group_ID = g.group_ID INNER JOIN locations AS l ON g.location_ID = l.location_ID INNER JOIN employees AS e1 ON t.firstInstructor_ID = e1.employee_ID INNER JOIN employees AS e2 ON t.secondInstructor_ID = e2.employee_ID ORDER BY startTime;', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td>' + rows[row].startTime.getHours() + ":" + rows[row].startTime.getMinutes() + '</td>');
                output.push('<td>' + (rows[row].startTime.getHours() + rows[row].duration) + ":" + rows[row].startTime.getMinutes() + '</td>');
                output.push('<td>' + rows[row].name + '</td>');
                output.push('<td>' + rows[row].description + '</td>');
                output.push('<td>' + rows[row].aFirstName + " " + rows[row].aLastName + ", " + rows[row].bFirstName + " " + rows[row].bLastName + '</td>');
                output.push('</tr>');
            }
            document.getElementById('table-data-home').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-home').addEventListener('click', (event) => {
    appendTodayList()
})
