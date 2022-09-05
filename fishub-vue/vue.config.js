// Project-specific Vue configuration
// See https://cli.vuejs.org/config/#global-cli-config

const path = require("path");

module.exports = {
  lintOnSave: true,
  chainWebpack: config => {
    // Automatically imports "./src/assets/_variables.scss" in
    // every single-file Vue component and every SCSS file.
    const types = ["vue-modules", "vue", "normal-modules", "normal"];
    types.forEach(type =>
      addStyleResource(config.module.rule("scss").oneOf(type))
    );
  }
};

function addStyleResource(rule) {
  rule
    .use("style-resource")
    .loader("style-resources-loader")
    .options({
      patterns: [path.resolve(__dirname, "./src/assets/_variables.scss")]
    });
}
