import {indexBy} from "@unction/complete";
import {groupBy} from "@unction/complete";
import {objectFrom} from "@unction/complete";
import {mergeDeepRight} from "@unction/complete";
import {treeify} from "@unction/complete";
import {dig} from "@unction/complete";
import {arrayify} from "@unction/complete";
import {pipe} from "@unction/complete";

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
};
