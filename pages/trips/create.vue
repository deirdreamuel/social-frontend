<template>
  <div class="d-flex flex-column">
    <div class="d-flex justify-center">
      <div style="min-width: 300px">
        <v-list-item>
          <v-list-item-content style="max-width: 350px">
            <div class="text-overline">CREATE TRIP</div>
            <div class="py-2" />
            <div>
              <div class="text-overline">FROM</div>
              <v-menu ref="fromDateMenu" :modelValue="fromDateMenu" :close-on-content-click="false" transition="scale-transition"
              offset-y max-width="290px" min-width="auto">
              <template v-slot:activator="{ on, attrs }">
                <v-text-field persistent-hint append-icon="mdi-calendar" color="black"
                  v-bind="attrs" v-on="on" outlined dense />
              </template>
              <v-date-picker :modelValue="date" no-title @input="menu1.value = false" color="black" />
            </v-menu>
            </div>
            <div>
              <div class="text-overline">UNTIL</div>
              <v-menu ref="toDateMenu" :modelValue="toDateMenu" :close-on-content-click="false" transition="scale-transition"
              offset-y max-width="290px" min-width="auto">
              <template v-slot:activator="{ on, attrs }">
                <v-text-field persistent-hint append-icon="mdi-calendar" color="black"
                  v-bind="attrs" v-on="on" outlined dense />
              </template>
              <v-date-picker :modelValue="date" no-title @input="menu1.value = false" color="black" />
            </v-menu>
            </div>
            
            <Textfield :label="name.label" :value="name.val" @update="name.update" :dense="true" />
            <div>
              <div class="text-overline">Details</div>
              <v-textarea color="black" outlined name="input-7-4" :value="details.val" />
            </div>

            <Textfield :label="city.label" :value="city.val" @update="city.update" :dense="true" />
            <div class="d-flex justify-space-between" style="gap: 10px">
              <Textfield :label="state.label" :value="state.val" @update="state.update" :dense="true" />
              <Textfield :label="country.label" :value="country.val" @update="country.update" :dense="true" />
            </div>

            <v-sheet outlined color="black" rounded>
              <v-btn block dark color="black">CREATE TRIP</v-btn>
            </v-sheet>
          </v-list-item-content>
        </v-list-item>
      </div>
    </div>
  </div>
</template>

<script>
import Textfield from "~/components/fields/textfield.vue";
import { textfield } from "~/models/textfield";

import { defineComponent, useContext, ref } from "@nuxtjs/composition-api";

export default defineComponent({
  components: { Textfield },
  setup() {
    const name = new textfield("trip name", "");
    const details = new textfield("details", "");
    const city = new textfield("city", "");
    const state = new textfield("state", "");
    const country = new textfield("country", "");

    const fromDateMenu = ref(false)
    const toDateMenu = ref(false)

    const date = (new Date(Date.now() - (new Date()).getTimezoneOffset() * 60000)).toISOString().substr(0, 10)
    return {
      name,
      details,
      city,
      state,
      country,
      fromDateMenu,
      toDateMenu,
      date
    }
  }
})

</script>

<style>

</style>