import PouchDB from "pouchdb";

export default function local (slug) {
  return new PouchDB(`local-${slug}`);
}
