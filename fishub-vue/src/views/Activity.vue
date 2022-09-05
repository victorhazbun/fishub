<template>
  <div class="container">
    <div v-for="event in events" :key="event.id" class="card text-left">
      <div class="card-header">
        <span class="username">{{ event.username }}</span> 
        logged a catch on 
        <span class="date">{{ event.created_at | formatDate }}</span>
      </div>
      <div class="card-body">
        <p class="card-text">
          <img class="bait" 
               :src="event.bait_image_url"
               :alt="event.bait">
          <span class="species">{{ event.species }}</span> weighing
          <span class="weight">{{ event.weight }} pounds</span>
          with a length of 
          <span class="length">{{ event.length }} inches</span>
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api";
import dateFns from "date-fns";

export default {
  data() {
    return {
      events: []
    };
  },
  created() {
    api.getActivity().then(response => {
      this.events = response.data;
    });

    this.$store.dispatch("getTackleBoxItems");
  },
  filters: {
    formatDate(date) {
      return dateFns.format(date, "MMMM Do [at] h:mm a");
    }
  }
};
</script>

<style scoped lang="scss">
.card {
  margin-bottom: 1.5rem;

  .card-header {
    color: $secondary-text-color;
  }

  .card-body {
    font-size: 1.15rem;
  }

  img.bait {
    margin-right: 10px;
    width: 125px;
  }

  .species {
    font-weight: 800;
  }

  .username {
    font-weight: 600;
  }

  .weight,
  .length {
    font-weight: 600;
    background: $brand-text-color;
  }
}
</style>
