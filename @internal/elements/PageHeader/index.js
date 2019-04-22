import React from "react";
import {defaultProps} from "recompose";
import {Heading} from "evergreen-ui";
import {Paragraph} from "evergreen-ui";

import view from "@internal/view";

export default view([
  defaultProps({
    subtitle: null,
  }),
  function PageHeader (props) {
    const {children} = props;
    const {subtitle} = props;

    return <header>
      <Heading size={900}>
        {children}
      </Heading>
      {subtitle && <Paragraph size={300}>{subtitle}</Paragraph>}
    </header>;
  },
]);
