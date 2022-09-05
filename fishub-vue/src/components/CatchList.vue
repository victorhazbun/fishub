<template>
  <div class="container">
    <table class="table table-striped">
      <transition-group tag="tbody" name="fade">
        <tr v-for="theCatch in catches" :key="theCatch.id">
          <td class="date">{{ theCatch.created_at | formatDate }}</td>
          <td class="species">{{ theCatch.species }}</td>
          <td class="weight">{{ theCatch.weight }} pounds</td>
          <td class="length">{{ theCatch.length }} inches</td>
        </tr>
      </transition-group>
    </table>
  </div>
</template>

<script>
import dateFns from "date-fns";

export default {
  props: {
    catches: {
      type: Array,
      required: true
    }
  },
  filters: {
    formatDate(date) {
      return dateFns.format(date, "MMMM Do [at] h:mm a");
    }
  }
};
</script>

<style scoped lang="scss">
table {
  margin-top: 2rem;

  td.weight,
  td.length {
    text-align: right;
    padding-right: 3rem;
  }
}
</style>
