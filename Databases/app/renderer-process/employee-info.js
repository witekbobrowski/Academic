let getConnection = require('./login');

document.body.addEventListener('click', (event) => {
    if (event.target.dataset.modal == "employee-info") {
        currentID = event.target.dataset.id
        displayEmployeeInfo(currentID)
    } else {
        document.getElementById('employee-info-modal').classList.remove('active')
    }
})

document.getElementById('button-employee-delete').addEventListener('click', (event) => {
    console.log(currentID);
    //deleteEmployee(currentID);
    document.getElementById('button-employees').click()
})

document.getElementById('button-employee-edit').addEventListener('click', (event) => {
    console.log(currentID);
    //editEmployees(currentID);
    document.getElementById('button-employees').click()
})

//MARK: INNER JOIN & BETWEEN & ORDER
function displayEmployeeInfo(employee) {
    getConnection((err, connection) => {
        let title
        let details = []
        let classes = []
        if (err) console.log('no connection');
        connection.query('SELECT * FROM employees WHERE employee_ID = ?', [employee], (error, rows, fields) => {
            if (error) throw error;
            for (row in rows) {
                title = ('<h1>' + rows[row].firstName + " " + rows[row].lastName + '</h1>')
                details.push('ID: ' + rows[row].employee_ID + ' <br />')
                details.push('Birth date: ' + rows[row].birthDate.getDate() + "/" + (rows[row].birthDate.getMonth() + 1) + "/" + rows[row].birthDate.getFullYear() + '<br />')
                details.push('mobile: ' + rows[row].mobile + '<br />')
                details.push('E-mail: ' + rows[row].email + '<br />')
                if (rows[row].studentStatus === 1) details.push('Student status: Yes<br />')
                else details.push('Student status: No<br />')
            }
            document.getElementById('employee-info-title').innerHTML = title
            document.getElementById('employee-info-details').innerHTML = details.join('')
        });
        connection.query('SELECT * FROM classes AS c INNER JOIN groups AS g ON c.group_ID = g.group_ID INNER JOIN locations AS l ON g.location_ID = l.location_ID  WHERE (c.firstInstructor_ID = ? OR c.secondInstructor_ID = ?) AND startTime >= curdate() ORDER BY startTime;', [employee, employee], (error, rows, fields) => {
            if (error) throw error;
            classes.push('<p>' + rows.length + ' classes in schedule</p>')
            classes.push('<table class="table-striped"><thead><tr><th>Begins</th><th>Ends</th><th>Location</th><th>Group</th></tr></thead><tbody>')
            for (row in rows) {
                classes.push('<tr>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + rows[row].startTime.getHours() + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + (rows[row].startTime.getHours() + rows[row].duration) + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].name + '</td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].description + '</td>');
                classes.push('</tr>');
            }
            classes.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('employee-info-classes').innerHTML = '<p>No classes scheduled</p>'
            else
                document.getElementById('employee-info-classes').innerHTML = classes.join('')
        });
        connection.release()
    })
}

//MARK: DELETE
function deleteEmployee(employee) {
    getConnection((err, connection) => {
        connection.query('DELETE FROM employees WHERE employee_ID = ?', [employee], (error, rows, fields) => {
            if (error) throw error;
        });
        connection.release()
    })
}
