import { Alert, Tooltip, Carousel, Popover, Toast } from 'bootstrap';

document.addEventListener('turbolinks:load', e => {
  initBootstrap()
})

export function initBootstrap() {
  initTooltips()
  initAlerts()
  initCarousels()
  initPopovers();
  initToasts();
}

document.addEventListener('cable-ready:after-insert-adjacent-html', e => {
  initBootstrap();
})

function initToasts() {
  const toastElList = [].slice.call(document.querySelectorAll('.toast'))
  toastElList.map(function (toastEl) {
    new Toast(toastEl);

    setTimeout(() => {
      toastEl.remove();
    }, 7000);
  })
}

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
