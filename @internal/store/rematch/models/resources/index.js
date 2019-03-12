import indexBy from "@unction/indexby"
import groupBy from "@unction/groupby"
import objectFrom from "@unction/objectfrom"
import mergeDeepRight from "@unction/mergedeepright"
import treeify from "@unction/treeify"
import dig from "@unction/dig"
import arrayify from "@unction/arrayify"
import pipe from "@unction/pipe"

export default {
  state: {},
  reducers: {
    mergeResource: (state, payload) => pipe([
      arrayify,
      treeify([
        groupBy(dig(["type"])),
        indexBy(dig(["id"])),
      ]),
      objectFrom(["resources"]),
      mergeDeepRight(state),
    ])(payload),
  },
  effects: {},
}
