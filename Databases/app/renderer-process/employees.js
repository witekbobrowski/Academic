let getConnection = require('./login');

function appendEmployeeList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM employees', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td>' + rows[row].employee_ID + '</td>');
                output.push('<td>' + rows[row].firstName + '</td>');
                output.push('<td>' + rows[row].lastName + '</td>');
                output.push('<td>' + rows[row].email + '</td>');
                output.push('<td>' + rows[row].mobile + '</td>');
                if (rows[row].studentStatus === 1) output.push('<td>Yes</td>');
                else output.push('<td>No</td>');
                output.push('</tr>');
            }
            document.getElementById('table-data-employees').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-employees').addEventListener('click', (event) => {
    appendEmployeeList()
})
