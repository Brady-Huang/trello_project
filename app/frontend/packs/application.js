import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "../styles/"

//vue.js
import Vue from 'vue/dist/vue.esm';
document.addEventListener("turbolinks:load", function(event) {
  let el = document.querySelector('#board');
  if (el) {
    new Vue({
      el,
      data: {
        lists: JSON.parse(el.dataset.lists)
      }
    });
  }
})
Rails.start()
Turbolinks.start()
ActiveStorage.start()
