<template>
  <div class="d-flex flex-column">
    <div class="d-flex justify-center">
      <div style="min-width: 300px">
        <v-list-item>
          <v-list-item-content style="max-width: 350px">
            <div class="d-flex justify-start align-center" style="gap: 5px">
              <div>
                <v-btn @click="router.back()" icon>
                  <v-icon color="black">mdi-arrow-left</v-icon>
                </v-btn>
              </div>
              <div class="text-overline">CREATE TRIP</div>
            </div>

            <div class="py-2" />
            <div>
              <div class="text-overline">FROM DATE</div>
              <v-menu v-model="dates.fromDate.menu" :close-on-content-click="false" transition="scale-transition"
                offset-y max-width="290px" min-width="auto">
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field :value="dates.fromDate.formatted" append-icon="mdi-calendar" color="black"
                    v-bind="attrs" v-on="on" outlined dense />
                </template>
                <v-date-picker :modelValue="dates.fromDate.val" no-title @input="handleFromDateInput" color="black" />
              </v-menu>
            </div>
            <div>
              <div class="text-overline">UNTIL DATE</div>
              <v-menu v-model="dates.toDate.menu" :close-on-content-click="false" transition="scale-transition" offset-y
                max-width="290px" min-width="auto">
                <template v-slot:activator="{ on, attrs }">
                  <v-text-field :value="dates.toDate.formatted" append-icon="mdi-calendar" color="black" v-bind="attrs"
                    v-on="on" outlined dense />
                </template>
                <v-date-picker :modelValue="dates.toDate.val" no-title @input="handleToDateInput" color="black" />
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
              <v-btn block dark color="black" @click="handleCreateTrip">CREATE TRIP</v-btn>
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
import moment from "moment";

import { defineComponent, useRouter, useContext, ref, reactive } from "@nuxtjs/composition-api";
import axios from "axios";

export default defineComponent({
  components: { Textfield },
  setup() {
    const router = useRouter()
    const { $axios } = useContext()

    const name = new textfield("trip name", "");
    const details = new textfield("details", "");
    const city = new textfield("city", "");
    const state = new textfield("state", "");
    const country = new textfield("country", "");

    const dates = reactive({
      fromDate: {
        menu: false,
        val: '',
        formatted: ''
      },
      toDate: {
        menu: false,
        val: '',
        formatted: ''
      }
    })

    const handleFromDateInput = (input) => {
      dates.fromDate.val = input
      dates.fromDate.formatted = moment(input).format("MMMM DD, YYYY");
      dates.fromDate.menu = false
    }

    const handleToDateInput = (input) => {
      dates.toDate.val = input
      dates.toDate.formatted = moment(input).format("MMMM DD, YYYY");
      dates.toDate.menu = false
    }

    const message = ref('')

    function handleCreateTrip() {
      const request = {
        "from_date": "2023-03-05T02:48:00Z",
        "to_date": "2023-03-05T02:48:00Z",
        "name": "NEW YORK TRIP",
        "description": "going to nyc...",
        "location": {
              "city": "NEW YORK",
              "state": "NY",
              "country": "US"
          }
      }

      $axios
        .$post("/v1/trip", request, {
          headers: { "Content-Type": "application/json" },
        })
        .then((resp) => {
          console.log("response");
          console.log(resp);
          router.push("/")
        })
        .catch((error) => {
          console.log(error.response);
          message.value = error.response.data.message;
        });

      return;
    }

    return {
      router,
      name,
      details,
      city,
      state,
      country,
      dates,
      message,
      handleFromDateInput,
      handleToDateInput,
      handleCreateTrip
    }
  }
})

</script>

<style>

</style>