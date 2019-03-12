import React from "react"
import {Link} from "evergreen-ui"
import ComponentLink from "react-router-component-link"
import {defaultProps} from "recompose"
import startsWith from "@unction/startswith"
import isNil from "@unction/isnil"
import get from "@unction/get"
import {omit} from "ramda"

import view from "@internal/view"

const REMAINING_PROP_NAMES = [
  "kind",
  "href",
  "children",
]

const kinds = {
  primary: "green",
  normal: "blue",
  hidden: "neutral",
}

export default view([
  function Anchor (props) {
    const {children} = props
    const {href} = props
    const {kind} = props
    const color = get(kind)(kinds)
    const remainingProps = omit(REMAINING_PROP_NAMES)(props)

    if (isNil(href)) {
      return <Link color={color} {...remainingProps}>
        {children}
      </Link>
    }

    if (startsWith("https")(href) || startsWith("http")(href)) {
      return <Link color={color} href={href} {...remainingProps}>
        {children}
      </Link>
    }

    return <ComponentLink to={href} color={color} component={Link} {...remainingProps}>{children}</ComponentLink>
  },
  defaultProps({
    kind: "normal",
  }),
])
