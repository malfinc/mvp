import React from "react";

import {Page} from "@internal/elements";
import {Link} from "@internal/elements";

const layoutStyle = {
  gridTemplateAreas: `
    "showcase showcase showcase"
    "brand brand authentication"
    "review review review"
    "feed feed feed"
  `,
  gridGap: "5px",
};

export default function LandingPage () {
  return <Page layoutStyle={layoutStyle} subtitle="Welcome!">
    <section css={{gridArea: "showcase"}}>
      showcase
    </section>

    <header css={{gridArea: "brand"}}>
      <h1>Poutineer</h1>
    </header>

    <section css={{gridArea: "authentication"}}>
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

    <section css={{gridArea: "review"}}>
      review
    </section>

    <section css={{gridArea: "feed"}}>
      feed
    </section>
  </Page>;
}
