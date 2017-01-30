let getConnection = require('./login');
let phase = document.getElementById('input-search')

document.getElementById('input-search').addEventListener('keyup', (event) => {
    searchFor(document.getElementById('input-search').value)
})

function searchFor(phrase) {
    searchResultsEmployees(phrase)
    searchResultsStudents(phrase)
    searchResultsGroups(phrase)
    searchResultsLocations(phrase)
    searchResultsEquipment(phrase)
    searchResultsInstructions(phrase)
}

//MARK: FULLTEXT SEARCH
function searchResultsEmployees(phrase) {
    let output = []
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM employees WHERE MATCH(firstName, lastName, email) AGAINST (?)', [phrase], (error, rows, fields) => {
            if (error) throw error
            output.push('<p class="search-results-title">Found in employees</p><div class="section-table"><table class="table-striped"><thead><tr><th>ID</th><th>First Name</th><th>Last Name</th><th>E-mail</th><th>Mobile</th><th>Student</th></tr></thead><tbody>')
            for (row in rows) {
                output.push('<tr>')
                output.push('<td>' + rows[row].employee_ID + '</td>')
                output.push('<td>' + rows[row].firstName + '</td>')
                output.push('<td>' + rows[row].lastName + '</td>')
                output.push('<td>' + rows[row].email + '</td>')
                output.push('<td>' + rows[row].mobile + '</td>')
                if (rows[row].studentStatus === 1) output.push('<td>Yes</td>')
                else output.push('<td>No</td>')
                output.push('</tr>')
            }
            output.push('</tbody></table></div></div>')
            console.log(output);
            if (rows.length != 0) {
                document.getElementById('search-results-employees').innerHTML = output.join('')
            } else {
                document.getElementById('search-results-employees').innerHTML = '<p class="search-results-none">No results in Employees</p>'
            }
            connection.release()
        });
    })
}

//MARK: FULLTEXT SEARCH
function searchResultsStudents(phrase) {
    let output = []
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM students WHERE MATCH(firstName, lastName, contactName, contactEmail, homeTown) AGAINST (?)', [phrase], (error, rows, fields) => {
            if (error) throw error
            let output = []
            output.push('<p class="search-results-title">Found in students</p><div class="section-table"><table class="table-striped"><thead><tr><th>ID</th><th>First Name</th><th>Last Name</th><th>Birth Date</th><th>Home Town</th><th>Main Group</th></tr></thead><tbody>')
            for (row in rows) {
                output.push('<tr>')
                output.push('<td>' + rows[row].student_ID + '</td>')
                output.push('<td>' + rows[row].firstName + '</td>')
                output.push('<td>' + rows[row].lastName + '</td>')
                output.push('<td>' + rows[row].birthDate.getDay() + "/" + rows[row].birthDate.getMonth() + "/" + rows[row].birthDate.getFullYear() + '</td>')
                output.push('<td>' + rows[row].homeTown + '</td>')
                output.push('<td>' + rows[row].mainGroup_ID + '</td>')
                output.push('</tr>')
            }
            output.push('</tbody></table></div></div>')
              console.log(output);
            if (rows.length != 0) {
                document.getElementById('search-results-students').innerHTML = output.join('')
            } else {
                document.getElementById('search-results-students').innerHTML = '<p class="search-results-none">No results in Students</p>'
            }
            connection.release()
        });
    })
}

//MARK: FULLTEXT SEARCH + INNER JOIN
function searchResultsGroups(phrase) {
    let output = []
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM groups INNER JOIN locations ON groups.location_ID = locations.location_ID WHERE MATCH(description) AGAINST (?)', [phrase], (error, rows, fields) => {
            if (error) throw error
            output.push('<p class="search-results-title">Found in groups</p><div class="section-table"><table class="table-striped"><thead><tr><th>ID</th><th>Location</th><th>Description</th></tr></thead><tbody>')
            for (row in rows) {
                output.push('<tr>')
                output.push('<td>' + rows[row].group_ID + '</td>')
                output.push('<td>' + rows[row].name + '</td>')
                output.push('<td>' + rows[row].description + '</td>')
                output.push('</tr>')
            }
            output.push('</tbody></table></div></div>')
              console.log(output);
            if (rows.length != 0) {
                document.getElementById('search-results-groups').innerHTML = output.join('')
            } else {
                document.getElementById('search-results-groups').innerHTML = '<p class="search-results-none">No results in Groups</p>'
            }
            connection.release()
        });
    })
}

