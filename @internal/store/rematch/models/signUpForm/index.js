export default {
  state: {},
  reducers: {
    updateEmail (state, email) {
      return {
        email,
        ...state,
      };
    },
  },
};
