import { Alert, Tooltip, Carousel, Popover } from 'bootstrap';

document.addEventListener('turbolinks:load', e => {
  initTooltips()
  initAlerts()
  initCarousels()
  initPopovers();
})

function initTooltips() {
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="tooltip"]'))
  tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new Tooltip(tooltipTriggerEl)
  })
}

function initPopovers() {
  const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-toggle="popover"]'))
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new Popover(popoverTriggerEl)
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
