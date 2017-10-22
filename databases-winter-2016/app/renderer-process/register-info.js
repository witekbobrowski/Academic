let getConnection = require('./login');

document.body.addEventListener('click', (event) => {
    if (event.target.dataset.modal == "register-info") {
        currentID = event.target.dataset.id
        displayRegisterInfo(currentID)
    } else if (event.target.id == "register-info-modal"){
        document.getElementById('register-info-modal').classList.remove('active')
    }
})

document.getElementById('button-register-delete').addEventListener('click', (event) => {
    deleteRegister(currentID);
    document.getElementById('button-register').click()
})

document.getElementById('button-register-edit').addEventListener('click', (event) => {
    displayRegisterEdit(currentID);
})

document.getElementById('button-register-save').addEventListener('click', (event) => {
    editRegister(currentID);
    document.getElementById('button-register').click()
})

//MARK: INNER JOIN & BETWEEN & ORDER & 2XSUBQUERY
function displayRegisterInfo(register) {
    getConnection((err, connection) => {
        let title
        let details = []
        let classes = []
        let attendance = []
        let students = []
        if (err) console.log('no connection');
        connection.query('SELECT t.class_ID, t.startTime, t.duration, t.group_ID, g.description, t.firstInstructor_ID, l.name, e1.firstName as aFirstName, e1.lastName as aLastName, e2.firstName as bFirstName, e2.lastName as bLastName FROM classes AS t INNER JOIN groups AS g ON t.group_ID = g.group_ID INNER JOIN locations AS l ON g.location_ID = l.location_ID INNER JOIN employees AS e1 ON t.firstInstructor_ID = e1.employee_ID INNER JOIN employees AS e2 ON t.secondInstructor_ID = e2.employee_ID WHERE class_ID = ?', [register], (error, rows, fields) => {
            if (error) throw error;
            for (row in rows) {
                title = ('<h1>' + rows[row].description + ', ' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + rows[row].startTime.getHours() + ':' + rows[row].startTime.getMinutes() + '</h1>');
                details.push('ID: ' + rows[row].class_ID + ' <br />')
                details.push('Start time: ' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + rows[row].startTime.getHours() + ':' + rows[row].startTime.getMinutes() + '<br />');
                details.push('Finish time: ' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + (rows[row].startTime.getHours() + rows[row].duration) + ':' + rows[row].startTime.getMinutes() + '<br />');
                details.push('Group: ' + rows[row].description + '<br />');
                details.push('Location: ' + rows[row].name + '<br />')
                details.push('First instructor: ' + rows[row].aFirstName + " " + rows[row].aLastName + '<br />')
                details.push('Second instructor: ' + rows[row].bFirstName + " " + rows[row].bLastName + '<br />')
            }
            document.getElementById('register-info-title').innerHTML = title
            document.getElementById('register-info-details').innerHTML = details.join('')
        });
        connection.query('SELECT * FROM attendance INNER JOIN students ON attendance.student_ID = students.student_ID WHERE class_ID = ? ORDER BY students.lastName;', [register], (error, rows, fields) => {
            if (error) throw error;
            attendance.push('<p>' + rows.length + ' students attended this class</p>')
            attendance.push('<table class="table-striped"><thead><tr><th>ID</th><th>First Name</th><th>Last Name</th></tr></thead><tbody>')
            for (row in rows) {
                attendance.push('<tr>');
                attendance.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].student_ID + ' </td>');
                attendance.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].firstName + ' </td>');
                attendance.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].lastName + '</td>');
                attendance.push('</tr>');
            }
            attendance.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('register-info-attendance').innerHTML = '<p>Not a single student attended this class</p>'
            else
                document.getElementById('register-info-attendance').innerHTML = attendance.join('')
        });
        connection.query('SELECT * FROM students WHERE mainGroup_ID = (SELECT group_ID FROM classes WHERE class_ID = ?) ORDER BY students.lastName;', [register], (error, rows, fields) => {
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
                document.getElementById('register-info-students').innerHTML = '<p>No students signed</p>'
            else
                document.getElementById('register-info-students').innerHTML = students.join('')
        });
        connection.release()
    })
    document.getElementById('button-register-edit').style.visibility="visible"
    document.getElementById('button-register-save').style.visibility="hidden"
}

//MARK: DELETE
function deleteRegister(register) {
    getConnection((err, connection) => {
        connection.query('DELETE FROM classes WHERE class_ID = ?', [register], (error, rows, fields) => {
            if (error) throw error;
            connection.release()
        });
    })
}

function displayRegisterEdit(register) {
    getConnection((err, connection) => {
        let students = []
        connection.query('SELECT * FROM students WHERE mainGroup_ID = (SELECT group_ID FROM classes WHERE class_ID = ?) ORDER BY students.lastName;', [register], (error, rows, fields) => {
            if (error) throw error;
            students.push('<p>' + rows.length + ' students signed</p>')
            students.push('<table class="table-striped"><thead><tr><th>Presence</th><th>ID</th><th>First Name</th><th>Last Name</th></tr></thead><tbody>')
            for (row in rows) {
                students.push('<tr data-id="' + rows[row].student_ID + '">');
                students.push('<td data-id="' + rows[row].student_ID + '" style="width: 200px"><input id="register check" type="checkbox"> <input id="input-register price" class="form-control" type="text" placeholder="Enter price"></td>');
                students.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].student_ID + ' </td>');
                students.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].firstName + ' </td>');
                students.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].lastName + '</td>');
                students.push('</tr>');
            }
            students.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('register-info-students').innerHTML = '<p>No students signed</p>'
            else
                document.getElementById('register-info-students').innerHTML = students.join('')
        });
        connection.release()
    })
    document.getElementById('button-register-edit').style.visibility="hidden"
    document.getElementById('button-register-save').style.visibility="visible"
}

function editRegister(register) {
    getConnection((err, connection) => {
        let list = document.getElementById('register-info-students');
        let rows = list.getElementsByTagName('tr')
        for (let i = 1; i <= (rows.length - 1); i++) {
            let id = rows[i].firstChild.dataset.id
            let inputs = rows[i].getElementsByTagName('input')
            if (inputs[0].type === 'checkbox' && inputs[0].checked === true) {
                if (inputs[1].type === 'text' && inputs[1].value != "") {
                    let price = inputs[1].value
                    console.log(id + " " + register + " " + price);
                    connection.query('INSERT INTO attendance (student_ID, class_ID, price) VALUES (?, ?, ?);', [id, register, price], (error, rows, fields) => {
                        if (error) throw error;
                    });
                }
            }
        }
        connection.release()
    })
}
