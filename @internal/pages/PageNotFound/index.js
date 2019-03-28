import React from "react";
import {Paragraph} from "evergreen-ui";

import {Page} from "@internal/ui";

export default function PageNotFound () {
  return <Page subtitle="We couldn't find the page you wanted" kind="article">
    <Paragraph>
      I&apos;m sorry, but we couldn&apos;t find that page.
    </Paragraph>
  </Page>;
}
