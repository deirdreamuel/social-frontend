<template>
  <div class="d-flex flex-column">
    <div class="d-flex justify-center">
      <b>count down until I see you again :)</b>
    </div>
    <div class="d-flex justify-center">
      {{ countdown }}
    </div>
  </div>
</template>

<script>
import { defineComponent, ref } from "@nuxtjs/composition-api";

export default defineComponent({
  auth: 'guest',
  setup() {
    const countDownDate = new Date("11 January 2023 03:01 UTC").getTime();
    const countdown = ref('')

    // Update the count down every 1 second
    const x = setInterval(function() {

      // Get today's date and time
      const now = new Date().getTime();

      // Find the distance between now and the count down date
      const distance = countDownDate - now;

      // Time calculations for days, hours, minutes and seconds
      const days = Math.floor(distance / (1000 * 60 * 60 * 24));
      const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
      const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
      const seconds = Math.floor((distance % (1000 * 60)) / 1000);

      // Display the result in the element with id="demo"
      countdown.value = `${days}d ${hours}h ${minutes}m ${seconds}s`

      // If the count down is finished, write some text
      if (distance < 0) {
        clearInterval(x);
        countdown.value = "Hooray!!! Count down finished, please see meeeee";
      }
    }, 1000);

    return { countdown }
  },
});
</script>
