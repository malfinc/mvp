import React from "react"
import {storiesOf} from "@storybook/react"
import {text} from "@storybook/addon-knobs"
import {select} from "@storybook/addon-knobs"
import SectionHeader from "./"

storiesOf("SectionHeader", module)
  .add("with no subtitle", () => <SectionHeader subtitle={text("subtitle", null)}>{text("content", "A Simple Life")}</SectionHeader>)
  .add("with subtitle", () => <SectionHeader subtitle={text("subtitle", "The story of bob")}>{text("content", "A Simple Life")}</SectionHeader>)
