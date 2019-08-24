import React from "react";
import {lifecycle} from "recompose";

import view from "@internal/view";

export default view([
  lifecycle({
    componentDidCatch (exception, info) {
      this.setState(() => ({exploded: true, exception, info}));
    },
  }),
  function ErrorBoundary ({exploded, children}) {
    if (exploded) {
      return <p>
        Something has gone wrong.
      </p>;
    }

    return children;
  },
]);
