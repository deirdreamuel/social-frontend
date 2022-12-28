<template>
  <div>
    <div>
      <Board :board="board" />
    </div>

    <div>
      <Textfield
        :label="move.label"
        :value="move.val"
        @update="move.update"
      ></Textfield>

      <div>
        <v-btn text @click="enter_move()" outlined> move chess piece </v-btn>
      </div>
    
    <div class="text-overline pt-5">
        VALID MOVES
    </div>
    <div>
        ------------------------------
    </div>
      <v-row class="d-flex justify-start">
        <v-col xs="12" sm="3" md="2" xl="1" v-for="m in moves" :key="m">
            {{ m }}
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
import { io } from "socket.io-client";

import Textfield from "~/components/fields/textfield.vue";
import { textfield } from "~/models/textfield";

import { defineComponent, ref } from "@nuxtjs/composition-api";

export default defineComponent({
  components: { Textfield },
  setup() {
    let move = new textfield("enter move");
    const turn = ref(false);
    const board = ref([" "] * 64);
    const moves = ref([]);

    const socket = io("http://localhost:5000");

    socket.on("connect", () => {
      console.log(`connected to socket ${socket.id}`); // x8WIv7-mJelg7on_ALbx
      socket.emit("setup", { data: "I'm connected!" });
    });

    socket.on("disconnect", () => {
      console.log("disconnected socket" + socket.id); // undefined
    });

    socket.on("send_move", () => {
      if (turn.value) {
        socket.emit("send_move", { data: socket.id });
      }
    });

    socket.on("valid_moves", (valid_moves) => {
      moves.value = valid_moves;
    });

    socket.on("move_success", (game) => {
      console.log("move success");
      board.value = game;
    });

    socket.on("move_error", (message) => {
      console.log("move error");
      console.log(message);
    });

    socket.on("setup", (game) => {
      board.value = game;
    });

    const hello = async () => {
      console.log(socket.connected);
      socket.emit("send_move", { data: "b4e5" });
    };

    const enter_move = async () => {
      socket.emit("send_move", move.val);
    };

    return { hello, board, move, enter_move, moves };
  },
});
</script>

<style>
</style>