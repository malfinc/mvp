import React from "react"

import {Page} from "@internal/ui"
import {PageHeader} from "@internal/elements"
import {Anchor} from "@internal/elements"

export default function LandingPage () {
  return <Page subtitle="Welcome!" data-component="LandingPage" hasHeader={false}>
    <PageHeader>
      Blank Browser React <i className="fas fa-lock"></i>
    </PageHeader>

    <Anchor kind="primary" href="/sign-up">
      Join us
    </Anchor>

    <Anchor kind="secondary" href="/sign-in">
      Login
    </Anchor>
  </Page>
}
