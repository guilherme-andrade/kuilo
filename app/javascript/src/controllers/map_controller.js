import { Controller } from 'stimulus';
import mapboxgl from 'mapbox-gl';

export default class extends Controller {
  connect() {
    mapboxgl.accessToken = this.element.dataset.mapboxApiKey;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    this._addMarkers();
    this._fitMapToMarkers();
  }

  _addMarkers() {
    this.markers = JSON.parse(this.element.dataset.markers);
    this.markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map);
    });
  }

  _fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };
}
