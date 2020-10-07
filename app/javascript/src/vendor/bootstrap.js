import { Alert, Tooltip, Carousel } from 'bootstrap';

document.addEventListener('turbolinks:load', e => {
  initTooltips()
  initAlerts()
  initCarousels()
})

function initTooltips() {
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="tooltip"]'))

  const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new Tooltip(tooltipTriggerEl)
  })
}

function initAlerts() {
  const alertList = document.querySelectorAll('.alert');
  alertList.forEach(function (alert) {
    new Alert(alert)
  })
}

function initCarousels() {
  const carousels = document.querySelectorAll('[data-ride="carousel"]')
  // console.log(carousels)
  carousels.forEach(carousel => {
    new Carousel(carousel)
  })
}
