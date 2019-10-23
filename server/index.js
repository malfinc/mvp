import {join} from "path";
import React from "react";
import requireEnvironmentVariables from "require-environment-variables";
import {Provider as ReduxProvider} from "react-redux";
import {StaticRouter} from "react-router";
import {renderToString} from "react-dom/server";
import express from "express";
import cors from "cors";
import morgan from "morgan";
import compression from "compression";
import helmet from "helmet";


import logger from "./logger";
import {Application} from "@internal/elements";

requireEnvironmentVariables([
  "PORT",
  "NODE_ENV",
  "WWW_ORIGIN",
  "SUPPORT_EMAIL",
]);
const rootDirectory = join(__dirname, process.env.NODE_ENV === "production" ? "../" : "../tmp");
const application = express();

application.use(morgan(process.env.NODE_ENV === "production" ? "combined" : "dev"));
application.use(compression());
application.use(cors());
application.use(helmet());
application.use("/assets", express.static(join(rootDirectory, "client"), {fallthrough: false}));
application.get("*", (request, response) => {
  const helmetContext = {};
  const routerContext = {};
  const content = renderToString(
    <ReduxProvider store={{}}>
      <StaticRouter location={request.url} context={routerContext}>
        <Application />
      </StaticRouter>
    </ReduxProvider>
  );

  if (routerContext.url) {
    return 400;
  }

  return response.send("");
});

application.listen(
  process.env.PORT,
  () => {
    logger.info(`Listening to ${process.env.PORT}`);
  }
);
