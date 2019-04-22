import mergeRight from "@unction/mergeRight";

export default {
  state: {},
  reducers: {
    updateState: (state, value) => mergeRight(state)(value),
  },
};
