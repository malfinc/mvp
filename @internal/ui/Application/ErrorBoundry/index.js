import React from "react"
import {withState} from "recompose"
import {lifecycle} from "recompose"

import view from "@internal/view"


export default view([
  function ErrorBoundary (props) {
    const {exploded} = props
    const {children} = props

    if (exploded) {
      return <p>
        Something has gone wrong.
      </p>
    }

    return children
  },
  withState("exploded", "explode", false),
  lifecycle({
    componentDidCatch (exception, info) {
      this.setState({exploded: true})

      console.error({exception, info})
    },
  }),
])
