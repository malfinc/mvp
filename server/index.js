import React from "react";
import {join} from "path";
import {readFileSync} from "fs";
import {existsSync} from "fs";
import requireEnvironmentVariables from "require-environment-variables";
import {Provider as ReduxProvider} from "react-redux";
import {StaticRouter} from "react-router";
import {renderToString} from "react-dom/server";
import {HelmetProvider} from "react-helmet-async";
import {extractStyles} from "evergreen-ui";
import express from "express";
import cors from "cors";
import morgan from "morgan";
import compression from "compression";
import helmet from "helmet";
import {reduceValues} from "@unction/complete";

import {Application} from "@internal/ui";
import rematch from "@internal/rematch";

import logger from "./logger";

requireEnvironmentVariables([
  "PORT",
  "NODE_ENV",
  "ORIGIN_LOCATION",
  "WEBPACK_ASSET_LOCATION",
]);

const webpackAssetScripts = reduceValues((accumulation) => (file) => {
  if (file.js) {
    return `${accumulation}<script src="/assets/${file.js}"></script>`;
  }

  return accumulation;
})(JSON.parse(readFileSync(join(__dirname, process.env.WEBPACK_ASSET_LOCATION))));
const application = express();


application.use(morgan(process.env.NODE_ENV === "production" ? "combined" : "dev"));
application.use(compression());
application.use(cors());
application.use(helmet());
application.use("/assets", express.static(join(__dirname, "..", "tmp", "client"), {fallthrough: false}));
application.get("*", (request, response) => {
  const helmetContext = {};
  const routerContext = {};
  const content = renderToString(<HelmetProvider context={helmetContext}>
    <ReduxProvider store={rematch}>
      <StaticRouter location={request.url} context={routerContext}>
        <Application />
      </StaticRouter>
    </ReduxProvider>
  </HelmetProvider>);
  const {css, hydrationScript} = extractStyles();

  if (routerContext.url) {
    return 400;
  }

  return response.send(`
    <!DOCTYPE html>
    <html lang="en" ${helmetContext.helmet.htmlAttributes.toString()}>
      <head>
        <meta charSet="utf-8" />
        ${helmetContext.helmet.title.toString()}
        <meta httpEquiv="x-ua-compatible" content="ie=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="robots" content="index,follow" />
        <meta className="environment" name="ORIGIN_LOCATION" content="${process.env.ORIGIN_LOCATION || ""}" />
        <meta className="environment" name="RESOURCE_LOCATION" content="${process.env.RESOURCE_LOCATION || ""}" />
        <meta className="environment" name="LUMIN_LOCATION" content="${process.env.LUMIN_LOCATION || ""}" />
        ${helmetContext.helmet.meta.toString()}
        ${helmetContext.helmet.base.toString()}
        <link rel="author" href="/assets/humans.txt" />
        <link rel="manifest" href="/assets/manifest.json" />
        <link rel="copyright" href="/assets/copyright.txt" />
        <link rel="apple-touch-icon" sizes="57x57" href="/assets/apple-icon-57x57.png" />
        <link rel="apple-touch-icon" sizes="60x60" href="/assets/apple-icon-60x60.png" />
        <link rel="apple-touch-icon" sizes="72x72" href="/assets/apple-icon-72x72.png" />
        <link rel="apple-touch-icon" sizes="76x76" href="/assets/apple-icon-76x76.png" />
        <link rel="apple-touch-icon" sizes="114x114" href="/assets/apple-icon-114x114.png" />
        <link rel="apple-touch-icon" sizes="120x120" href="/assets/apple-icon-120x120.png" />
        <link rel="apple-touch-icon" sizes="144x144" href="/assets/apple-icon-144x144.png" />
        <link rel="apple-touch-icon" sizes="152x152" href="/assets/apple-icon-152x152.png" />
        <link rel="apple-touch-icon" sizes="180x180" href="/assets/apple-icon-180x180.png" />
        <link rel="apple-touch-icon-precomposed" href="/assets/apple-icon-precomposed.png" />
        <link rel="icon" sizes="192x192" href="/assets/android-icon-192x192.png" />
        <link rel="icon" sizes="32x32" href="/assets/favicon-32x32.png" />
        <link rel="icon" sizes="96x96" href="/assets/favicon-96x96.png" />
        <link rel="icon" sizes="16x16" href="/assets/favicon-16x16.png" />
        <link rel="icon" href="/assets/favicon.ico" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Handlee%7COpen+Sans" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.0/normalize.min.css" integrity="sha256-oSrCnRYXvHG31SBifqP2PM1uje7SJUyX0nTwO2RJV54=" crossOrigin="anonymous" />
        ${helmetContext.helmet.link.toString()}
        <style id="server-side-rendered-css">
          ${css}
        </style>
        ${helmetContext.helmet.style.toString()}
        ${helmetContext.helmet.noscript.toString()}
        ${helmetContext.helmet.script.toString()}
        ${renderToString(hydrationScript)}
        <script>
          (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src='https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);})(window,document,'script','dataLayer','GTM-5GBMRT5');
        </script>
      </head>

      <body id="application" ${helmetContext.helmet.bodyAttributes.toString()}>
        <noscript>
          <iframe title="google tag manager" src="https://www.googletagmanager.com/ns.html?id=GTM-5GBMRT5" height="0" width="0" style="display: none; visibility: none;"></iframe>
        </noscript>

        <noscript>
          <h1>Hello!</h1>

          <p>
            You&apos;re visiting a application that works almost entirely via Javascript,
            but you don&apos;t have Javascript enabled. I get why you might do that,
            considering the nature of the modern web, but I like writing javascript
            and it makes designing UI a much more enjoyable experience.
          </p>

          <p>
            I would love to spend time making the application work without
            Javascript, but I just don&apos;t have the time or energy to do this! While
            server-side rendering is very common and approachable the technology I
            decided to work with is experimental and currently doesn&apos;t have any
            integration with server-side rendering.
          </p>

          <p>
            I&apos;m a big fan of the open web and accessability and I try very hard to
            make Lacqueristas a home for <strong>anyone</strong> interested in
            nail polish. You are not invisible to this team.
            <a href="mailto:team@poutineer.com" title="Let me know you want a non-javascript version of lacqueristas">
              I would love to hear from you on this issue and our email is open to
              anyone wanting to talk about it.
            </a>
          </p>
        </noscript>

        ${content}

        <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/solid.js" integrity="sha384-6FXzJ8R8IC4v/SKPI8oOcRrUkJU8uvFK6YJ4eDY11bJQz4lRw5/wGthflEOX8hjL" crossOrigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/brands.js" integrity="sha384-zJ8/qgGmKwL+kr/xmGA6s1oXK63ah5/1rHuILmZ44sO2Bbq1V3p3eRTkuGcivyhD" crossOrigin="anonymous"></script>
        <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/fontawesome.js" integrity="sha384-xl26xwG2NVtJDw2/96Lmg09++ZjrXPc89j0j7JHjLOdSwHDHPHiucUjfllW0Ywrq" crossOrigin="anonymous"></script>
        ${webpackAssetScripts}
      </body>
    </html>
  `);
});

application.listen(
  process.env.PORT,
  () => {
    logger.info(`Listening to ${process.env.PORT}`);
  }
);
