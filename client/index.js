import React from "react";
import {render} from "react-dom";
import {BrowserRouter} from "react-router-dom";
import {HelmetProvider} from "react-helmet-async";
import {Provider as ReduxProvider} from "react-redux";

import {Application} from "@internal/elements";
import store from "@internal/store";

store.dispatch.database.initialize()
  .then(
    () => render(
      <BrowserRouter>
        <HelmetProvider>
          <ReduxProvider store={store}>
            <Application />
          </ReduxProvider>
        </HelmetProvider>
      </BrowserRouter>,
      document.querySelector("#application")
    )
  )
  .catch(console.error);
