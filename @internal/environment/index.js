import reduceValues from "@unction/reducevalues"

export default reduceValues(
  (previous) => (element) => {
    return {
      ...previous,
      [element.getAttribute("name")]: element.getAttribute("content"),
    }
  }
)(
  {}
)
