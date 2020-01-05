module.exports = {
  setupTestFrameworkScriptFile: ".jest/setup.js",
  snapshotSerializers: ["jest-emotion"],
  collectCoverage: true,
  collectCoverageFrom: [
    "./client/**/index.js",
    "./@internal/**/index.js",
    "./server/**/index.js",
  ],
};
