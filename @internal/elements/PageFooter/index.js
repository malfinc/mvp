import React from "react"
import {Heading} from "evergreen-ui"

import {Anchor} from "@internal/elements"

export default function PageFooter () {
  return <footer data-component="Footer">
    <Heading>
      <img src="/assets/small-keyhole-llama.png" alt="the llama logo" />
      Lacqueristas
    </Heading>
    <section data-intent="links">
      <section data-intent="documentation links">
        <Heading>
          Documentation
        </Heading>
        <Anchor href="/this-is-us">This Is Us</Anchor>
        <Anchor href="/code-of-conduct">Code of Conduct</Anchor>
        <Anchor href="/data-policy">Data Policy</Anchor>
        <Anchor href="/our-technology">Our Technology</Anchor>
        <Anchor href="/privacy-policy">Privacy Policy</Anchor>
        <Anchor href="/terms-of-service">Terms Of Service</Anchor>
      </section>

      <section data-intent="copyright information">
        <Heading>
          Legal
        </Heading>
        <p>
          <strong>Lacqueristas</strong> by <Anchor href="https://kurits.rainbolt-greene.online">Kurtis Rainbolt-Greene</Anchor>.
          The source code is licensed <Anchor href="http://opensource.org/licenses/isc-license.php">ISC</Anchor>.
          The website content is licensed <Anchor href="http://creativecommons.org/licenses/by-nc-sa/4.0/">CC ANS 4.0</Anchor>.
        </p>
      </section>

      <section data-intent="social profiles">
        <Heading>
          Find us
        </Heading>
        <p>
          <Anchor href="https://github.com/lacqueristas"><span className="fab fa-github" /></Anchor>
          <Anchor href="https://twitter.com/lacqueristas"><span className="fab fa-twitter" /></Anchor>
        </p>
      </section>
    </section>
  </footer>
}
