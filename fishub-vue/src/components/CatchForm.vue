<template>
  <div class="container">
    <Errors :errors="errors" />
    <form @submit.prevent="logCatch">
      <div class="form-row">
        <div class="col">
          <div class="input-group">
            <select class="form-control" ref="species"
                    v-model="theCatch.species" 
                    required>
              <option disabled value="">Species</option>
              <option v-for="speciesOption in speciesOptions"
                      :key="speciesOption" :value="speciesOption">
                {{ speciesOption }}
              </option>
            </select>
          </div>
        </div>
        <div class="col">
          <div class="input-group">
            <input class="form-control"
                    type="number"
                    required
                    v-model.number.trim="theCatch.weight">
            <div class="input-group-append">
              <span class="input-group-text">pounds</span>
            </div>
          </div>
        </div>
        <div class="col">
          <div class="input-group">
            <input class="form-control"
                    type="number"
                    required
                    v-model.number.trim="theCatch.length">
            <div class="input-group-append">
              <span class="input-group-text">inches</span>
            </div>
          </div>
        </div>
        <div class="col">
          <button type="submit" class="btn btn-outline-secondary">
            🐟 Log Catch
          </button>
        </div>
      </div>
    </form>

  </div>
</template>

<script>
import api from "@/api";
import Errors from "@/components/Errors";

export default {
  components: { Errors },
  props: {
    bait: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      theCatch: this.newCatch(),
      errors: {},
      speciesOptions: [
        "Rainbow Trout",
        "Brown Trout",
        "Lake Trout",
        "Largemouth Bass",
        "Smallmouth Bass",
        "Bluegill",
        "Walleye"
      ]
    };
  },
  methods: {
    newCatch() {
      return {
        species: "",
        weight: "",
        length: ""
      };
    },
    logCatch() {
      api
        .createCatch(this.bait.id, this.theCatch)
        .then(response => {
          this.$emit("catch-created", response.data);
          this.reset();
        })
        .catch(error => {
          this.errors = error.response.data.errors;
        });
    },
    reset() {
      this.theCatch = this.newCatch();
      this.errors = {};
      this.setFocus();
    },
    setFocus() {
      this.$refs.species.focus();
    }
  },
  mounted() {
    this.setFocus();
  }
};
</script>

<style scoped lang="scss">
.btn {
  color: $blue-accent-color;
  border-color: $blue-accent-color;
  text-transform: uppercase;

  &:hover {
    background-color: $green-accent-color;
    color: white;
  }
}
</style>
