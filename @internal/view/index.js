import {compose} from "recompose";

export default function view (unctions) {
  const [
    presentation,
    ...wrappers
  ] = unctions;

  return compose(...wrappers)(presentation);
}
