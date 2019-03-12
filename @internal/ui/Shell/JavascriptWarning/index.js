import React from "react"


export default function JavascriptWarning () {
  return <noscript>
    <h1>Hello!</h1>

    <p>
      You&apos;re visiting a application that works almost entirely via Javascript,
      but you don&apos;t have Javascript enabled. I get why you might do that,
      considering the nature of the modern web, but I like writing javascript
      and it makes designing UI a much more enjoyable experience.
    </p>

    <p>
      I would love to spend time making the application work without
      Javascript, but I just don&apos;t have the time or energy to do this! While
      server-side rendering is very common and approachable the technology I
      decided to work with is experimental and currently doesn&apos;t have any
      integration with server-side rendering.
    </p>

    <p>
      I&apos;m a big fan of the open web and accessability and I try very hard to
      make Lacqueristas a home for <strong>anyone</strong> interested in
      nail polish. You are not invisible to this team.
      <a href="mailto:team@lacqueristas.club" title="Let me know you want a non-javascript version of lacqueristas">
        I would love to hear from you on this issue and our email is open to
        anyone wanting to talk about it.
      </a>
    </p>

    <p>
      Until then both Lita & the Lacqueristas Club hope you&apos;ll find a way
      to join us.
    </p>
  </noscript>
}
