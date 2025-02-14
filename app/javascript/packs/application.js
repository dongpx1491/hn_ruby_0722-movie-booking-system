import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "owl.carousel2/dist/assets/owl.carousel.css";
import "jquery";
import "./main";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

require("packs/date_picker");
require('jquery');
import "bootstrap";
import "@fortawesome/fontawesome-free/css/all.css";
import "@fortawesome/fontawesome-free/css/all";

window.jQuery = $;
window.$ = $;

