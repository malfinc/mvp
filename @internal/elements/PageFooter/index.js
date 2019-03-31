import React from "react";
import {ThemeConsumer} from "evergreen-ui";
import {Pane} from "evergreen-ui";
import {Heading} from "evergreen-ui";
import {Strong} from "evergreen-ui";
import {Paragraph} from "evergreen-ui";
import {UnorderedList} from "evergreen-ui";
import {ListItem} from "evergreen-ui";

import {Link} from "@internal/elements";

export default function PageFooter () {
  return <ThemeConsumer>
    {
      (theme) => <Pane is="footer" minHeight={400} padding={25} background={theme.colors.background.yellowTint} display="flex" flexDirection="row" justifyContent="space-evenly">
        <Heading size={800} width={300}>
          Poutineer
        </Heading>
        <Pane display="flex" alignItems="stretch" flexGrow="1" justifyContent="space-evenly">
          <Pane>
            <Heading size={500}>
              Navigation
            </Heading>
            <UnorderedList>
              <ListItem>
                <Link href="/this-is-us">This Is Us</Link>
              </ListItem>
              <ListItem>
                <Link href="/code-of-conduct">Code of Conduct</Link>
              </ListItem>
              <ListItem>
                <Link href="/data-policy">Data Policy</Link>
              </ListItem>
              <ListItem>
                <Link href="/our-technology">Our Technology</Link>
              </ListItem>
              <ListItem>
                <Link href="/privacy-policy">Privacy Policy</Link>
              </ListItem>
              <ListItem>
                <Link href="/terms-of-service">Terms Of Service</Link>
              </ListItem>
            </UnorderedList>
          </Pane>

          <Pane>
            <Heading size={500}>
              Find Us
            </Heading>
            <UnorderedList>
              <ListItem>
                <Link href="https://github.com/lacqueristas"><i className="fab fa-github" /></Link>
              </ListItem>
              <ListItem>
                <Link href="https://twitter.com/lacqueristas"><i className="fab fa-twitter" /></Link>
              </ListItem>
            </UnorderedList>
          </Pane>

          <Pane>
            <Heading size={500}>
              Legal
            </Heading>
            <Paragraph>
              <Strong>Poutineer</Strong> is owned by <Link href="https://kurits.rainbolt-greene.online">Kurtis Rainbolt-Greene</Link>.<br />
              The source code is licensed <Link href="http://opensource.org/licenses/isc-license.php">ISC</Link>.<br />
              The website content is licensed <Link href="http://creativecommons.org/licenses/by-nc-sa/4.0/">CC ANS 4.0</Link>.
            </Paragraph>
          </Pane>
        </Pane>
      </Pane>
    }
  </ThemeConsumer>;
}
