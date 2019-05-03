import {pipe} from "@unction/complete";
import {last} from "@unction/complete";
import {dropLast} from "@unction/complete";

const PRESENTER_POSITION = 1;

export default function view (unctions) {
  return pipe(dropLast(PRESENTER_POSITION)(unctions))(last(unctions));
}
