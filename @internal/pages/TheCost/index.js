import React from "react"

import {Page} from "@internal/ui"
import {SectionHeader} from "@internal/elements"


export default function TheCost () {
  return <Page subtitle="The Cost" kind="article" data-component="TheCost">
    <section>
      <SectionHeader>
        Origin Production Server
      </SectionHeader>

      <p>
        This is where the primary resource API is hosted.
      </p>

      <ul>
        <li><strong>Company</strong>: Heroku</li>
        <li><strong>Cost</strong>: $75/mth</li>
      </ul>

      <SectionHeader>
        Origin Staging Server
      </SectionHeader>

      <p>
        This is where we experiment with new origin server changes.
      </p>

      <ul>
        <li><strong>Company</strong>: Heroku</li>
        <li><strong>Cost</strong>: $57/mth</li>
      </ul>

      <SectionHeader>
        WWW Production Server
      </SectionHeader>

      <p>
        This is the server that serves our frontend browser client.
      </p>

      <ul>
        <li><strong>Company</strong>: Heroku</li>
        <li><strong>Cost</strong>: $25/mth</li>
      </ul>

      <SectionHeader>
        WWW Staging Server
      </SectionHeader>

      <p>
        The experimental server for our frontend browser client.
      </p>

      <ul>
        <li><strong>Company</strong>: Heroku</li>
        <li><strong>Cost</strong>: $7/mth</li>
      </ul>
    </section>
  </Page>
}
