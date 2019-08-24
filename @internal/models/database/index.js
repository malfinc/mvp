import PouchDB from "pouchdb";
import pouchDBQuickSearch from "pouchdb-quick-search";
import pouchDBAdapterMemory from "pouchdb-adapter-memory";
import {mergeDeepRight} from "@unction/complete";
import {mapValues} from "@unction/complete";
import {get} from "@unction/complete";
import visibility from "visibilityjs";

PouchDB.plugin(pouchDBQuickSearch);
PouchDB.plugin(pouchDBAdapterMemory);

const INFO_INTERVAL = 15000;
const DATABASE_CONFIGURATION = {
  search: {
    active: false,
  },
  local: {
    auto_compaction: true,
  },
  remote: {
    auth: {
      username: process.env.COUCHDB_USERNAME,
      password: process.env.COUCHDB_PASSWORD,
    },
  },
};
const REPLICATION_CONFIGURATION = {
  live: true,
  retry: true,
  heartbeat: true,
  batch_size: 250,
};

export default {
  state: {
    search: {
      active: false,
      query: "",
    },
    remote: {
      documentCount: 0,
    },
    local: {
      documentCount: 0,
    },
    replication: {
      pendingCount: 0,
      incoming: [],
    },
  },
  reducers: {
    storeClient (currentState, [type, client]) {
      return mergeDeepRight(currentState)({[type]: {client}});
    },
    updateMetadata (currentState, [type, information]) {
      return mergeDeepRight(currentState)({
        [type]: {
          documentCount: information.doc_count,
          lastCheckedAt: new Date(),
        },
      });
    },
    toggleSearching (currentState) {
      return mergeDeepRight(currentState)({search: {active: !currentState.active}});
    },
    updateSearch (currentState, payload) {
      return mergeDeepRight(currentState)({search: payload});
    },
    startReplication (currentState, job) {
      return mergeDeepRight(currentState)({replication: {job, lastStartedAt: new Date()}});
    },
    updateReplication (currentState, information) {
      return mergeDeepRight(currentState)({
        replication: {
          lastChangedAt: new Date(),
          replicatedCount: information.docs_written,
          pendingCount: information.pending,
          incoming: mapValues(get("_id"))(information.docs),
        },
      });
    },
    pauseReplication (currentState) {
      return mergeDeepRight(currentState)({replication: {lastPausedAt: new Date(), incoming: []}});
    },
    resumeReplication (currentState) {
      return mergeDeepRight(currentState)({replication: {lastStartedAt: new Date()}});
    },
    crashReplication (currentState) {
      return currentState;
    },
    completeReplication (currentState) {
      return currentState;
    },
  },
  effects (dispatch) {
    return {
      async initialize () {
        await dispatch.database.create(["local", "primary"]);
        await dispatch.database.check("local");
        setInterval(() => dispatch.database.check("local"), INFO_INTERVAL);

        await dispatch.database.create(["remote", process.env.COUCHDB_URI]);
        await dispatch.database.check("remote");
        setInterval(() => dispatch.database.check("remote"), INFO_INTERVAL);

        dispatch.database.replicate({from: "remote", to: "local"});
      },
      async index (nothing, {database}) {
        await database.local.client.search({
          fields: ["words"],
          build: true,
        });
        await database.local.client.search({
          fields: ["definitions.detail"],
          build: true,
        });
        await database.local.client.search({
          fields: ["words", "definitions.detail"],
          build: true,
        });
      },
      async create ([type, location]) {
        return dispatch.database.storeClient([type, await new PouchDB(location, DATABASE_CONFIGURATION[type])]);
      },
      async check (type, {database}) {
        if (visibility.hidden()) {
          return null;
        }

        return dispatch.database.updateMetadata([type, await database[type].client.info()]);
      },
      writeEntry (data, {database}) {
        return database.remote.client.put(data);
      },
      getEntry (id, {database}) {
        return database.local.client.get(id);
      },
      deleteEntry (id, {database}) {
        return database.remote.client.delete(id);
      },
      replicate ({from, to}, {database}) {
        return dispatch.database.startReplication(
          database[to].client.replicate.from(database[from].client, REPLICATION_CONFIGURATION)
            // handle change
            .on("change", dispatch.database.updateReplication)
            // replication paused (e.g. replication up to date, user went offline)
            .on("paused", dispatch.database.pauseReplication)
            .on("paused", dispatch.database.index)
            // replicate resumed (e.g. new changes replicating, user went back online)
            .on("active", dispatch.database.resumeReplication)
            // a document failed to replicate (e.g. due to permissions)
            .on("denied", dispatch.database.crashReplication)
            // handle complete
            .on("complete", dispatch.database.completeReplication)
            .on("complete", dispatch.database.index)
            // handle error
            .on("error", dispatch.database.crashReplication)
        );
      },
      async search ([query, fields], {database}) {
        dispatch.database.toggleSearching();
        dispatch.database.updateSearch({query});

        const results = await database.local.client.search({
          query,
          fields,
          include_docs: true,
        });

        dispatch.database.toggleSearching();
        dispatch.database.updateSearch({count: results.total_rows});

        return results;
      },
    };
  },
};
