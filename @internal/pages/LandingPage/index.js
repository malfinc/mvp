import React from "react";

import {Page} from "@internal/ui";
import {Link} from "@internal/elements";

export default function LandingPage () {
  return <Page subtitle="Welcome!">
    <h2>
      Poutineer
    </h2>

    <section>
      <section>
        <Link kind="primary" href="/sign-up">
          Join us
        </Link>
      </section>

      <section>
        <Link kind="secondary" href="/sign-in">
          Login
        </Link>
      </section>
    </section>
  </Page>;
}
