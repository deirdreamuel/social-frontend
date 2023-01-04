<template>
  <v-card max-width="500px" elevation="0">
    <v-card-title>Sign up to Social</v-card-title>
    <v-list-item>
      <v-list-item-content>
        <div v-if="message">
          <v-alert
            type="error"
            text
            close-text="Close Alert"
            dismissible
            @input="message = ''"
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
          :label="name.label"
          :value="name.val"
          @update="name.update"
        ></Textfield>
        <Textfield
          :dense="true"
          :label="phone.label"
          :value="phone.val"
          @update="phone.update"
        ></Textfield>

        <Textfield
          :dense="true"
          :show="false"
          :showIcon="true"
          :label="password.label"
          :value="password.val"
          @update="password.update"
        ></Textfield>
        <Textfield
          :dense="true"
          :show="false"
          :showIcon="true"
          :label="confirmPassword.label"
          :value="confirmPassword.val"
          @update="confirmPassword.update"
        ></Textfield>
        <v-btn
          block
          text
          @click="signup"
          :color="!message ? 'normal' : 'error'"
        >
          SIGN UP
        </v-btn>
        <div class="pt-5">
          <div>Have an account? <a href="/login">Log in</a></div>
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
  name: "Signup",
  components: { Textfield },
  setup() {
    const email = new textfield("email", "");
    const name = new textfield("name", "");
    const phone = new textfield("phone number", "");
    const password = new textfield("password", "");
    const confirmPassword = new textfield("confirm password", "");

    const { $axios } = useContext();
    const router = useRouter();

    const message = ref("");
    const signup = () => {
      const request = {
        email: email.val,
        name: name.val,
        phone: phone.val,
        password: password.val,
      };

      $axios
        .$post("/v1/auth/signup", request, {
          headers: { "Content-Type": "application/json" },
        })
        .then((resp) => {
          console.log("response");
          console.log(resp);
          router.push("/login");
        })
        .catch((error) => {
          console.log(error.response);
          message.value = error.response.data.message;
        });
    };

    return {
      name,
      name,
      phone,
      email,
      password,
      confirmPassword,
      message,
      signup,
    };
  },
});
</script>

<style>
.message {
  color: red;
}
</style>