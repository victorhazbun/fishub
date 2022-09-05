<template>
  <div v-if="isEmpty">
    <div class="container empty-box">
      <p>
        An empty tackle box catches no fish. 😕
      </p>
      <router-link to="/baits">Fill'er Up!</router-link>
    </div>
  </div>
  <div v-else>
    <div class="container-fluid">
      <div class="row">
        <div id="items" class="col-md-3 text-center">
          <div v-for="item in items" :key="item.id">
            <img :class="{ selected: isSelected(item) }"          
                 :src="item.bait.image_url"
                 :alt="item.bait.name"
                 @click="selectItem(item)">
          </div>
        </div>
        <div id="selected-item" class="col-md-9">
          <TackleBoxItem :item="selectedOrFirstItem" 
                         :key="selectedOrFirstItem.id" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import TackleBoxItem from "@/components/TackleBoxItem";

export default {
  components: {
    TackleBoxItem
  },
  data() {
    return {
      selectedItem: null
    };
  },
  created() {
    this.$store.dispatch("getTackleBoxItems");
  },
  computed: {
    items() {
      return this.$store.state.tackleBoxItems;
    },
    isEmpty() {
      return this.items.length == 0;
    },
    selectedOrFirstItem() {
      return this.selectedItem || this.items[0];
    }
  },
  methods: {
    selectItem(item) {
      this.selectedItem = item;
    },
    isSelected(item) {
      return this.selectedOrFirstItem.id === item.id;
    }
  }
};
</script>

<style scoped lang="scss">
#items {
  img {
    width: 175px;
    padding: 10px;
    cursor: pointer;
  }

  img.selected {
    border: 4px solid $muted-text-color;
  }
}

.empty-box {
  font-size: 2rem;
  color: $primary-text-color;
  text-align: center;
  padding: 2rem;
  border: 3px dashed $muted-text-color;
}
</style>
