let getConnection = require('./login');

function appendLocationsList() {
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM locations', (error, rows, fields) => {
            if (error) throw error;
            let output = [];
            for (row in rows) {
                output.push('<tr>');
                output.push('<td>' + rows[row].location_ID + '</td>');
                output.push('<td>' + rows[row].name + '</td>');
                output.push('<td>' + rows[row].mobile + '</td>');
                output.push('<td>' + rows[row].email + '</td>');
                output.push('<td>' + rows[row].addressLine1 + '</td>');
                output.push('<td>' + rows[row].postcode + '</td>');
                output.push('<td>' + rows[row].city + '</td>');
                output.push('</tr>');
            }
            document.getElementById('table-data-locations').innerHTML = output.join('')
            connection.release()
        });
    })
}

document.getElementById('button-locations').addEventListener('click', (event) => {
    appendLocationsList()
})
