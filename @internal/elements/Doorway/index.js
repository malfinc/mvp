import React from "react";
import {defaultProps} from "recompose";
import {Pane} from "evergreen-ui";
import {omit} from "ramda";

import view from "@internal/view";

const REMAINING_PROP_NAMES = [
  "children",
];

export default view([
  function Doorway (props) {
    const {children} = props;
    const remainingProps = omit(REMAINING_PROP_NAMES)(props);

    const [left, right] = children();

    return <Pane display="flex" flexDirection="row" flexGrow={1} alignItems="stretch" {...remainingProps}>
      <Pane display="flex" flexGrow={1} alignItems="center" justifyContent="center">
        {left}
      </Pane>

      <Pane display="flex" flexGrow={1} alignItems="center" justifyContent="center">
        {right}
      </Pane>
    </Pane>;
  },
  defaultProps({}),
]);
