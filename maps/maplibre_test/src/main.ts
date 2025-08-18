import maplibregl, {type LngLatLike, Map} from 'maplibre-gl';
import 'maplibre-gl/dist/maplibre-gl.css';
import {Marker, Popup} from "maplibre-gl";
// import './style.css'

const INITIAL_ZOOM = 5;
const ZOCALO: LngLatLike = [-99.1357763, 19.4326207];


function build_map() {
    console.log("Hello from build_map in main.ts.");

    return new maplibregl.Map({
        container: 'map', // container id
        style: 'https://demotiles.maplibre.org/style.json', // style URL
        center: ZOCALO,
        zoom: INITIAL_ZOOM,
    });
}


function add_marker(map: Map) {
    const paradero_conocido: LngLatLike = [-99.1476275, 19.431313];

    const popup = new Popup({offset: 25}).setText(
        'Zócalo is the common name of the main square in central Mexico City. ' +
        'Prior to the colonial period, it was the main ceremonial center in the Aztec city of Tenochtitlan.'
    );

    //const image = await map.loadImage('https://maplibre.org/maplibre-gl-js/docs/assets/custom_marker.png');
    //map.addImage('custom-marker', image.data);

    // create DOM element for the marker
    // const el = document.createElement('div');
    // el.id = 'marker';

    // create the marker
    // new maplibregl.Marker({element: el})
    //     .setLngLat(paradero_conocido)
    //     .setPopup(popup) // sets a popup on this marker
    //     .addTo(map);

    let marker = new Marker({color: "#C11007"});
    marker.setLngLat(paradero_conocido);
    marker.setPopup(popup);
    marker.addTo(map);
}


let map = build_map();
add_marker(map);
