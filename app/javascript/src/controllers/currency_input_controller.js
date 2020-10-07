import { Controller } from "stimulus"
import { slice, replace } from 'lodash';

export default class extends Controller {
  format(e) {
    let { value, dataset: { input: inputSelector } } = e.target;
    const targetInput = document.querySelector(inputSelector);
    e.target.value = value
    targetInput.value = e.target.value * 100
  }
}
