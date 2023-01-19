<template>
  <v-card max-width="500px" elevation="0">
    <v-card-title class="text-overline">log in</v-card-title>
    <v-list-item>
      <v-list-item-content style="max-width: 350px">
        <div v-if="message">
          <v-alert
            type="error"
            text
            close-text="Close Alert"
            dismissible
            @input="message=''"
          >
            {{ message }}
          </v-alert>
        </div>
        <Textfield
          :dense="true"
          :label="email.label"
          :value="email.val"
          @update="email.update"
        ></Textfield>
        <Textfield
          :dense="true"
          :show="false"
          :showIcon="true"
          :label="password.label"
          :value="password.val"
          @update="password.update"
        ></Textfield>
        <v-sheet outlined color="black" rounded>
          <v-btn block text @click="login" :color="!message ? 'normal' : 'error'" dark>
            LOG IN
          </v-btn>
        </v-sheet>
        <div class="pt-5">
          <div>Create account? <a href="/signup">Sign up</a></div>
        </div>
      </v-list-item-content>
    </v-list-item>
  </v-card>
</template>

<script>
import {
  defineComponent,
  useContext,
  ref,
  useRouter,
} from "@nuxtjs/composition-api";

import Textfield from "~/components/fields/textfield.vue";
import { textfield } from "~/models/textfield";

export default defineComponent({
  name: "Login",
  components: { Textfield },
  setup() {
    let email = new textfield("email", "");
    let password = new textfield("password", "");
    const { $auth } = useContext();
    const router = useRouter();

    const message = ref("");
    const login = () => {
      const request = {
        email: email.val,
        password: password.val,
      };

      $auth.loginWith('local', { data: request })
        .then((resp) => {
          router.push("/");
        })
        .catch((error) => {
          console.log(error)
          console.log(error.response);
          message.value = error.response.data.message;
        });
    };

    return {
      email,
      password,
      message,
      login,
    };
  },
});
</script>

<style>
.message {
  color: red;
}
</style>