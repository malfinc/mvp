import dig from "@unction/dig"


export default function inputSelector (state, props) {
  const {formSlug} = props
  const {fieldSlug} = props
  const {value} = props

  return dig(["forms", formSlug, fieldSlug, "value"])(state) || value
}
