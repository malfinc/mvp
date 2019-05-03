import React from "react";
import {Link as EvergreenLink} from "evergreen-ui";
import ComponentLink from "react-router-component-link";
import {defaultProps} from "recompose";
import {startsWith} from "@unction/complete";
import {isNil} from "@unction/complete";
import {get} from "@unction/complete";
import {omit} from "ramda";

import view from "@internal/view";

const REMAINING_PROP_NAMES = [
  "kind",
  "href",
  "children",
];

const kinds = {
  primary: "green",
  normal: "blue",
  hidden: "neutral",
};

export default view([
  defaultProps({
    kind: "normal",
  }),
  function Link (props) {
    const {children} = props;
    const {href} = props;
    const {kind} = props;
    const color = get(kind)(kinds);
    const remainingProps = omit(REMAINING_PROP_NAMES)(props);

    if (isNil(href)) {
      return <EvergreenLink data-element="Link" color={color} {...remainingProps}>
        {children}
      </EvergreenLink>;
    }

    if (startsWith("https")(href) || startsWith("http")(href)) {
      return <EvergreenLink data-element="Link" color={color} href={href} {...remainingProps}>
        {children}
      </EvergreenLink>;
    }

    return <ComponentLink data-element="Link" color={color} to={href} component={EvergreenLink} {...remainingProps}>{children}</ComponentLink>;
  },
]);
