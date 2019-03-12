import dig from "@unction/dig"


export default function formSelector (state, props) {
  const {formSlug} = props

  return dig(["forms", formSlug])(state)
}
