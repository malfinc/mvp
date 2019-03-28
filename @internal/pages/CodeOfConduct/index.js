import React from "react";
import {Pane} from "evergreen-ui";
import {Paragraph} from "evergreen-ui";
import {Heading} from "evergreen-ui";
import {UnorderedList} from "evergreen-ui";
import {ListItem} from "evergreen-ui";

import {Page} from "@internal/ui";

export default function CodeOfConduct () {
  return <Page subtitle="Code Of Conduct" kind="article">
    <Pane>
      <Heading>
        Our Pledge
      </Heading>
      <Paragraph>
        In the interest of fostering an open and welcoming environment, we as Lacqueristas pledge to making participation in our community a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation. Our goal is to make nail polish open to everyone. These guidelines allow us to ensure that all nail polish enthusiasts feel safe and welcome to share their art and express themselves without fear.
      </Paragraph>

      <Paragraph>
        In the interest of fostering an open and welcoming environment, we as Lacqueristas pledge to making participation in our community a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation. Our goal is to make nail polish open to everyone. These guidelines allow us to ensure that all nail polish enthusiasts feel safe and welcome to share their art and express themselves without fear.
      </Paragraph>
    </Pane>

    <Pane>
      <Heading>
        Our Standards
      </Heading>
      <Paragraph>
        Examples of behavior that contributes to creating a positive environment
        include:
      </Paragraph>

      <UnorderedList>
        <ListItem>Using welcoming and inclusive language</ListItem>
        <ListItem>Being respectful of differing viewpoints and experiences</ListItem>
        <ListItem>Gracefully accepting constructive criticism</ListItem>
        <ListItem>Focusing on what is best for the community</ListItem>
        <ListItem>Showing empathy towards other community members</ListItem>
        <ListItem>Don’t be a harsh judge</ListItem>
        <ListItem>Credit others for their work</ListItem>
      </UnorderedList>

      <Paragraph>
        Examples of unacceptable behavior by participants include:
      </Paragraph>

      <UnorderedList>
        <ListItem>
          The use of sexualized language or imagery and unwelcome sexual attention or advances
        </ListItem>

        <ListItem>
          Trolling, insulting/derogatory comments, and personal or political attacks
        </ListItem>

        <ListItem>
          Public or private harassment
        </ListItem>

        <ListItem>
          Publishing others’ private information, such as a physical or electronic address, without explicit permission
        </ListItem>

        <ListItem>
          Harshly criticizing the work of newer Lacqueristas
        </ListItem>

        <ListItem>
          Asking people to clean-up before posing their polishes – it is 100% okay to post nail art in its pre-cleanup state
        </ListItem>

        <ListItem>
          Other conduct which could reasonably be considered inappropriate in a professional setting
        </ListItem>
      </UnorderedList>
    </Pane>

    <Heading>
      Our Responsibilities
    </Heading>
    <Pane>
      <Paragraph>
        We are responsible for clarifying the standards of acceptable behavior and are expected to take appropriate and fair corrective action in response to any instances of unacceptable behavior.
      </Paragraph>

      <Paragraph>
        We have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct, or to ban temporarily or permanently any Lacquerista for other behaviors that they deem inappropriate, threatening, offensive, or harmful.
      </Paragraph>

      <Paragraph>
        As community members, you have the ability to hold us accountable to these responsibilities. We will be available for contact at any given time and hold ourselves responsible to responding to the use of our reporting tools in a timely and respectful manner.
      </Paragraph>
    </Pane>

    <Heading>
      Scope
    </Heading>
    <Pane>
      <Paragraph>
        This Code of Conduct applies both within the community and in public spaces when an individual is representing Lacqueristas or its community. Examples of representing a project or community include using an official e-mail address, posting via an official social media account, or acting as an appointed representative at an online or offline event. We reserve the right to redefine and clarify what representation means for Lacqueristas in the future.
      </Paragraph>
    </Pane>

    <Heading>
      Enforcement
    </Heading>
    <Pane>
      <Paragraph>
        Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by contacting the Lacqueristas admin team at <a href="mailto:support@lacqueristas.club">support@lacqueristas.club</a>. All complaints will be reviewed and investigated and will result in a response that is deemed necessary and appropriate to the circumstances. The project team is obligated to maintain confidentiality with regard to the reporter of an incident. Further details of specific enforcement policies may be posted separately.
      </Paragraph>

      <Paragraph>
        Administrators who do not follow or enforce the Code of Conduct in good faith may face temporary or permanent repercussions as determined by other admins or community members. Attribution
      </Paragraph>

      <Paragraph>
        This is version 1.0 of the <a href="https://www.lacqueristas.club">Lacqueristas</a> Code of Conduct. It was prepared by Ellen McGrody for modification and maintenance by the Lacqueristas administration team.
      </Paragraph>

      <Paragraph>
        This Code of Conduct is adapted from the Contributor Covenant, version 1.4, available at <a href="http://contributor-covenant.org/version/1/4">http://contributor-covenant.org/version/1/4</a>.
      </Paragraph>
    </Pane>
  </Page>;
}
