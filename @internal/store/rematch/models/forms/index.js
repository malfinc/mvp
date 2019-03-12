import mergeDeepRight from "@unction/mergedeepright"
import objectFrom from "@unction/objectfrom"

export default {
  state: {},
  reducers: {
    updateFormInputValue (state, payload) {
      const {formSlug} = payload
      const {fieldSlug} = payload
      const {value} = payload

      return mergeDeepRight(
        state
      )(
        objectFrom(
          [formSlug, fieldSlug]
        )(
          {writtenAt: new Date(), value}
        )
      )
    },
  },
  effects (dispatch) {
    return {
      submitRegistration (payload, root) {
        return false
      },
    }
  },
}
