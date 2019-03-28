import React from "react";
import {storiesOf} from "@storybook/react";
import {text} from "@storybook/addon-knobs";
import PageHeader from "./";

storiesOf("PageHeader", module)
  .add("with no subtitle", () => <PageHeader subtitle={text("subtitle", null)}>{text("content", "A Simple Life")}</PageHeader>)
  .add("with subtitle", () => <PageHeader subtitle={text("subtitle", "The story of bob")}>{text("content", "A Simple Life")}</PageHeader>);
