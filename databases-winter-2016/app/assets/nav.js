document.addEventListener("DOMContentLoaded", function() {
  displayLogin()
});

document.body.addEventListener('click', (event) => {
    if (event.target.dataset.section) {
        handleSectionTrigger(event)
    } else if (event.target.dataset.modal) {
        console.log('click');
        handleModalTrigger(event)
    } else if (event.target.classList.contains('modal-hide')) {
        hideAllModals()
    }
})

function handleSectionTrigger(event) {
    hideAllModals()
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
    hideAllModals()
    document.querySelector('#login-modal').classList.add('active')
}
