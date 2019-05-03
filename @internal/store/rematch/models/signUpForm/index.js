import {mergeDeepRight} from "@unction/complete";

export default {
  state: {},
  reducers: {
    updateState: (state, value) => mergeRight(state)(value),
  },
};
