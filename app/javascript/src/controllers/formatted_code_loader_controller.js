import { Controller } from "stimulus"
import Prism from 'prismjs/components/prism-core';
import 'prismjs/components/prism-clike';
import 'prismjs/components/prism-json';

import { api, dom } from 'src/services';

export default class extends Controller {
  connect() {
    this.loadJSON();
  }

  loadJSON() {
    api.get(this.url)
      .then(({ data }) => {
        const code = JSON.stringify(data, null, 2);
        const html = Prism.highlight(code, Prism.languages.json, 'json');
        const content = dom.createElement('code', html);
        this.element.innerHTML = content.outerHTML;
      })
  }

  get url() {
    return this.data.get('url');
  }

  get language() {
    return this.data.get('language');
  }
}
