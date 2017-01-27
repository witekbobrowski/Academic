let getConnection = require('./login');

function appendEquipmentList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM equipment', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td>' + rows[row].equipment_ID + '</td>');
                output.push('<td>' + rows[row].name + '</td>');
                output.push('<td>' + rows[row].quantity + '</td>');
                output.push('<td>' + rows[row].description + '</td>');
                output.push('</tr>');
            }
            document.getElementById('table-data-equipment').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-equipment').addEventListener('click', (event) => {
    appendEquipmentList()
})
