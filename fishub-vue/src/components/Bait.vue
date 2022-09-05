<template>
  <div class="card">
    <img class="card-img-top bait" 
          :src="bait.image_url"
          :alt="bait.name">
    <div class="card-body">
      <h5 class="card-title">{{ bait.name }}</h5>
      <h6 class="card-subtitle">{{ bait.category }}</h6>
      <router-link v-if="isInTackleBox(bait)"
                   class="btn btn-secondary"
                   to="/tackle-box">
          In Tackle Box
      </router-link>
      <button v-else
              class="btn btn-outline-secondary"
              @click="addToTackleBox(bait)">
        <i class="fas fa-toolbox"></i>   
        Tackle Box
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    bait: {
      type: Object,
      required: true
    }
  },
  computed: {
    tackleBoxItems() {
      return this.$store.state.tackleBoxItems;
    },
    isAuthenticated() {
      return this.$store.getters.isAuthenticated;
    }
  },
  methods: {
    isInTackleBox(bait) {
      return this.tackleBoxItems.find(item => item.bait.id === bait.id);
    },
    addToTackleBox(bait) {
      if (this.isAuthenticated) {
        this.$store.dispatch("createTackleBoxItem", bait.id);
      } else {
        this.$router.push("sign-in");
      }
    }
  }
};
</script>

<style scoped lang="scss">
.card {
  margin-bottom: 1.5rem;

  .btn {
    text-transform: uppercase;
    font-size: 0.85rem;
  }

  img.bait {
    padding: 0.75rem;

    &:hover {
      animation: wiggle 0.6s 1;
    }
  }

  .fa-toolbox {
    margin-right: 3px;
  }
}

@keyframes wiggle {
  0% {
    transform: translate(1px, 1px) rotate(0deg);
  }
  10% {
    transform: translate(-1px, -2px) rotate(-1deg);
  }
  20% {
    transform: translate(-3px, 0px) rotate(1deg);
  }
  30% {
    transform: translate(3px, 2px) rotate(0deg);
  }
  40% {
    transform: translate(1px, -1px) rotate(1deg);
  }
  50% {
    transform: translate(-1px, 2px) rotate(-1deg);
  }
  60% {
    transform: translate(-3px, 1px) rotate(0deg);
  }
  70% {
    transform: translate(3px, 1px) rotate(-1deg);
  }
  80% {
    transform: translate(-1px, -1px) rotate(1deg);
  }
  90% {
    transform: translate(1px, 2px) rotate(0deg);
  }
  100% {
    transform: translate(1px, -2px) rotate(-1deg);
  }
}
</style>
