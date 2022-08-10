// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery.flexslider
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= requre log
//= require_tree .
//= require_tree ../custom/.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
require("jquery");
import "bootstrap";
import "bootstrap/dist/js/bootstrap";
import "bootstrap/dist/css/bootstrap";
import "@fortawesome/fontawesome-free/css/all.css";
import "@fortawesome/fontawesome-free/css/all";
import owlCarousel from "owl.carousel2";
import "owl.carousel2/dist/assets/owl.carousel.css";
import "jquery";
window.bootstrap = require("bootstrap");
import "../custom/jquery.slicknav";
import "../custom/bootstrap.min";
import "../custom/jquery-3.3.1.min";
import "../custom/main";
import "../custom/player";
import "../custom/jquery.nice-select.min";
import "../custom/owl.carousel.min";
import "../custom/mixitup.min";

$(document).on("turbolinks:load", function() {
  $('.flexslider').flexslider();
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
