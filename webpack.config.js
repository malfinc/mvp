const path = require("path");
const {HashedModuleIdsPlugin} = require("webpack");
const WebpackNodeExternals = require("webpack-node-externals");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const CompressionWebpackPlugin = require("compression-webpack-plugin");
const AssetsWebpackPlugin = require("assets-webpack-plugin");
const NodemonWebpackPlugin = require("nodemon-webpack-plugin");
const CleanWebpackPlugin = require("clean-webpack-plugin");
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const FriendlyErrorsWebpackPlugin = require("friendly-errors-webpack-plugin");
const WebpackVisualizerPlugin = require("webpack-visualizer-plugin");

const commonConfiguration = {
  mode: process.env.NODE_ENV || "development",
};
const commonPlugins = [
  // new BundleAnalyzerPlugin({analyzerMode: "static"}),
  // new FriendlyErrorsWebpackPlugin(),
  // new WebpackVisualizerPlugin()
];
const moduleBabel = {
  test: /index\.js$/,
  exclude: /node_modules/,
  use: {
    loader: "babel-loader",
  },
};

module.exports = [
  {
    ...commonConfiguration,
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
        moduleBabel,
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
    plugins: [
      ...commonPlugins,
      new CopyWebpackPlugin([{
        from: path.resolve(__dirname, "assets"),
        to: path.resolve(__dirname, "tmp", "client"),
      }]),
      new AssetsWebpackPlugin({
        path: path.join(__dirname, "tmp", "client"),
        integrity: true,
      }),
      new CompressionWebpackPlugin({
        test: /\.(js|css|txt|xml|json|png|svg|jpg|gif|woff|woff2|eot|ttf|otf)$/i,
      }),
      new HashedModuleIdsPlugin(),
      // new CleanWebpackPlugin({verbose: true}),
    ],
  },
  {
    ...commonConfiguration,
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
        moduleBabel,
      ],
    },
    plugins: [
      ...commonPlugins,
      new NodemonWebpackPlugin(),
      // new CleanWebpackPlugin({verbose: true}),
    ],
  },
];
