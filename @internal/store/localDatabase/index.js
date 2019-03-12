import PouchDB from "pouchdb"

export default function localDatabase (slug) {
  return new PouchDB(`local-${slug}`)
}
