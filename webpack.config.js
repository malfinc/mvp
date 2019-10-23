// eslint-disable no-undef import/no-commonjs import/no-nodejs-modules
const path = require("path");
const {HashedModuleIdsPlugin} = require("webpack");
const {HotModuleReplacementPlugin} = require("webpack");
// const WebpackNodeExternals = require("webpack-node-externals");
const {IgnorePlugin} = require("webpack");
const {EnvironmentPlugin} = require("webpack");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const CompressionWebpackPlugin = require("compression-webpack-plugin");
const {CleanWebpackPlugin} = require("clean-webpack-plugin");
const {BundleAnalyzerPlugin} = require("webpack-bundle-analyzer");
const {Plugin: WebpackCommonShake} = require("webpack-common-shake");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const WebpackAssetsManifest = require("webpack-assets-manifest");
const WebpackSubresourceIntegrity = require("webpack-subresource-integrity");
const DotenvWebpack = require("dotenv-webpack");
const {config: dotenvConfiguration} = require("dotenv");
const {compact} = require("@unction/complete");

dotenvConfiguration();

const BENCHMARK = process.env.BENCHMARK === "enabled";
const NODE_ENV = process.env.NODE_ENV || "development";
const PACKAGE_ASSETS = [];

module.exports = [
  {
    mode: NODE_ENV,
    entry: [
      "@babel/polyfill",
      "./client/index.js",
    ],
    target: "web",
    devtool: NODE_ENV === "production" ? "source-map" : "inline-source-map",
    output: {
      path: path.resolve(__dirname, "tmp", "client"),
      filename: "[name].[hash].js",
    },
    optimization: {
      minimize: NODE_ENV === "production",
      runtimeChunk: "single",
      splitChunks: {
        minSize: 0,
        maxAsyncRequests: Infinity,
        maxInitialRequests: Infinity,
        cacheGroups: {
          internal: {
            test: /@internal[\\/]/u,
            chunks: "initial",
            priority: -40,
          },
          unction: {
            test: /[\\/]node_modules[\\/]@unction/u,
            chunks: "initial",
            priority: -30,
          },
          ramda: {
            test: /[\\/]node_modules[\\/]ramda/u,
            chunks: "initial",
            priority: -30,
          },
          moment: {
            test: /[\\/]node_modules[\\/]moment/u,
            chunks: "initial",
            priority: -20,
          },
          most: {
            test: /[\\/]node_modules[\\/]most/u,
            chunks: "initial",
            priority: -20,
          },
          elliptic: {
            test: /[\\/]node_modules[\\/]elliptic/u,
            chunks: "initial",
            priority: -20,
          },
          bn: {
            test: /[\\/]node_modules[\\/]bn/u,
            chunks: "initial",
            priority: -20,
          },
          redux: {
            test: /[\\/]node_modules[\\/]redux/u,
            chunks: "initial",
            priority: -20,
          },
          react: {
            test: /[\\/]node_modules[\\/]react(?:-dom|-router|-router-dom|-redux)?[\\/]/u,
            chunks: "initial",
            priority: -20,
          },
          babel: {
            test: /[\\/]node_modules[\\/]@babel/u,
            chunks: "initial",
            priority: -20,
          },
          corejs: {
            test: /[\\/]node_modules[\\/]core-js/u,
            chunks: "initial",
            priority: -20,
          },
          pouchdb: {
            test: /[\\/]node_modules[\\/](?:pouchdb|lunr)/u,
            chunks: "initial",
            priority: -20,
          },
          vendors: {
            test: /[\\/]node_modules[\\/]/u,
            chunks: "initial",
            priority: -40,
          },
        },
      },
    },
    module: {
      rules: [
        {
          test: /index\.js$/u,
          exclude: /node_modules/u,
          use: {
            loader: "babel-loader",
          },
        },
      ],
    },
    devServer: {
      contentBase: path.join(__dirname, "tmp", "client"),
      compress: true,
      port: 9000,
      historyApiFallback: true,
      hot: true,
      overlay: true,
    },
    plugins: compact([
      NODE_ENV === "production" ? null : new DotenvWebpack(),
      NODE_ENV === "production" ? null : new HotModuleReplacementPlugin(),
      new EnvironmentPlugin([
        "NODE_ENV",
        "BENCHMARK",
        "COUCHDB_USERNAME",
        "COUCHDB_PASSWORD",
        "COUCHDB_URI",
      ]),
      NODE_ENV === "production" ? new IgnorePlugin(/^\.\/locale$/u, /moment$/u) : null,
      NODE_ENV === "production" ? new CleanWebpackPlugin({verbose: true}) : null,
      new HtmlWebpackPlugin({
        minify: {
          removeComments: true,
          collapseWhitespace: true,
          removeRedundantAttributes: true,
          useShortDoctype: true,
          removeEmptyAttributes: true,
          minifyJS: true,
          minifyCSS: true,
        },
        hash: true,
        template: "client/index.html",
        baseURL: process.env.ORIGIN_LOCATION,
        themeColor: "#4285f4",
        description: "Front page",
      }),
      new HashedModuleIdsPlugin(),
      new CopyWebpackPlugin([{
        from: path.resolve(__dirname, "assets"),
        to: path.resolve(__dirname, "tmp", "client"),
      }]),
      ...PACKAGE_ASSETS.map(([from, ...to]) => new CopyWebpackPlugin([{
        from,
        to: path.resolve(__dirname, "tmp", "client", ...to),
      }])),
      new WebpackCommonShake(),
      NODE_ENV === "production" ? new WebpackSubresourceIntegrity({
        hashFuncNames: ["sha256", "sha384"],
        enabled: true,
      }) : null,
      NODE_ENV === "production" ? new CompressionWebpackPlugin({
        filename: "[path].br[query]",
        algorithm: "brotliCompress",
        compressionOptions: {level: 11},
        test: /\.(?:js|css|txt|xml|json|png|svg|jpg|gif|woff|woff2|eot|ttf|otf)$/iu,
      }) : null,
      NODE_ENV === "production" ? new CompressionWebpackPlugin({
        test: /\.(?:js|css|txt|xml|json|png|svg|jpg|gif|woff|woff2|eot|ttf|otf)$/iu,
      }) : null,
      new WebpackAssetsManifest({
        output: "asset-integrity-manifest.json",
        integrity: NODE_ENV === "production",
      }),
      BENCHMARK ? new BundleAnalyzerPlugin({analyzerMode: "static", openAnalyzer: false}) : null,
    ]),
  },
];
