import PouchDB from "pouchdb"
import pouchMemoryAdapter from "pouchdb-adapter-memory"
import pouchQuickSearch from "pouchdb-quick-search"

PouchDB.plugin(pouchMemoryAdapter)
PouchDB.plugin(pouchQuickSearch)

export default new PouchDB("cache", {adapter: "memory"})
