import React from "react"
import {defaultProps} from "recompose"
import {withRouter} from "react-router"
import get from "@unction/get"
import mergeDeepRight from "@unction/mergedeepright"

import view from "@internal/view"
import {PageHeader} from "@internal/elements"
import {PageFooter} from "@internal/elements"

export default view([
  function Page (props) {
    const {children} = props
    const {hasHeader} = props
    const {hasFooter} = props
    const {header: HeaderComponent} = props
    const {footer: FooterComponent} = props
    const dataComponent = get("data-component")(props)
    const {match: {isExact, path, url}} = props

    return <main data-component={dataComponent} data-match-exact={isExact} data-match-path={path} data-match-url={url}>
      {hasHeader && <HeaderComponent />}
      {children}
      {hasFooter && <FooterComponent />}
    </main>
  },
  defaultProps({
    hasHeader: true,
    hasFooter: true,
    header: PageHeader,
    footer: PageFooter,
  }),
  withRouter,
])
