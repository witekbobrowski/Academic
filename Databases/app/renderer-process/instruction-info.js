let getConnection = require('./login');

document.body.addEventListener('click', (event) => {
    if (event.target.dataset.modal == "instruction-info") {
        currentID = event.target.dataset.id
        displayInstructionInfo(currentID)
    } else {
        document.getElementById('instruction-info-modal').classList.remove('active')
    }
})

document.getElementById('button-instruction-delete').addEventListener('click', (event) => {
    console.log(currentID);
    //deleteInstruction(currentID);
    document.getElementById('button-instructions').click()
})

document.getElementById('button-instruction-edit').addEventListener('click', (event) => {
    console.log(currentID);
    //editInstruction(currentID);
    document.getElementById('button-instructions').click()
})

function displayInstructionInfo(instruction) {
    getConnection((err, connection) => {
        let title
        let details = []
        if (err) console.log('no connection');
        connection.query('SELECT * FROM instructions_plus WHERE robot_ID = ?', [instruction], (error, rows, fields) => {
            if (error) throw error;
            for (row in rows) {
                title = ('<h1>' + rows[row].robotName + '</h1>')
                details.push('ID: ' + rows[row].robot_ID + ' <br />')
                details.push('Bricks Type: ' + rows[row].name + '<br />')
            }
            document.getElementById('instruction-info-title').innerHTML = title
            document.getElementById('instruction-info-details').innerHTML = details.join('')
        });
        connection.release()
    })
}

//MARK: DELETE
function deleteInstruction(locatinstructionion) {
    getConnection((err, connection) => {
        connection.query('DELETE FROM instructions WHERE robot_ID = ?', [instruction], (error, rows, fields) => {
            if (error) throw error;
        });
        connection.release()
    })
}
