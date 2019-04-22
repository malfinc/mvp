import pipe from "@unction/pipe";
import last from "@unction/last";
import dropLast from "@unction/droplast";

const PRESENTER_POSITION = 1;

export default function view (unctions) {
  return pipe(dropLast(PRESENTER_POSITION)(unctions))(last(unctions));
}
