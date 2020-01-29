<template>
  <div class="">
    <AddOrder msg="Welcome to Your Vue.js App" />
  </div>
</template>

<script>
// @ is an alias to /src
import AddOrder from "@/components/AddOrder.vue";

export default {
  name: "home",
  components: {
    AddOrder
  }
};
</script>
