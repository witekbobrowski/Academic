let getConnection = require('./login');

document.body.addEventListener('click', (event) => {
    if (event.target.dataset.modal == "location-info") {
        currentID = event.target.dataset.id
        displayLocationInfo(currentID)
    } else {
        document.getElementById('location-info-modal').classList.remove('active')
    }
})

document.getElementById('button-location-delete').addEventListener('click', (event) => {
    console.log(currentID);
    deleteLocation(currentID);
    document.getElementById('button-locations').click()
})

document.getElementById('button-location-edit').addEventListener('click', (event) => {
    console.log(currentID);
    //editLocation(currentID);
    document.getElementById('button-locations').click()
})

//MARK: INNER JOIN & BETWEEN & ORDER & SUBQUERY
function displayLocationInfo(location) {
    getConnection((err, connection) => {
        let title
        let details = []
        let classes = []
        if (err) console.log('no connection');
        connection.query('SELECT * FROM locations WHERE location_ID = ?', [location], (error, rows, fields) => {
            if (error) throw error;
            for (row in rows) {
                title = ('<h1>' + rows[row].name + '</h1>')
                details.push('ID: ' + rows[row].location_ID + ' <br />')
                details.push('Address: ' + rows[row].addressLine1 + ', ' + rows[row].postcode + ', ' + rows[row].city + '<br />')
                details.push('mobile: ' + rows[row].mobile + '<br />')
                details.push('E-mail: ' + rows[row].email + '<br />')
            }
            document.getElementById('location-info-title').innerHTML = title
            document.getElementById('location-info-details').innerHTML = details.join('')
        });
        connection.query('SELECT c.startTime, c.duration, c.group_ID, g.description, g.location_ID, e1.firstName as aFirstName, e1.lastName as aLastName, e2.firstName as bFirstName, e2.lastName as bLastName FROM classes AS c INNER JOIN groups AS g ON c.group_ID = g.group_ID INNER JOIN employees AS e1 ON c.firstInstructor_ID = e1.employee_ID INNER JOIN employees AS e2 ON c.secondInstructor_ID = e2.employee_ID WHERE g.location_ID = (SELECT location_ID FROM locations WHERE location_ID = ?) AND c.startTime >= curdate() ORDER BY startTime;', [location], (error, rows, fields) => {
            if (error) throw error;
            classes.push('<p>' + rows.length + ' classes in schedule</p>')
            classes.push('<table class="table-striped"><thead><tr><th>Begins</th><th>Ends</th><th>Group</th><th>Instructors</th></tr></thead><tbody>')
            for (row in rows) {
                classes.push('<tr>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + rows[row].startTime.getHours() + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].startTime.getDate() + '/' + (rows[row].startTime.getMonth() + 1) + '/' + rows[row].startTime.getFullYear() + '  ' + (rows[row].startTime.getHours() + rows[row].duration) + ':' + rows[row].startTime.getMinutes() + ' </td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].description + '</td>');
                classes.push('<td type="button" id="button-group-info" data-id="' + rows[row].group_ID + '" data-modal="group-info">' + rows[row].aFirstName + " " + rows[row].aLastName + ", " + rows[row].bFirstName + " " + rows[row].bLastName + '</td>');
                classes.push('</tr>');
            }
            classes.push('</tbody></table>')
            if (rows.length == 0)
                document.getElementById('location-info-classes').innerHTML = '<p>No classes scheduled</p>'
            else
                document.getElementById('location-info-classes').innerHTML = classes.join('')
        })
        connection.release()
    })
}

//MARK: DELETE
function deleteLocation(location) {
    getConnection((err, connection) => {
        connection.query('DELETE FROM locations WHERE location_ID = ?', [location], (error, rows, fields) => {
            if (error) throw error;
        });
        connection.release()
    })
}
