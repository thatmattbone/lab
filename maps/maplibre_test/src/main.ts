import maplibregl, {type LngLatLike} from 'maplibre-gl';
import 'maplibre-gl/dist/maplibre-gl.css';
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

build_map();
