let getConnection = require('./login');

document.body.addEventListener('click', (event) => {
    if (event.target.dataset.modal == "group-info") {
        currentID = event.target.dataset.id
        displayGroupInfo(currentID)
    } else {
        document.getElementById('group-info-modal').classList.remove('active')
    }
})

document.getElementById('button-group-delete').addEventListener('click', (event) => {
    console.log(currentID);
    deleteGroup(currentID);
    document.getElementById('button-groups').click()
})

document.getElementById('button-group-edit').addEventListener('click', (event) => {
    console.log(currentID);
    //editGroup(currentID);
    document.getElementById('button-groups').click()
})

//MARK: INNER JOIN & BETWEEN & ORDER & 2XSUBQUERY
function displayGroupInfo(group) {
    getConnection((err, connection) => {
        let title
        let details = []
        let classes = []
        let students = []
        if (err) console.log('no connection');
        connection.query('SELECT * FROM groups INNER JOIN locations ON groups.location_ID = locations.location_ID WHERE group_ID = ?', [group], (error, rows, fields) => {
            if (error) throw error;
            for (row in rows) {
                title = ('<h1>' + rows[row].description + '</h1>')
                details.push('ID: ' + rows[row].group_ID + ' <br />')
                details.push('Location: ' + rows[row].name + '<br />')
            }
            document.getElementById('group-info-title').innerHTML = title
            document.getElementById('group-info-details').innerHTML = details.join('')
        });
        connection.query('SELECT startTime, duration, name FROM classes INNER JOIN locations WHERE group_ID = (SELECT group_ID FROM groups WHERE group_ID = ?) AND (location_ID = (SELECT location_ID FROM groups WHERE group_ID = ?) ) AND startTime >= curdate() ORDER BY startTime;', [group, group], (error, rows, fields) => {
            if (error) throw error;
            classes.push('<p>' + rows.length + ' classes in schedule</p>')
            classes.push('<table class="table-striped"><thead><tr><th>Begins</th><th>Ends</th><th>Location</th></tr></thead><tbody>')
            for (row in rows) {
                classes.push('<tr>');
                classes.push('<td>' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + rows[row].startTime.getHours() + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td>' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + (rows[row].startTime.getHours() + rows[row].duration) + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td>' + rows[row].name + '</td>');
                classes.push('</tr>');
            }
            classes.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('group-info-classes').innerHTML = '<p>No classes scheduled</p>'
            else
                document.getElementById('group-info-classes').innerHTML = classes.join('')
        });
        connection.query('SELECT * FROM students WHERE mainGroup_ID = (SELECT group_ID FROM groups WHERE group_ID = ?) ORDER BY students.lastName;', [group], (error, rows, fields) => {
            if (error) throw error;
            students.push('<p>' + rows.length + ' students signed</p>')
            students.push('<table class="table-striped"><thead><tr><th>ID</th><th>First Name</th><th>Last Name</th></tr></thead><tbody>')
            for (row in rows) {
                students.push('<tr>');
                students.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].student_ID + ' </td>');
                students.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].firstName + ' </td>');
                students.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].lastName + '</td>');
                students.push('</tr>');
            }
            students.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('group-info-students').innerHTML = '<p>No students signed</p>'
            else
                document.getElementById('group-info-students').innerHTML = students.join('')
        });
        connection.release()
    })
}

//MARK: DELETE
function deleteGroup(group) {
    getConnection((err, connection) => {
        connection.query('DELETE FROM groups WHERE group_ID = ?', [group], (error, rows, fields) => {
            if (error) throw error;
            connection.release()
        });
    })
}
