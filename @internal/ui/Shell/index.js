import React from "react"

import GoogleTagManagerNoScript from "./GoogleTagManagerNoScript"
import GoogleTagManagerScript from "./GoogleTagManagerScript"
import JavascriptWarning from "./JavascriptWarning"

export default function Shell (props) {
  const {helmet} = props
  const {extractedStyles} = props
  const {manifest} = props
  const {children} = props
  const {css} = extractedStyles
  const {hydrationScript} = extractedStyles
  const {runtime: {js: runtimeFilename}} = manifest
  const {vendor: {js: vendorFilename}} = manifest
  const {internal: {js: internalFilename}} = manifest
  const {main: {js: mainFilename}} = manifest

  return <html lang="en" data-component="Shell" {...helmet.htmlAttributes.toComponent()}>
    <head>
      <meta charSet="utf-8" />
      {helmet.title.toComponent()}
      <meta httpEquiv="x-ua-compatible" content="ie=edge" />
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
      <meta name="robots" content="index,follow" />
      {process.env.ORIGIN_LOCATION && <meta className="environment" name="ORIGIN_LOCATION" content={process.env.ORIGIN_LOCATION} />}
      {process.env.WWW_LOCATION && <meta className="environment" name="WWW_LOCATION" content={process.env.WWW_LOCATION} />}
      {process.env.LUMIN_LOCATION && <meta className="environment" name="LUMIN_LOCATION" content={process.env.LUMIN_LOCATION} />}
      {helmet.meta.toComponent()}

      {helmet.base.toComponent()}

      <GoogleTagManagerScript />

      {helmet.link.toComponent()}
      <link rel="author" href="/assets/humans.txt" />
      <link rel="manifest" href="/assets/manifest.json" />
      <link rel="copyright" href="/assets/copyright.txt" />
      <link rel="apple-touch-icon" sizes="57x57" href="/assets/apple-icon-57x57.png" />
      <link rel="apple-touch-icon" sizes="60x60" href="/assets/apple-icon-60x60.png" />
      <link rel="apple-touch-icon" sizes="72x72" href="/assets/apple-icon-72x72.png" />
      <link rel="apple-touch-icon" sizes="76x76" href="/assets/apple-icon-76x76.png" />
      <link rel="apple-touch-icon" sizes="114x114" href="/assets/apple-icon-114x114.png" />
      <link rel="apple-touch-icon" sizes="120x120" href="/assets/apple-icon-120x120.png" />
      <link rel="apple-touch-icon" sizes="144x144" href="/assets/apple-icon-144x144.png" />
      <link rel="apple-touch-icon" sizes="152x152" href="/assets/apple-icon-152x152.png" />
      <link rel="apple-touch-icon" sizes="180x180" href="/assets/apple-icon-180x180.png" />
      <link rel="apple-touch-icon-precomposed" href="/assets/apple-icon-precomposed.png" />
      <link rel="icon" sizes="192x192" href="/assets/android-icon-192x192.png" />
      <link rel="icon" sizes="32x32" href="/assets/favicon-32x32.png" />
      <link rel="icon" sizes="96x96" href="/assets/favicon-96x96.png" />
      <link rel="icon" sizes="16x16" href="/assets/favicon-16x16.png" />
      <link rel="icon" href="/assets/favicon.ico" />
      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Handlee%7COpen+Sans" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.0/normalize.min.css" integrity="sha256-oSrCnRYXvHG31SBifqP2PM1uje7SJUyX0nTwO2RJV54=" crossOrigin="anonymous" />

      {helmet.style.toComponent()}
      <style id="server-side-rendered-css" dangerouslySetInnerHTML={{ __html: css }} />

      {helmet.noscript.toComponent()}

      {helmet.script.toComponent()}
    </head>

    <body id="application" {...helmet.bodyAttributes.toComponent()}>
      <GoogleTagManagerNoScript />

      {children}

      <JavascriptWarning />

      <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/solid.js" integrity="sha384-6FXzJ8R8IC4v/SKPI8oOcRrUkJU8uvFK6YJ4eDY11bJQz4lRw5/wGthflEOX8hjL" crossorigin="anonymous"></script>
      <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/brands.js" integrity="sha384-zJ8/qgGmKwL+kr/xmGA6s1oXK63ah5/1rHuILmZ44sO2Bbq1V3p3eRTkuGcivyhD" crossorigin="anonymous"></script>
      <script defer src="https://use.fontawesome.com/releases/v5.7.2/js/fontawesome.js" integrity="sha384-xl26xwG2NVtJDw2/96Lmg09++ZjrXPc89j0j7JHjLOdSwHDHPHiucUjfllW0Ywrq" crossorigin="anonymous"></script>
      <script src="/assets/babel-helpers.js"></script>
      <script src={`/assets/${runtimeFilename}`}></script>
      <script src={`/assets/${vendorFilename}`}></script>
      <script src={`/assets/${internalFilename}`}></script>
      <script src={`/assets/${mainFilename}`}></script>
    </body>
  </html>
}
