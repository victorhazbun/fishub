<template>
  <div class="container">
    <div v-show="isLoading" class="spinner">
      <i class="fas fa-spinner fa-spin"></i>
    </div>
    <div class="row">
      <div v-for="bait in baits" :key="bait.id" class="col-md-4">
        <Bait :bait="bait"/>
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import Bait from "@/components/Bait";

export default {
  components: {
    Bait
  },
  data() {
    return {
      baits: [],
      isLoading: true
    };
  },
  created() {
    api.getBaits().then(response => {
      this.baits = response.data;
      this.isLoading = false;
    });

    this.$store.dispatch("getTackleBoxItems");
  }
};
</script>

<style scoped lang="scss">
.spinner {
  font-size: 7rem;
  text-align: center;
}
</style>
