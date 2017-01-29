let getConnection = require('./login');

//MARK: INNER JOIN
function appendGroupsList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM groups INNER JOIN locations ON groups.location_ID = locations.location_ID', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].group_ID + '</td>');
                output.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].name + '</td>');
                output.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].description + '</td>');
                output.push('</tr>');
            }
            document.getElementById('table-data-groups').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-groups').addEventListener('click', (event) => {
    appendGroupsList()
})
