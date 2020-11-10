import ApplicationController from './application_controller'

export default class extends ApplicationController {
  beforeReflex (element, reflex, noop, reflexId) {
    element.classList.add('loading')
  }

  reflexSuccess (element, reflex, noop, reflexId) {
    // show success message etc...
  }

  reflexError (element, reflex, error, reflexId) {
    // show error message etc...
  }

  afterReflex (element, reflex, noop, reflexId) {
    element.classList.remove('loading')
  }
}