//MARK: FULLTEXT SEARCH
function searchResultsLocations(phrase) {
    let output = []
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM locations WHERE MATCH(name, email, addressLine1, postcode, city) AGAINST (?)', [phrase], (error, rows, fields) => {
            if (error) throw error
            output.push('<p class="search-results-title">Found in locations</p><div class="section-table"><table class="table-striped"><thead><tr><th>ID</th><th>Name</th><th>Mobile</th><th>E-mail</th><th>Address</th><th>Post Code</th><th>City</th></tr></thead><tbody>')
            for (row in rows) {
                output.push('<tr>')
                output.push('<td>' + rows[row].location_ID + '</td>')
                output.push('<td>' + rows[row].name + '</td>')
                output.push('<td>' + rows[row].mobile + '</td>')
                output.push('<td>' + rows[row].email + '</td>')
                output.push('<td>' + rows[row].addressLine1 + '</td>')
                output.push('<td>' + rows[row].postcode + '</td>')
                output.push('<td>' + rows[row].city + '</td>')
                output.push('</tr>')
            }
            output.push('</tbody></table></div></div>')
              console.log(output);
            if (rows.length != 0) {
                document.getElementById('search-results-locations').innerHTML = output.join('')
            } else {
                document.getElementById('search-results-locations').innerHTML = '<p class="search-results-none">No results in Locations</p>'
            }
            connection.release()
        });
    })
}


//MARK: FULLTEXT SEARCH
function searchResultsEquipment(phrase) {
    let output = []
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM equipment WHERE MATCH(name, description) AGAINST (?)', [phrase], (error, rows, fields) => {
            if (error) throw error
            output.push('<p class="search-results-title">Found in equipment</p><div class="section-table"><table class="table-striped"><thead><tr><th>ID</th><th>Name</th><th>Quantity</th><th>Description</th></tr></thead><tbody>')
            for (row in rows) {
                output.push('<tr>')
                output.push('<td>' + rows[row].equipment_ID + '</td>')
                output.push('<td>' + rows[row].name + '</td>')
                output.push('<td>' + rows[row].quantity + '</td>')
                output.push('<td>' + rows[row].description + '</td>')
                output.push('</tr>')
            }
            output.push('</tbody></table></div></div>')
              console.log(output);
            if (rows.length != 0) {
                document.getElementById('search-results-equipment').innerHTML = output.join('')
            } else {
                document.getElementById('search-results-equipment').innerHTML = '<p class="search-results-none">No results in Equipment</p>'
            }
            connection.release()
        });
    })
}

//MARK: FULLTEXT SEARCH + INNER JOIN
function searchResultsInstructions(phrase) {
    let output = []
    getConnection((err, connection) => {
        if (err) console.log('no connection');
        connection.query('SELECT * FROM instructions INNER JOIN equipment ON instructions.bricksType_ID = equipment.equipment_ID WHERE MATCH(robotName) AGAINST (?)', [phrase], (error, rows, fields) => {
            if (error) throw error
            output.push('<p class="search-results-title">Found in instructions</p><div class="section-table"><table class="table-striped"><thead><tr><th>ID</th><th>Robot Name</th><th>Type of Bricks</th></tr></thead><tbody>')
            for (row in rows) {
                output.push('<tr>')
                output.push('<td>' + rows[row].robot_ID + '</td>')
                output.push('<td>' + rows[row].robotName + '</td>')
                output.push('<td>' + rows[row].name + '</td>')
                output.push('</tr>')
            }
            output.push('</tbody></table></div></div>')
              console.log(output);
            if (rows.length != 0) {
                document.getElementById('search-results-instructions').innerHTML = output.join('')
            } else {
                document.getElementById('search-results-instructions').innerHTML = '<p class="search-results-none">No results in Instructions</p>'
            }
            connection.release()
        });
    })
}
