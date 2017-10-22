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
                output.push('<td type="button" id="button-instruction-info" data-id="' + rows[row].robot_ID + '" data-modal="instruction-info">' + rows[row].robot_ID + '</td>');
                output.push('<td type="button" id="button-instruction-info" data-id="' + rows[row].robot_ID + '" data-modal="instruction-info">' + rows[row].robotName + '</td>');
                output.push('<td type="button" id="button-instruction-info" data-id="' + rows[row].robot_ID + '" data-modal="instruction-info">' + rows[row].name + '</td>');
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
