import React from "react";
import {Paragraph} from "evergreen-ui";
import {Heading} from "evergreen-ui";
import {Pane} from "evergreen-ui";

import {Page} from "@internal/ui";

export default function ThisIsUs () {
  return <Page subtitle="This Is Us" kind="article">
    <Pane>
      <Heading>
        Empty
      </Heading>

      <Paragraph>
        To be filled
      </Paragraph>
    </Pane>
  </Page>;
}
