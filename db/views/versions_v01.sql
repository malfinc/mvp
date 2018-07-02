  SELECT
    "public_versions"."id" AS "id",
    "public_versions"."item_type" AS "item_type",
    "public_versions"."item_id"::text AS "item_id",
    "public_versions"."event" AS "event",
    "public_versions"."whodunnit" AS "whodunnit",
    "public_versions"."actor_id" AS "actor_id",
    "public_versions"."transitions" AS "transitions",
    "public_versions"."object"::jsonb AS "object",
    "public_versions"."object_changes" AS "object_changes",
    "public_versions"."created_at" AS "created_at",
    "public_versions"."group_id" AS "group_id"
  FROM
    "public_versions"
UNION
  SELECT
    "private_versions"."id" AS "id",
    "private_versions"."item_type" AS "item_type",
    "private_versions"."item_id"::text AS "item_id",
    "private_versions"."event" AS "event",
    "private_versions"."whodunnit" AS "whodunnit",
    "private_versions"."actor_id" AS "actor_id",
    "private_versions"."transitions" AS "transitions",
    "private_versions"."object"::jsonb AS "object",
    "private_versions"."object_changes" AS "object_changes",
    "private_versions"."created_at" AS "created_at",
    "private_versions"."group_id" AS "group_id"
  FROM
    "private_versions"
