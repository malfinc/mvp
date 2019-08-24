import React from "react"
import {configure, addDecorator} from "@storybook/react"
import {withKnobs} from "@storybook/addon-knobs"
import {checkA11y} from "@storybook/addon-a11y"
import {withTests} from "@storybook/addon-jest"
import results from "./jest-test-results.json"
import {Provider} from "react-redux"
import rematch from "@internal/rematch"
import {configure} from '@storybook/react';

// automatically import all files ending in *.stories.js
const requireWithContext = require.context('../@internal', true, /story\.js$/);

addDecorator(withTests({results}))
addDecorator(withKnobs)
addDecorator(checkA11y)
addDecorator((story) => {
  return <Provider store={rematch}>
    {story()}
  </Provider>
})

configure(() => requireWithContext.keys().forEach((filename) => requireWithContext(filename)), module);
