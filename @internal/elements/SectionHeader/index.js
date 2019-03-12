import React from "react"
import {defaultProps} from "recompose"
import mergeDeepRight from "@unction/mergedeepright"
import get from "@unction/get"
import {Heading} from "evergreen-ui"
import {Paragraph} from "evergreen-ui"

import view from "@internal/view"

export default view([
  function SectionHeader (props) {
    const {children} = props
    const {subtitle} = props

    return <header data-component="SectionHeader">
      <Heading size={500}>
        {children}
      </Heading>
      {subtitle && <Paragraph size={400}>{subtitle}</Paragraph>}
    </header>
  },
  defaultProps({
    subtitle: null,
  }),
])
