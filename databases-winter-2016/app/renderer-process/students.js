let getConnection = require('./login');

function appentStudentList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM students', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].student_ID + '</td>');
                output.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].firstName + '</td>');
                output.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].lastName + '</td>');
                output.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].birthDate.getDate() + "/" + (rows[row].birthDate.getMonth() + 1) + "/" + rows[row].birthDate.getFullYear() + '</td>');
                output.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].homeTown + '</td>');
                output.push('<td type="button" id="button-student-info" data-id="' + rows[row].student_ID + '" data-modal="student-info">' + rows[row].mainGroup_ID + '</td>');
                output.push('</tr>');
            }
            document.getElementById('table-data-students').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-students').addEventListener('click', (event) => {
    appentStudentList()
})
