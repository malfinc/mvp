import React from "react"
import {configure, addDecorator} from "@storybook/react"
import {withKnobs} from "@storybook/addon-knobs"
import {checkA11y} from "@storybook/addon-a11y"
import {withTests} from "@storybook/addon-jest"
import "@storybook/addon-console"
import results from "./jest-test-results.json"
import {Provider} from "react-redux"
import {rematch} from "@internal/store"

const requireStorybooks = require.context("../", true, /storybook\.js$/)

addDecorator(withTests({results}))
addDecorator(withKnobs)
addDecorator(checkA11y)
addDecorator((story) => {
  return <Provider store={rematch}>
    {story()}
  </Provider>
})

configure(() => requireStorybooks.keys().forEach(requireStorybooks), module)
