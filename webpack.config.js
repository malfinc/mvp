const path = require("path");
const {HashedModuleIdsPlugin} = require("webpack");
const WebpackNodeExternals = require("webpack-node-externals");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const CompressionWebpackPlugin = require("compression-webpack-plugin");
const AssetsWebpackPlugin = require("assets-webpack-plugin");
const CleanWebpackPlugin = require("clean-webpack-plugin");
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const FriendlyErrorsWebpackPlugin = require("friendly-errors-webpack-plugin");
const WebpackVisualizerPlugin = require("webpack-visualizer-plugin");
const {compact} = require("@unction/complete");

const BENCHMARK = process.env.BENCHMARK === "enabled";
const NODE_ENV = process.env.NODE_ENV || "development";

const PACKAGE_ASSETS = [
  ["node_modules/@babel/polyfill/dist/polyfill.js", "babel-polyfill.js"],
];
const DEFAULT_CONFIGURATION = {
  mode: NODE_ENV,
};
const DEFAULT_PLUGINS = compact([
  BENCHMARK ? new WebpackVisualizerPlugin() : null,
  BENCHMARK ? new FriendlyErrorsWebpackPlugin() : null,
  BENCHMARK ? new BundleAnalyzerPlugin({analyzerMode: "static"}) : null,
  new CopyWebpackPlugin([{
    from: path.resolve(__dirname, "assets"),
    to: path.resolve(__dirname, "tmp", "client"),
  }]),
  ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
    from,
    to: path.resolve(__dirname, "tmp", "client", ...to),
  }])),
  NODE_ENV === "production" ? new CompressionWebpackPlugin({
    test: /\.(js|css|txt|xml|json|png|svg|jpg|gif|woff|woff2|eot|ttf|otf)$/i,
  }) : null,
  new AssetsWebpackPlugin({
    path: path.join(__dirname, "tmp", "client"),
    integrity: true,
  }),
]);
const DEFAULT_BABEL_CONFIGURATION = {
  test: /index\.js$/,
  exclude: /node_modules/,
  use: {
    loader: "babel-loader",
  },
};

module.exports = [
  {
    ...DEFAULT_CONFIGURATION,
    entry: [
      "core-js/modules/es6.promise",
      "core-js/modules/es6.array.iterator",
      "./client/index.js",
    ],
    target: "web",
    devtool: "source-map",
    output: {
      path: path.resolve(__dirname, "tmp", "client"),
      chunkFilename: "[name].[chunkhash].js",
      filename: "[name].[chunkhash].js",
    },
    optimization: {
      runtimeChunk: "single",
      splitChunks: {
        cacheGroups: {
          internal: {
            test: /[\\/]@internal[\\/]/,
            name: "internal",
            chunks: "initial",
          },
          commons: {
            test: /[\\/]node_modules[\\/]/,
            name: "vendor",
            chunks: "all",
          },
        },
      },
    },
    module: {
      rules: [
        DEFAULT_BABEL_CONFIGURATION,
        {
          test: /\.css$/,
          use: {
            loader: "file-loader",
          },
        },
        {
          test: /\.(png|svg|jpg|gif)$/,
          use: {
            loader: "file-loader",
          },
        },
        {
          test: /\.(woff|woff2|eot|ttf|otf)$/,
          use: {
            loader: "file-loader",
          },
        },
      ],
    },
    plugins: compact([
      ...DEFAULT_PLUGINS,
      new HashedModuleIdsPlugin(),
      NODE_ENV === "production" ? new CleanWebpackPlugin({verbose: true}) : null,
    ]),
  },
  {
    ...DEFAULT_CONFIGURATION,
    entry: "./server/index.js",
    target: "node",
    devtool: "source-map",
    node: {
      __dirname: false,
      __filename: false,
    },
    externals: [
      WebpackNodeExternals(),
    ],
    output: {
      path: path.resolve(__dirname, "tmp", "server"),
      filename: "index.js",
      libraryTarget: "commonjs2",
    },
    module: {
      rules: [
        DEFAULT_BABEL_CONFIGURATION,
      ],
    },
    plugins: compact([
      ...DEFAULT_PLUGINS,
      NODE_ENV === "production" ? new CleanWebpackPlugin({verbose: true}) : null,
    ]),
  },
];
