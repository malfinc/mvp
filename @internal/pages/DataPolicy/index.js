import React from "react"

import {Page} from "@internal/ui"
import {SectionHeader} from "@internal/elements"

export default function DataPolicy () {
  return <Page subtitle="Data Policy" kind="article" data-component="DataPolicy">
    <SectionHeader>
      What we collect
    </SectionHeader>
    <section>
      <p>
        Every web application or program collects some amount of data. Ranging from user input to advanced mouse movement tracking. We largely track as much as we can think of and we want you to know exactly what that means.
      </p>

      <aside>
        This section will be updated as frequently as we change our tracking. We might not actually track something described in this currently, but we will.
      </aside>

      <p>
        We track...
      </p>

      <ul>
        <li>Page request</li>

        <li>Page load</li>

        <li>Browser provided IP address</li>

        <li>Browser provided user agent</li>

        <li>Browser scroll events</li>

        <li>Browser click events</li>

        <li>Browser select events</li>

        <li>Browser keypresses (exception: secure inputs, i.e. credit card forms)</li>
      </ul>
    </section>

    <SectionHeader>
      Where we send data
    </SectionHeader>
    <section>

      <p>
        We store this information in various places and usually duplicated to various services. For example, we store page requests in: Google Analytics, Mixpanel, and our own activity tracker. Unilaterally we store this information in our personal warehouses like AWS RDS, AWS S3, or AWS Redshift. The data will pass through services like AWS Kinesis.
      </p>
    </section>

    <SectionHeader>
      How we store information
    </SectionHeader>
    <section>
      <p>
        The way we store information is varried based on the information we&apos;re storing. We usually have a continual stream of the data that is indexed by the performer. Anytime we give data to an external service like Google Analytics or Mixpanel they get access to a distinct identifier that we use to map to you, the user. They never and will never get access to this mapping.
      </p>

      <p>
        Externally owned services like Google Analytics or Mixpanel will never get personally identifying information. If they have a breach we don&apos;t want you to be harmed. Information like name, address, or phone numbers might transmit over the wire through things like AWS Kinesis, but rests soley in our internal datastores.
      </p>

      <p>
        Information that could have personal importance like comments, messages, or profile data are ecrypted in our datastores. We use SCrypt for encrypting passwords.
      </p>

    </section>

    <SectionHeader>
      What a breach looks like
    </SectionHeader>
    <section>
      <p>
        Obviously we don&apos;t know what attackers will do and how they&apos;ll do it, but we can do our very best to ensure you know what has happened and how it happened. We will use our social media accounts to notify you, our user, and additionally send an email to the address we know.
      </p>

      <p>
        If an attacker were to breach...
      </p>

      <ul>
        <li>
          <strong>Google Analytics, Mixpanel, or external services:</strong> The data is rather meaningless. They would know a lot about our users as a collective, but not individual people.
        </li>

        <li>
          <strong>AWS S3:</strong> They&apos;d have access to images or assets you uploaded and more stream of activity type information as above.
        </li>

        <li>
          <strong>AWS RDS:</strong> They&apos;d have access to all the information you stored, but not access to your personal information, password(s), comments, or identifying data. They could theoretically spend a &ldquo;long time&rdquo; on identifing a single user, but it would essentially be at random who they targeted.
        </li>

        <li>
          <strong>Stripe:</strong> They would have access to our purchase and payout information, but not really anything beyond that. Stripe doesn&apos;t know who you are and the attacker wouldn&apos;t either.
        </li>

        <li>
          <strong>Github:</strong> Were they to access our code...which is weird since it&apos;s free and open source... they would know only how our system works and see my crappy notes.
        </li>
      </ul>
    </section>
  </Page>
}
