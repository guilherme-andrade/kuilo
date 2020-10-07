import axios from 'axios';

function createElement(tag, content) {
  const element = document.createElement(tag);
  element.innerHTML = content;
  return element;
}

export default { createElement };
