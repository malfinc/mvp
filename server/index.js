import React from "react"
import {join} from "path"
import {readFileSync} from "fs"
import requireEnvironmentVariables from "require-environment-variables"
import {createElement} from "react"
import {Provider as ReduxProvider} from "react-redux"
import {StaticRouter} from "react-router"
import {renderToString} from "react-dom/server"
import {HelmetProvider} from "react-helmet-async"
import express from "express"
import cors from "cors"
import morgan from "morgan"
import compression from "compression"
import helmet from "helmet"
import {extractStyles} from "evergreen-ui"

import {Application} from "@internal/ui"
import {Shell} from "@internal/ui"
import {rematch} from "@internal/store"

import logger from "./logger"

requireEnvironmentVariables([
  "PORT",
  "NODE_ENV",
  "ORIGIN_LOCATION",
])

const manifest = JSON.parse(readFileSync(join(__dirname, "..", "client", "webpack-assets.json")))

const application = express()

application.use(morgan(process.env.NODE_ENV === "production" ? "combined" : "dev"))
application.use(compression())
application.use(cors())
application.use(helmet())
application.use("/assets", express.static(join(__dirname, "..", "client"), {fallthrough: false}))
application.get("*", function render(request, response) {
  let helmetContext = {}
  let routerContext = {}
  const children = <HelmetProvider context={helmetContext}>
    <ReduxProvider store={rematch}>
      <StaticRouter location={request.url} context={routerContext}>
        <Application/>
      </StaticRouter>
    </ReduxProvider>
  </HelmetProvider>

  renderToString(children)

  if (routerContext.url) {
    return 400
  }

  return response.send(`<!DOCTYPE html>${renderToString(<Shell {...helmetContext} manifest={manifest} extractedStyles={extractStyles()}>{children}</Shell>)}`)
})

application.listen(
  process.env.PORT,
  function listener() {logger.info(`Listening to ${process.env.PORT}`)}
)
