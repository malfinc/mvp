import PouchDB from "pouchdb";

export default function remoteDatabase (slug) {
  return new PouchDB(`http://localhost:32792/poutineer-${slug}`);
}
