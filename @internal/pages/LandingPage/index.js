import React from "react";

import {Pane} from "evergreen-ui";

import {Page} from "@internal/ui";
import {PageHeader} from "@internal/elements";
import {Link} from "@internal/elements";

export default function LandingPage () {
  return <Page subtitle="Welcome!" hasHeader={false}>
    <PageHeader>
      Poutineer
    </PageHeader>

    <Pane>
      <Link kind="primary" href="/sign-up">
        Join us
      </Link>
    </Pane>

    <Pane>
      <Link kind="secondary" href="/sign-in">
        Login
      </Link>
    </Pane>
  </Page>;
}
