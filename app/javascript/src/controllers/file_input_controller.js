import ApplicationController from './application_controller'

export default class extends ApplicationController {
  changeHiddenInput(event) {
    const file = event.target.files[0];
    const hiddenInput = event.target.parentElement.querySelector('input[type="hidden"]')
    const reader = new FileReader();
    reader.readAsDataURL(file);
    reader.onload = () => {
      hiddenInput.value = reader.result
      let event = new Event('change');
      hiddenInput.dispatchEvent(event)
    }
    reader.onerror = error => {
      throw error
    }
  }
}
