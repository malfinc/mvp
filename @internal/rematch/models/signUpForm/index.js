import {mergeDeepRight} from "@unction/complete";
import axios from "axios";

export default {
  state: {},
  reducers: {
    mergeAttributes: (state, value) => mergeDeepRight(state)({attributes: value}),
  },
  effects: (dispatch) => ({
    async submitForm (payload, state) {
      await console.log({payload, state});
      // await axios.post("http://localhost:3001/v1/accounts",);
    },
  }),
};
