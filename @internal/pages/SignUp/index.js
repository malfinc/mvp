import React from "react";
import {Paragraph} from "evergreen-ui";
import {Heading} from "evergreen-ui";
import {Pane} from "evergreen-ui";

import {Page} from "@internal/ui";
import {Doorway} from "@internal/elements";

import SignUpForm from "./SignUpForm";

export default function SignUp () {
  return <Page subtitle="Sign Up" hasHeader={false} hasFooter={false}>
    <Pane marginX={125} marginY={25}>
      <Heading size={700}>
        Sign up for Poutineer
      </Heading>
      <Paragraph>
        A good reason to sign up for Poutineer!
      </Paragraph>
    </Pane>
    <Doorway>
      {() => [
        <Paragraph key="0">Flair</Paragraph>,
        <SignUpForm />,
      ]}
    </Doorway>
  </Page>;
}
