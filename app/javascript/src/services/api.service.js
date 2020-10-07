import axios from 'axios';

const instance = axios.create({
  baseURL: '/',
  timeout: 1000,
  headers: { 'X-Custom-Header': 'foobar' }
});

function get(url, params = {}) {
  return instance.get(url, params)
}

function patch(url, params = {}) {
  return instance.patch(url, params)
}

function destroy(url, params = {}) {
  return instance.delete(url, params)
}

function post(url, params = {}) {
  return instance.post(url, params)
}

export default { get, patch, destroy, post };
