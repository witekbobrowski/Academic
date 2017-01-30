let getConnection = require('./login');

let currentID;
document.body.addEventListener('click', (event) => {
    if (event.target.dataset.modal == "student-info") {
        currentID = event.target.dataset.id
        displayStudentInfo(currentID)
    } else {
        document.getElementById('student-info-modal').classList.remove('active')
    }
})

document.getElementById('button-student-delete').addEventListener('click', (event) => {
    console.log(currentID);
    //deleteStudent(currentID);
    document.getElementById('button-students').click()
})

document.getElementById('button-student-edit').addEventListener('click', (event) => {
    console.log(currentID);
    //editStudent(currentID);
    document.getElementById('button-students').click()
})

//MARK: INNER JOIN, RIGHT JOIN & BETWEEN & ORDER
function displayStudentInfo(student) {
    getConnection((err, connection) => {
        let title
        let details = []
        let classes = []
        if (err) console.log('no connection');
        connection.query('SELECT * FROM students AS s INNER JOIN groups AS g ON s.mainGroup_ID = g.group_ID WHERE student_ID = ?', [student], (error, rows, fields) => {
            if (error) throw error;
            for (row in rows) {
                title = ('<h1>' + rows[row].firstName + " " + rows[row].lastName + '</h1>')
                details.push('ID: ' + rows[row].student_ID + ' <br />')
                details.push('Main Group: ' + rows[row].description + ' <br />')
                details.push('Birth date: ' + rows[row].birthDate.getDate() + "/" + (rows[row].birthDate.getMonth() + 1) + "/" + rows[row].birthDate.getFullYear() + '<br />')
                details.push('Home Town: ' + rows[row].homeTown + '<br />')
                details.push('Contact Name: ' + rows[row].contactName + '<br />')
                details.push('Contact mobile: ' + rows[row].contactMobile + '<br />')
                details.push('Contact E-mail: ' + rows[row].contactEmail + '<br />')
            }
            document.getElementById('student-info-title').innerHTML = title
            document.getElementById('student-info-details').innerHTML = details.join('')
        });
        connection.query('SELECT * FROM students RIGHT JOIN classes ON mainGroup_ID = group_ID INNER JOIN groups ON students.mainGroup_ID = groups.group_ID INNER JOIN locations AS l ON groups.location_ID = l.location_ID WHERE students.student_ID = ? AND startTime >= curdate() ORDER BY startTime;', [student], (error, rows, fields) => {
            if (error) throw error;
            classes.push('<p>' + rows.length + ' classes scheduled</p>')
            classes.push('<table class="table-striped"><thead><tr><th>Begins</th><th>Ends</th><th>Location</th><th>Group</th></tr></thead><tbody>')
            for (row in rows) {
                classes.push('<tr>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].mainGroup_ID + '" data-modal="group-info"> ' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + rows[row].startTime.getHours() + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].mainGroup_ID + '" data-modal="group-info"> ' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + (rows[row].startTime.getHours() + rows[row].duration) + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].mainGroup_ID + '" data-modal="group-info">' + rows[row].name + '</td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].mainGroup_ID + '" data-modal="group-info">' + rows[row].description + '</td>');
                classes.push('</tr>');
            }
            classes.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('student-info-classes').innerHTML = '<p>No classes scheduled</p>'
            else
                document.getElementById('student-info-classes').innerHTML = classes.join('')
        });
        connection.release()
    })
}

//MARK: DELETE
function deleteStudent(student) {
    getConnection((err, connection) => {
        connection.query('DELETE FROM students WHERE student_ID = ?', [student], (error, rows, fields) => {
            if (error) throw error;
        });
        connection.release()
    })
}
