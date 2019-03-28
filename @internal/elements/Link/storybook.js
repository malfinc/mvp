import React from "react";
import {storiesOf} from "@storybook/react";
import {BrowserRouter} from "react-router-dom";
import Link from "./";
import {text} from "@storybook/addon-knobs";
import {select} from "@storybook/addon-knobs";

storiesOf("Link", module)
  .add("with relative href", () => <BrowserRouter>
    <Link href={text("href", "/help")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>)
  .add("with absolute href", () => <BrowserRouter>
    <Link href={text("href", "https://www.example.com")}>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>)
  .add("with no href", () => <BrowserRouter>
    <Link>{text("content", "A Simple Life")}</Link>
  </BrowserRouter>);
