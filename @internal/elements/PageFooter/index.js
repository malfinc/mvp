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
      (theme) => <Pane is="footer" background={theme.palette.neutral.base}>
        <Heading size={800} color={theme.palette.neutral.light}>
          Poutineer
        </Heading>
        <Pane display="flex" alignItems="center" justifyContent="space-evenly">
          <Heading size={500} color={theme.palette.neutral.light} marginX={50}>
            Navigation
          </Heading>
          <Heading size={500} color={theme.palette.neutral.light} marginX={50}>
            Legal
          </Heading>
          <Heading size={500} color={theme.palette.neutral.light} marginX={50}>
            Find Us
          </Heading>
        </Pane>
        <Pane display="flex" alignItems="center" justifyContent="space-evenly">
          <Pane marginX={50}>
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

          <Pane marginX={50}>
            <Paragraph color={theme.palette.neutral.light}>
              <Strong color={theme.palette.neutral.light}>Poutineer</Strong> is owned by <Link href="https://kurits.rainbolt-greene.online">Kurtis Rainbolt-Greene</Link>.<br />
              The source code is licensed <Link href="http://opensource.org/licenses/isc-license.php">ISC</Link>.<br />
              The website content is licensed <Link href="http://creativecommons.org/licenses/by-nc-sa/4.0/">CC ANS 4.0</Link>.
            </Paragraph>
          </Pane>

          <Pane>
            <Paragraph color={theme.palette.neutral.light}>
              <UnorderedList>
                <ListItem>
                  <Link href="https://github.com/lacqueristas"><span className="fab fa-github" /></Link>
                </ListItem>
                <ListItem>
                  <Link href="https://twitter.com/lacqueristas"><span className="fab fa-twitter" /></Link>
                </ListItem>
              </UnorderedList>
            </Paragraph>
          </Pane>
        </Pane>
      </Pane>
    }
  </ThemeConsumer>;
}
