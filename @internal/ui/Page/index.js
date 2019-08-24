import React from "react";
import {defaultProps} from "recompose";
import {withRouter} from "react-router";
import {get} from "@unction/complete";

import view from "@internal/view";

export default view([
  defaultProps({}),
  withRouter,
  function Page (properties) {
    const {children} = properties;
    const dataComponent = get("data-component")(properties);
    const {match: {isExact, path, url}} = properties;

    return <main data-component={dataComponent} data-match-exact={isExact} data-match-path={path} data-match-url={url}>
      {children}
    </main>;
  },
]);
