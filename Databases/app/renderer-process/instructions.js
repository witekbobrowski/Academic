let getConnection = require('./login');

//MARK: VIEW
function appendInstructionsList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM instructions_plus', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td>' + rows[row].robot_ID + '</td>');
                output.push('<td>' + rows[row].robotName + '</td>');
                output.push('<td>' + rows[row].name + '</td>');
                output.push('</tr>');
            }
            document.getElementById('table-data-instructions').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-instructions').addEventListener('click', (event) => {
    appendInstructionsList()
})
