import PouchDB from "pouchdb";

export default function remoteDatabase (slug) {
  return new PouchDB(`${window.env.POUCHDB_ORIGIN}/poutineer-${slug}`);
}
