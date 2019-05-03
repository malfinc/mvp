import React from "react";
import {lifecycle} from "recompose";
import {Paragraph} from "evergreen-ui";

import view from "@internal/view";

export default view([
  lifecycle({
    componentDidCatch (exception, info) {
      this.setState(() => ({exploded: true, exception, info}));
    },
  }),
  function ErrorBoundary ({exploded, children}) {
    if (exploded) {
      return <Paragraph>
        Something has gone wrong.
      </Paragraph>;
    }

    return children;
  },
]);
