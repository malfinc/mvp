import {dig} from "@unction/complete";


export default function formSelector (state, props) {
  const {formSlug} = props;

  return dig(["forms", formSlug])(state);
}
