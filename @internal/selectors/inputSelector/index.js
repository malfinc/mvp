import {dig} from "@unction/complete";


export default function inputSelector (state, props) {
  const {formSlug} = props;
  const {fieldSlug} = props;
  const {value} = props;

  return dig(["forms", formSlug, fieldSlug, "value"])(state) || value;
}
