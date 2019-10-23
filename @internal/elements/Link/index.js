import React from "react";
// import ComponentLink from "react-router-component-link";
import {Link as ReactRouterLink} from "react-router-dom";
import {startsWith} from "@unction/complete";
import {isNil} from "@unction/complete";
import {get} from "@unction/complete";
import {withoutKeys} from "@unction/complete";

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

export default function Link (properties) {
  const {children} = properties;
  const {href} = properties;
  const {kind = "normal"} = properties;
  const color = get(kind)(kinds);
  const remainingProperties = withoutKeys(REMAINING_PROP_NAMES)(properties);

  if (isNil(href)) {
    return <a data-element="Link" color={color} {...remainingProperties}>
      {children}
    </a>;
  }

  if (startsWith("https")(href) || startsWith("http")(href)) {
    return <a data-element="Link" color={color} href={href} {...remainingProperties}>
      {children}
    </a>;
  }

  return <ReactRouterLink to={href} {...remainingProperties}>{children}</ReactRouterLink>;
}
