let getConnection = require('./login');

function appentStudentList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM students', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td>' + rows[row].student_ID + '</td>');
                output.push('<td>' + rows[row].firstName + '</td>');
                output.push('<td>' + rows[row].lastName + '</td>');
                output.push('<td>' + rows[row].birthDate.getDay() + "/" + rows[row].birthDate.getMonth() + "/" + rows[row].birthDate.getFullYear() + '</td>');
                output.push('<td>' + rows[row].homeTown + '</td>');
                output.push('<td>' + rows[row].mainGroup_ID + '</td>');
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
