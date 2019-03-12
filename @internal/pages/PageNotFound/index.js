import React from "react"

import {Page} from "@internal/ui"


export default function PageNotFound () {
  return <Page subtitle="We couldn't find the page you wanted" kind="article" data-component="PageNotFound">
    <p>
      I&apos;m sorry, but we couldn&apos;t find that page.
    </p>
  </Page>
}
