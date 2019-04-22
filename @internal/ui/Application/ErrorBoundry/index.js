import React from "react";
import {withState} from "recompose";
import {lifecycle} from "recompose";
import {Paragraph} from "evergreen-ui";

import view from "@internal/view";

export default view([
  withState("exploded", "explode", false),
  lifecycle({
    componentDidCatch (exception, info) {
      this.setState({exploded: true});

      console.error({exception, info}); // eslint-disable-line no-console
    },
  }),
  function ErrorBoundary (props) {
    const {exploded} = props;
    const {children} = props;

    if (exploded) {
      return <Paragraph>
        Something has gone wrong.
      </Paragraph>;
    }

    return children;
  },
]);
