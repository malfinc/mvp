import {compose} from "recompose"

export default function view (unctions) {
  const [
    view,
    ...wrappers
  ] = unctions

  return compose(...wrappers)(view)
}
