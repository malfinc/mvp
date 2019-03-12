import {init} from "@rematch/core"
import thunk from "redux-thunk"
import logger from "redux-logger"
import * as models from "./models"

export default init({
  models,
  plugins: [],
  redux: {
    middlewares: global.window ? [thunk, logger] : [],
  },
})
