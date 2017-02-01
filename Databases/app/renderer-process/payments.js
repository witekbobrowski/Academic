let getConnection = require('./login');

function appendPaymentsDueList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM payments_due INNER JOIN students ON payments_due.student_ID = students.student_ID;', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].payments_ID + '</td>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].firstName + " " + rows[row].lastName + '</td>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].class_ID + '</td>');
                output.push('<td type="button" id="button-register-info" data-id="' + rows[row].class_ID + '" data-modal="register-info">' + rows[row].amount + ' $ </td>');
                output.push('</tr>');
            }
            output.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('table-data-payments').innerHTML = '<p class="search-results-none">No payments are due</p>'
            else
                document.getElementById('table-data-payments').innerHTML = output.join('')
        });
        connection.release()
    })
}

document.getElementById('button-payments').addEventListener('click', (event) => {
    appendPaymentsDueList()
})
