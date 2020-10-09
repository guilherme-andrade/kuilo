import { Controller } from "stimulus"
import { slice, replace } from 'lodash';

export default class extends Controller {
  connect() {
    this.format();
  }

  format() {
    let { value, dataset: { input: inputSelector } } = this.element;
    const targetInput = document.querySelector(inputSelector);
    this.element.value = value;
    targetInput.value = this.element.value * 100
  }
}
