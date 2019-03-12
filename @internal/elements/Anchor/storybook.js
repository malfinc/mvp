import React from "react"
import {storiesOf} from "@storybook/react"
import {BrowserRouter} from "react-router-dom"
import Anchor from "./"
import {text} from "@storybook/addon-knobs"
import {select} from "@storybook/addon-knobs"

const kinds = [
  "primary",
  "normal",
  "hidden",
]

storiesOf("Anchor", module)
  .add("with relative href", () => <BrowserRouter>
    <Anchor kind={select("kind", kinds)} href={text("href", "/help")}>{text("content", "A Simple Life")}</Anchor>
  </BrowserRouter>)
  .add("with absolute href", () => <BrowserRouter>
    <Anchor kind={select("kind", kinds)} href={text("href", "https://www.example.com")}>{text("content", "A Simple Life")}</Anchor>
  </BrowserRouter>)
  .add("with no href", () => <BrowserRouter>
    <Anchor kind={select("kind", kinds)}>{text("content", "A Simple Life")}</Anchor>
  </BrowserRouter>)
