import React from "react"
import {defaultProps} from "recompose"
import mergeDeepRight from "@unction/mergedeepright"
import get from "@unction/get"
import {Heading} from "evergreen-ui"
import {Paragraph} from "evergreen-ui"

import view from "@internal/view"

export default view([
  function PageHeader (props) {
    const {children} = props
    const {subtitle} = props

    return <header data-component="PageHeader">
      <Heading size={900}>
        {children}
      </Heading>
      {subtitle && <Paragraph size={300}>{subtitle}</Paragraph>}
    </header>
  },
  defaultProps({
    subtitle: null,
  }),
])
