const storage = require('electron-json-storage')

storage.get('activeSectionButtonId', function(err, id) {
    if (err) return console.error(err)

    if (id && id.length) {
        showMainContent()
        const section = document.getElementById(id)
        if (section) section.click()
    } else {
        displayLogin()
        document.getElementById('button-login').addEventListener('click', (event) => {
          activateDefaultSection();
        })
    }
})

document.body.addEventListener('click', (event) => {
    if (event.target.dataset.section) {
        handleSectionTrigger(event)
    } else if (event.target.dataset.modal) {
        handleModalTrigger(event)
    } else if (event.target.classList.contains('modal-hide')) {
        hideAllModals()
    }
})
document.getElementById('input-search').addEventListener('keyup', (event) => {
    handleSectionTrigger(event)
})

function handleSectionTrigger(event) {
    hideAllSectionsAndDeselectButtons()
    event.target.classList.add('active')
    const sectionID = event.target.dataset.section
    document.getElementById(sectionID).classList.add('active')
}

function handleModalTrigger(event) {
    hideAllModals()
    const modalId = event.target.dataset.modal + '-modal'
    document.getElementById(modalId).classList.add('active')
}

function activateDefaultSection() {
    document.getElementById('button-home').click()
}

function hideAllModals() {
    const modals = document.querySelectorAll('.modal.active')
    Array.prototype.forEach.call(modals, function(modal) {
        modal.classList.remove('active')
    })
    showMainContent()
}

function showMainContent() {
    document.querySelector('.js-nav').classList.add('is-shown')
    document.querySelector('.js-content').classList.add('is-shown')
}

function hideAllSectionsAndDeselectButtons() {
    const sections = document.querySelectorAll('.js-section.active')
    Array.prototype.forEach.call(sections, function(section) {
        section.classList.remove('active')
    })
    const buttons = document.querySelectorAll('.nav-group-item.active')
    Array.prototype.forEach.call(buttons, function(button) {
        button.classList.remove('active')
    })
}

function displayLogin() {
    document.querySelector('#login-modal').classList.add('active')
}
