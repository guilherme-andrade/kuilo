import "./stylesheets/application.scss";
import "src/vendor"
import "src/channels"
import "src/controllers"
import "src/plugins"
import "src/components"

window.addEventListener('load', () => {
  navigator.serviceWorker.register('/service-worker.js').then(registration => {

    var serviceWorker;
    if (registration.installing) {
      serviceWorker = registration.installing;
    } else if (registration.waiting) {
      serviceWorker = registration.waiting;
    } else if (registration.active) {
      serviceWorker = registration.active;
    }
  }).catch(registrationError => {
    // console.log('Service worker registration failed: ', registrationError);
  });
});
