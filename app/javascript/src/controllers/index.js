// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'
import StimulusReflex from 'stimulus_reflex'
import consumer from '../channels/consumer'
import controller from './application_controller'
import Flatpickr from 'stimulus-flatpickr'

const application = Application.start()
const context = require.context('src/controllers', true, /_controller\.js$/)
application.load(definitionsFromContext(context))
application.register('flatpickr', Flatpickr)
StimulusReflex.initialize(application, { consumer, controller, debug: false })

document.addEventListener('stimulus-reflex:after', fireTurbolinksLoad)

function fireTurbolinksLoad() {
  const event = document.createEvent('Event');
  event.initEvent('turbolinks:load', true, true);
  document.dispatchEvent(event);
}
