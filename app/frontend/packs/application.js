import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "../styles/"

//vue.js
import Vue from 'vue/dist/vue.esm';
import List from 'components/list';
import Newlist from 'components/new_list';
import draggable from 'vuedraggable';
import store from 'stores/list';
import {mapGetters, mapActions } from 'vuex';
document.addEventListener("turbolinks:load", function(event) {
  let el = document.querySelector('#board');
  if (el) {
    new Vue({
      el,
      store,
      computed: {
        lists: {
          get() {
            return this.$store.state.lists;
          },
          set(value) {
            this.$store.commit("UPDATE_LISTS", value);
          }
        }
      },
      components: { List,draggable,Newlist },
      methods: {
        ...mapActions(["loadList","moveList"]),

      },
      beforeMount() {
        this.loadList();
      }
    });
  }
})
Rails.start()
Turbolinks.start()
ActiveStorage.start()
