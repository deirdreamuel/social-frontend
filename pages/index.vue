<template>
  <div class="d-flex flex-column">
    <div class="d-flex justify-center">
      <div style="min-width: 300px">
        <div>
          <p class="font-weight-bold">Your Upcoming Trips</p>
        </div>
        <div v-if="!upcomingTrips">
          <div class="box">
            <div class="d-flex flex-column px-2">
              <v-skeleton-loader type="list-item-two-line"></v-skeleton-loader>
            </div>
          </div>
        </div>
        <div v-if="upcomingTrips && upcomingTrips.length !== 0">
          <div v-for="item in upcomingTrips" :key="item.id">
            <div class="box">
              <div class="d-flex flex-column px-2">
                <div class="d-flex justify-space-between">
                  <div class="text-overline">
                    {{ item.name }}
                  </div>
                  <div class="text-overline">
                    {{ item.from_date }}
                  </div>
                </div>
                <div class="d-flex justify-end">
                  <div class="text-overline">
                    {{ item.location.city }}, {{ item.location.state }}, {{ item.location.country }}
                  </div>
                </div>
              </div>
            </div>
            <div class="py-2" />
          </div>
        </div>
        <div v-if="upcomingTrips && upcomingTrips.length === 0">
          No Trips Found, Please Join or Create a Trip
        </div>
      </div>
    </div>
    <div class="d-flex justify-center mt-5">
      <div style="min-width: 300px">
        <div>
          <p class="font-weight-bold">Your Past Trips</p>
        </div>
        <div v-if="!pastTrips">
          <div class="box">
            <div class="d-flex flex-column px-2">
              <v-skeleton-loader type="list-item-two-line"></v-skeleton-loader>
            </div>
          </div>
        </div>
        <div v-if="pastTrips && pastTrips.length !== 0">
          <div v-for="item in pastTrips" :key="item.id">
            <div class="box">
              <div class="d-flex flex-column px-2">
                <div class="d-flex justify-space-between">
                  <div class="text-overline">
                    {{ item.name }}
                  </div>
                  <div class="text-overline">
                    {{ item.from_date }}
                  </div>
                </div>
                <div class="d-flex justify-end">
                  <div class="text-overline">
                    {{ item.location.city }}, {{ item.location.state }}, {{ item.location.country }}
                  </div>
                </div>
              </div>
            </div>
            <div class="py-2" />
          </div>
        </div>
        <div v-if="pastTrips && pastTrips.length === 0">
          No Trips Found, Please Join or Create a Trip
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { defineComponent, useContext, ref } from "@nuxtjs/composition-api";
import moment from "moment";

export default defineComponent({
  setup() {
    const { $axios } = useContext();

    const message = ref("");

    const upcomingTrips = ref(null);
    const pastTrips = ref(null)

    $axios
      .$get("/v1/user/cc4139f6-749d-42d9-b0a0-80da18f434fa/trips")
      .then((resp) => {
        upcomingTrips.value = resp.filter((item) => {
          return new Date(item.from_date) > new Date()
        })
        upcomingTrips.value.forEach((item) => {
          item.from_date = moment(item.from_date).format("MMMM DD YYYY")
        })

        pastTrips.value = resp.filter((item) => {
          return new Date(item.from_date) < new Date()
        })
        pastTrips.value.forEach((item) => {
          item.from_date = moment(item.from_date).format("MMMM DD YYYY")
        })

        console.log("upcoming res", upcomingTrips.value)
        console.log("past trips", pastTrips.value)
      })
      .catch((error) => {
        console.log(error.response);
        message.value = error.response.data.message;
      });

    return { pastTrips, upcomingTrips };
  },
});
</script>

<style>
.box {
  border: 1px solid #000000;
  border-radius: 5px;
  width: 300px;
  height: 80px;
}

.box:hover {
  border: 2px solid #000000;
}
</style>