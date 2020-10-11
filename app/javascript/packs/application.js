import "./stylesheets/application.scss";
import "src/vendor"
import "src/channels"
import "src/controllers"
import "src/plugins"
import "src/components"

window.addEventListener('load', () => {
  navigator.serviceWorker.register('/service-worker.js')
    .then(registration => {
      console.log('ServiceWorker registered: ', registration)
    });
});
