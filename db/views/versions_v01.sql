  SELECT
    "uuid_versions"."id"::text AS "id",
    "uuid_versions"."item_type" AS "item_type",
    "uuid_versions"."item_id"::text AS "item_id",
    "uuid_versions"."event" AS "event",
    "uuid_versions"."whodunnit" AS "whodunnit",
    "uuid_versions"."actor_id" AS "actor_id",
    "uuid_versions"."transitions" AS "transitions",
    "uuid_versions"."object_changes" AS "object_changes",
    "uuid_versions"."created_at" AS "created_at",
    "uuid_versions"."context_id" AS "context_id"
  FROM
    "uuid_versions"
UNION
  SELECT
    "bigint_versions"."id"::text AS "id",
    "bigint_versions"."item_type" AS "item_type",
    "bigint_versions"."item_id"::text AS "item_id",
    "bigint_versions"."event" AS "event",
    "bigint_versions"."whodunnit" AS "whodunnit",
    "bigint_versions"."actor_id" AS "actor_id",
    "bigint_versions"."transitions" AS "transitions",
    "bigint_versions"."object_changes" AS "object_changes",
    "bigint_versions"."created_at" AS "created_at",
    "bigint_versions"."context_id" AS "context_id"
  FROM
    "bigint_versions"
