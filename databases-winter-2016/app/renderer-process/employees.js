let getConnection = require('./login');

function appendEmployeeList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM employees', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr data-id="' + rows[row].employee_ID + '" >');
                output.push('<td type="button" id="button-employee-info" data-id="' + rows[row].employee_ID + '" data-modal="employee-info">' + rows[row].employee_ID + '</td>');
                output.push('<td type="button" id="button-employee-info" data-id="' + rows[row].employee_ID + '" data-modal="employee-info">' + rows[row].firstName + '</td>');
                output.push('<td type="button" id="button-employee-info" data-id="' + rows[row].employee_ID + '" data-modal="employee-info">' + rows[row].lastName + '</td>');
                output.push('<td type="button" id="button-employee-info" data-id="' + rows[row].employee_ID + '" data-modal="employee-info">' + rows[row].email + '</td>');
                output.push('<td type="button" id="button-employee-info" data-id="' + rows[row].employee_ID + '" data-modal="employee-info">' + rows[row].mobile + '</td>');
                if (rows[row].studentStatus === 1) output.push('<td type="button" id="button-employee-info" data-id="' + rows[row].employee_ID + '" data-modal="employee-info">Yes</td>');
                else output.push('<td type="button" id="button-employee-info" data-id="' + rows[row].employee_ID + '" data-modal="employee-info">No</td>');
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
