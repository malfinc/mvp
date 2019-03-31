import React from "react";

import {Pane} from "evergreen-ui";
import {Heading} from "evergreen-ui";

import {Page} from "@internal/ui";
import {Link} from "@internal/elements";

export default function LandingPage () {
  return <Page subtitle="Welcome!" hasHeader={false}>
    <Heading size={900} padding={25}>
      Poutineer
    </Heading>

    <Pane flexGrow={1} minHeight={400} display="flex" alignItems="stretch">
      <Pane flexGrow={1} display="flex" alignItems="center" justifyContent="center">
        <Link kind="primary" href="/sign-up">
          Join us
        </Link>
      </Pane>

      <Pane flexGrow={1} display="flex" alignItems="center" justifyContent="center">
        <Link kind="secondary" href="/sign-in">
          Login
        </Link>
      </Pane>
    </Pane>
  </Page>;
}
