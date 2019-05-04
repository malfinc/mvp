import PouchDB from "pouchdb";

export default function remote (slug) {
  return new PouchDB(`${window.env.POUCHDB_ORIGIN}/poutineer-${slug}`);
}
