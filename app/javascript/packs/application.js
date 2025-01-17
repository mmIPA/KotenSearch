// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

import "jquery";
import "popper.js";
import "bootstrap";
import '../../assets/stylesheets/application.scss';

import "../../assets/stylesheets/homes.scss";

Rails.start();
Turbolinks.start();
ActiveStorage.start();

document.addEventListener('turbolinks:load', function () {
  const toggleButton = document.getElementById('navbar-toggle');
  const navbarRight = document.getElementById('navbar-right');

  if (toggleButton && navbarRight) {
    toggleButton.addEventListener('click', function () {
      navbarRight.classList.toggle('active');
    });
  }
});