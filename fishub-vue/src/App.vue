<template>
  <div id="app">
    <Header/>
    <div id="content">
      <!-- component matched by the route renders below -->
      <router-view/>
    </div>
    <Footer/>
  </div>
</template>

<script>
import Header from "@/components/Header";
import Footer from "@/components/Footer";

export default {
  components: {
    Header,
    Footer
  }
};
</script>

<style scoped lang="scss">
#app {
  font-family: "Barlow", "Avenir", Helvetica, Arial, sans-serif;
  color: $primary-text-color;
}

#content {
  padding-top: 4rem;
  padding-bottom: 2rem;
}
</style>
