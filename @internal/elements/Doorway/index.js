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

    return <Pane data-element="Doorway" display="flex" flexDirection="row" minHeight={400} alignItems="stretch" {...remainingProps}>
      <Pane data-element="Doorway Left" display="flex" flexGrow={1} alignItems="center" justifyContent="center">
        {left}
      </Pane>

      <Pane data-element="Doorway Right" display="flex" flexGrow={1} alignItems="center" justifyContent="center">
        {right}
      </Pane>
    </Pane>;
  },
  defaultProps({}),
]);
