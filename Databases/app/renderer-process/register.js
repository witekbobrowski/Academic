let getConnection = require('./login');

//MARK: VIEW & ORDER BY & 2x INNER JOIN
function appendRegisterList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT t.class_ID, t.startTime, t.duration, t.group_ID, g.description, t.firstInstructor_ID, l.name, e1.firstName as aFirstName, e1.lastName as aLastName, e2.firstName as bFirstName, e2.lastName as bLastName FROM classes AS t INNER JOIN groups AS g ON t.group_ID = g.group_ID INNER JOIN locations AS l ON g.location_ID = l.location_ID INNER JOIN employees AS e1 ON t.firstInstructor_ID = e1.employee_ID INNER JOIN employees AS e2 ON t.secondInstructor_ID = e2.employee_ID WHERE t.startTime <= curdate() ORDER BY startTime DESC;', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + rows[row].startTime.getHours() + ':' + rows[row].startTime.getMinutes() + '</td>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + (rows[row].startTime.getHours() + rows[row].duration) + ':' + rows[row].startTime.getMinutes() + '</td>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].name + '</td>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].description + '</td>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].aFirstName + " " + rows[row].aLastName + ", " + rows[row].bFirstName + " " + rows[row].bLastName + '</td>');
                output.push('</tr>');
            }
            output.push('</tbody></table>')
            if(rows.length == 0)
              document.getElementById('table-data-register').innerHTML = '<p class="search-results-none">No clases in register</p>'
            else
              document.getElementById('table-data-register').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-register').addEventListener('click', (event) => {
    appendRegisterList()
})
