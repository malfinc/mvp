import {createStructuredSelector} from "reselect";
import {mergeRight} from "@unction/complete";


export default function combinedSelectors (selectors) {
  return function combinedSelectorsSelectors (state, props) {
    return mergeRight(
      props
    )(
      createStructuredSelector(selectors)(state, props)
    );
  };
}
