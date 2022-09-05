<template>
  <div class="card">
    <div class="card-header">
      <img class="bait" 
           :src="item.bait.image_url"
           :alt="item.bait.name">
      <h5>
        <span class="count">{{ totalFishCaught() }}</span>
        fish totaling
        <span class="weight">{{ totalWeightCaught() }}</span> lbs
      </h5>
    </div>
    <div class="card-body">
      <h4 class="card-title">{{ item.bait.name }}</h4>
      <h5 class="card-subtitle">{{ item.bait.category }}</h5>
    </div>
    <div class="card-footer">
      <CatchForm :bait="item.bait" @catch-created="onCatchCreated"/>
      <CatchList :catches="catches"/>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import CatchForm from "@/components/CatchForm";
import CatchList from "@/components/CatchList";

export default {
  components: {
    CatchForm,
    CatchList
  },
  props: {
    item: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      catches: []
    };
  },
  created() {
    api.getCatches(this.item.bait.id).then(response => {
      this.catches = response.data;
    });
  },
  methods: {
    onCatchCreated(newCatch) {
      this.catches.unshift(newCatch);
    },
    totalFishCaught() {
      return this.catches.length || 0;
    },
    totalWeightCaught() {
      return this.catches.reduce((total, aCatch) => {
        return (total += parseFloat(aCatch.weight));
      }, 0);
    }
  }
};
</script>

<style scoped lang="scss">
.card {
  .card-header {
    color: $primary-text-color;
    border: 0;
    margin-bottom: 15px;

    h5 {
      color: $nav-secondary-color;
    }

    img.bait {
      width: 275px;
      padding: 0 0.5rem;
    }

    .count,
    .weight {
      font-weight: 800;
    }
  }
}

@media (min-width: 768px) {
  .card {
    flex-direction: row;
    flex-wrap: wrap;

    .card-body {
      padding-top: 3rem;
    }
  }
}
</style>
