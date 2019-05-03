import {reduceValues} from "@unction/complete";

export default reduceValues(
  (previous) => (element) => {
    return {
      ...previous,
      [element.getAttribute("name")]: element.getAttribute("content"),
    };
  }
)(
  {}
);
