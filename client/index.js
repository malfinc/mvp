import React from "react"
import {hydrate} from "react-dom"
import {Provider as ReduxProvider} from "react-redux"
import {BrowserRouter} from "react-router-dom"
import {HelmetProvider} from "react-helmet-async"

import {Application} from "@internal/ui"
import environment from "@internal/environment"
import {rematch} from "@internal/store"
import {cacheDatabase} from "@internal/store"
import {localDatabase} from "@internal/store"
import {remoteDatabase} from "@internal/store"

const personalRemoteDatabase = remoteDatabase("test")
const personalLocalDatabase = localDatabase("test")

personalLocalDatabase.replicate.from(personalRemoteDatabase, {live: true})
cacheDatabase.replicate.from(personalLocalDatabase, {live: true})

window.env = environment(Array.from(document.querySelectorAll("meta[class='environment']")))

hydrate(
  <HelmetProvider>
    <ReduxProvider store={rematch}>
      <BrowserRouter>
        <Application />
      </BrowserRouter>
    </ReduxProvider>
  </HelmetProvider>,
  document.getElementById("application")
)
