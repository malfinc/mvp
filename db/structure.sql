SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accounts (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text,
    email public.citext,
    username public.citext,
    onboarding_state public.citext NOT NULL,
    role_state public.citext NOT NULL,
    encrypted_password text NOT NULL,
    authentication_secret text NOT NULL,
    reset_password_token text,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token text,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email text,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token text,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT accounts_name_null CHECK (((NOT (onboarding_state OPERATOR(public.=) 'completed'::public.citext)) OR (name IS NOT NULL)))
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bigint_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bigint_versions (
    id bigint NOT NULL,
    item_type text NOT NULL,
    item_id bigint NOT NULL,
    event text NOT NULL,
    whodunnit text NOT NULL,
    actor_id uuid,
    context_id uuid NOT NULL,
    transitions jsonb,
    object json DEFAULT '{}'::json NOT NULL,
    object_changes jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: bigint_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bigint_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bigint_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bigint_versions_id_seq OWNED BY public.bigint_versions.id;


--
-- Name: billing_informations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_informations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    postal text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: billing_informations_carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_informations_carts (
    billing_information_id uuid NOT NULL,
    cart_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    cart_id uuid NOT NULL,
    product_id uuid NOT NULL,
    price_cents integer NOT NULL,
    price_currency text DEFAULT 'usd'::text NOT NULL,
    discount_cents integer DEFAULT 0 NOT NULL,
    discount_currency text DEFAULT 'usd'::text NOT NULL,
    account_id uuid NOT NULL,
    purchase_state text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    account_id uuid NOT NULL,
    delivery_information_id uuid,
    billing_information_id uuid,
    checkout_state text NOT NULL,
    total_cents integer,
    total_currency text DEFAULT 'usd'::text,
    subtotal_cents integer,
    subtotal_currency text DEFAULT 'usd'::text,
    discount_cents integer,
    discount_currency text DEFAULT 'usd'::text,
    tax_cents integer,
    tax_currency text DEFAULT 'usd'::text,
    shipping_cents integer,
    shipping_currency text DEFAULT 'usd'::text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT carts_billing_information_id_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (billing_information_id IS NOT NULL))),
    CONSTRAINT carts_delivery_information_id_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (delivery_information_id IS NOT NULL))),
    CONSTRAINT carts_discount_cents_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (discount_cents IS NOT NULL))),
    CONSTRAINT carts_discount_currency_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (discount_currency IS NOT NULL))),
    CONSTRAINT carts_shipping_cents_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (shipping_cents IS NOT NULL))),
    CONSTRAINT carts_shipping_currency_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (shipping_currency IS NOT NULL))),
    CONSTRAINT carts_subtotal_cents_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (subtotal_cents IS NOT NULL))),
    CONSTRAINT carts_subtotal_currency_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (subtotal_currency IS NOT NULL))),
    CONSTRAINT carts_tax_cents_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (tax_cents IS NOT NULL))),
    CONSTRAINT carts_tax_currency_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (tax_currency IS NOT NULL))),
    CONSTRAINT carts_total_cents_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (total_cents IS NOT NULL))),
    CONSTRAINT carts_total_currency_null CHECK (((NOT (checkout_state = 'purchased'::text)) OR (total_currency IS NOT NULL)))
);


--
-- Name: carts_delivery_informations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts_delivery_informations (
    cart_id uuid NOT NULL,
    delivery_information_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: delivery_informations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_informations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    postal text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.friendly_id_slugs (
    id bigint NOT NULL,
    slug public.citext NOT NULL,
    sluggable_id uuid NOT NULL,
    sluggable_type text NOT NULL,
    scope text,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.friendly_id_slugs_id_seq OWNED BY public.friendly_id_slugs.id;


--
-- Name: gutentag_taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gutentag_taggings (
    id bigint NOT NULL,
    tag_id uuid NOT NULL,
    taggable_id uuid NOT NULL,
    taggable_type text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: gutentag_taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.gutentag_taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gutentag_taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.gutentag_taggings_id_seq OWNED BY public.gutentag_taggings.id;


--
-- Name: gutentag_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.gutentag_tags (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name public.citext NOT NULL,
    taggings_count bigint DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payment_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_types (
    id bigint NOT NULL,
    name text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: payment_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_types_id_seq OWNED BY public.payment_types.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    subtype text NOT NULL,
    source_id text NOT NULL,
    account_id uuid NOT NULL,
    cart_id uuid NOT NULL,
    paid_cents integer NOT NULL,
    paid_currency text DEFAULT 'usd'::text NOT NULL,
    restitution_cents integer,
    restitution_currency text DEFAULT 'usd'::text,
    processing_state public.citext NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT payments_restitution_cents_null CHECK (((NOT (processing_state OPERATOR(public.=) 'refunded'::public.citext)) OR (restitution_cents IS NOT NULL))),
    CONSTRAINT payments_restitution_currency_null CHECK (((NOT (processing_state OPERATOR(public.=) 'refunded'::public.citext)) OR (restitution_currency IS NOT NULL)))
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    checksum text NOT NULL,
    price_cents integer NOT NULL,
    price_currency text DEFAULT 'usd'::text NOT NULL,
    visibility_state text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: uuid_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.uuid_versions (
    id bigint NOT NULL,
    item_type text NOT NULL,
    item_id uuid NOT NULL,
    event text NOT NULL,
    whodunnit text NOT NULL,
    actor_id uuid,
    context_id uuid NOT NULL,
    transitions jsonb,
    object json DEFAULT '{}'::json NOT NULL,
    object_changes jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: uuid_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.uuid_versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uuid_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.uuid_versions_id_seq OWNED BY public.uuid_versions.id;


--
-- Name: versions; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.versions AS
 SELECT (uuid_versions.id)::text AS id,
    uuid_versions.item_type,
    (uuid_versions.item_id)::text AS item_id,
    uuid_versions.event,
    uuid_versions.whodunnit,
    uuid_versions.actor_id,
    uuid_versions.transitions,
    uuid_versions.object_changes,
    uuid_versions.created_at,
    uuid_versions.context_id
   FROM public.uuid_versions
UNION
 SELECT (bigint_versions.id)::text AS id,
    bigint_versions.item_type,
    (bigint_versions.item_id)::text AS item_id,
    bigint_versions.event,
    bigint_versions.whodunnit,
    bigint_versions.actor_id,
    bigint_versions.transitions,
    bigint_versions.object_changes,
    bigint_versions.created_at,
    bigint_versions.context_id
   FROM public.bigint_versions;


--
-- Name: bigint_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bigint_versions ALTER COLUMN id SET DEFAULT nextval('public.bigint_versions_id_seq'::regclass);


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('public.friendly_id_slugs_id_seq'::regclass);


--
-- Name: gutentag_taggings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gutentag_taggings ALTER COLUMN id SET DEFAULT nextval('public.gutentag_taggings_id_seq'::regclass);


--
-- Name: payment_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_types ALTER COLUMN id SET DEFAULT nextval('public.payment_types_id_seq'::regclass);


--
-- Name: uuid_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uuid_versions ALTER COLUMN id SET DEFAULT nextval('public.uuid_versions_id_seq'::regclass);


--
-- Name: accounts accounts_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_email_unique UNIQUE (email) DEFERRABLE;


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_username_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_username_unique UNIQUE (username) DEFERRABLE;


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bigint_versions bigint_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bigint_versions
    ADD CONSTRAINT bigint_versions_pkey PRIMARY KEY (id);


--
-- Name: billing_informations billing_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_informations
    ADD CONSTRAINT billing_informations_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_account_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_account_id_unique UNIQUE (account_id) DEFERRABLE;


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- Name: delivery_informations delivery_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_informations
    ADD CONSTRAINT delivery_informations_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: gutentag_taggings gutentag_taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gutentag_taggings
    ADD CONSTRAINT gutentag_taggings_pkey PRIMARY KEY (id);


--
-- Name: gutentag_tags gutentag_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gutentag_tags
    ADD CONSTRAINT gutentag_tags_pkey PRIMARY KEY (id);


--
-- Name: payment_types payment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_types
    ADD CONSTRAINT payment_types_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: uuid_versions uuid_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uuid_versions
    ADD CONSTRAINT uuid_versions_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_authentication_secret; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_authentication_secret ON public.accounts USING btree (authentication_secret);


--
-- Name: index_accounts_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_confirmation_token ON public.accounts USING btree (confirmation_token);


--
-- Name: index_accounts_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_email ON public.accounts USING btree (email);


--
-- Name: index_accounts_on_onboarding_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_onboarding_state ON public.accounts USING btree (onboarding_state);


--
-- Name: index_accounts_on_role_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_role_state ON public.accounts USING btree (role_state);


--
-- Name: index_accounts_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_unlock_token ON public.accounts USING btree (unlock_token);


--
-- Name: index_accounts_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_username ON public.accounts USING btree (username);


--
-- Name: index_bigint_versions_on_actor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bigint_versions_on_actor_id ON public.bigint_versions USING btree (actor_id) WHERE (actor_id IS NOT NULL);


--
-- Name: index_bigint_versions_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bigint_versions_on_context_id ON public.bigint_versions USING btree (context_id);


--
-- Name: index_bigint_versions_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bigint_versions_on_created_at ON public.bigint_versions USING btree (created_at);


--
-- Name: index_bigint_versions_on_event; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bigint_versions_on_event ON public.bigint_versions USING btree (event);


--
-- Name: index_bigint_versions_on_item_id_and_item_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bigint_versions_on_item_id_and_item_type ON public.bigint_versions USING btree (item_id, item_type);


--
-- Name: index_billing_information_carts_on_join_columns; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_billing_information_carts_on_join_columns ON public.billing_informations_carts USING btree (billing_information_id, cart_id);


--
-- Name: index_billing_informations_carts_on_billing_information_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billing_informations_carts_on_billing_information_id ON public.billing_informations_carts USING btree (billing_information_id);


--
-- Name: index_billing_informations_carts_on_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billing_informations_carts_on_cart_id ON public.billing_informations_carts USING btree (cart_id);


--
-- Name: index_billing_informations_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billing_informations_on_account_id ON public.billing_informations USING btree (account_id);


--
-- Name: index_cart_items_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_account_id ON public.cart_items USING btree (account_id);


--
-- Name: index_cart_items_on_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_cart_id ON public.cart_items USING btree (cart_id);


--
-- Name: index_cart_items_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_product_id ON public.cart_items USING btree (product_id);


--
-- Name: index_cart_items_on_purchase_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_purchase_state ON public.cart_items USING btree (purchase_state);


--
-- Name: index_carts_delivery_informations_on_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_delivery_informations_on_cart_id ON public.carts_delivery_informations USING btree (cart_id);


--
-- Name: index_carts_delivery_informations_on_delivery_information_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_delivery_informations_on_delivery_information_id ON public.carts_delivery_informations USING btree (delivery_information_id);


--
-- Name: index_carts_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_account_id ON public.carts USING btree (account_id);


--
-- Name: index_carts_on_billing_information_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_billing_information_id ON public.carts USING btree (billing_information_id) WHERE (billing_information_id IS NOT NULL);


--
-- Name: index_carts_on_checkout_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_checkout_state ON public.carts USING btree (checkout_state);


--
-- Name: index_carts_on_delivery_information_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_delivery_information_id ON public.carts USING btree (delivery_information_id) WHERE (delivery_information_id IS NOT NULL);


--
-- Name: index_delivery_information_carts_on_join_columns; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_delivery_information_carts_on_join_columns ON public.carts_delivery_informations USING btree (delivery_information_id, cart_id);


--
-- Name: index_delivery_informations_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_delivery_informations_on_account_id ON public.delivery_informations USING btree (account_id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON public.friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON public.friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_id_and_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id_and_sluggable_type ON public.friendly_id_slugs USING btree (sluggable_id, sluggable_type);


--
-- Name: index_guten_taggings_on_unique_tagging; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_guten_taggings_on_unique_tagging ON public.gutentag_taggings USING btree (tag_id, taggable_id, taggable_type);


--
-- Name: index_gutentag_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_taggings_on_tag_id ON public.gutentag_taggings USING btree (tag_id);


--
-- Name: index_gutentag_taggings_on_taggable_id_and_taggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_taggings_on_taggable_id_and_taggable_type ON public.gutentag_taggings USING btree (taggable_id, taggable_type);


--
-- Name: index_gutentag_tags_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_tags_on_created_at ON public.gutentag_tags USING btree (created_at);


--
-- Name: index_gutentag_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_gutentag_tags_on_name ON public.gutentag_tags USING btree (name);


--
-- Name: index_gutentag_tags_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_tags_on_updated_at ON public.gutentag_tags USING btree (updated_at);


--
-- Name: index_payment_types_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_payment_types_on_name ON public.payment_types USING btree (name);


--
-- Name: index_payments_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_account_id ON public.payments USING btree (account_id);


--
-- Name: index_payments_on_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_cart_id ON public.payments USING btree (cart_id);


--
-- Name: index_payments_on_processing_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_processing_state ON public.payments USING btree (processing_state);


--
-- Name: index_payments_on_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_source_id ON public.payments USING btree (source_id);


--
-- Name: index_payments_on_subtype; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_subtype ON public.payments USING btree (subtype);


--
-- Name: index_products_on_checksum; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_checksum ON public.products USING btree (checksum);


--
-- Name: index_products_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_products_on_slug ON public.products USING btree (slug);


--
-- Name: index_products_on_visibility_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_visibility_state ON public.products USING btree (visibility_state);


--
-- Name: index_uuid_versions_on_actor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uuid_versions_on_actor_id ON public.uuid_versions USING btree (actor_id) WHERE (actor_id IS NOT NULL);


--
-- Name: index_uuid_versions_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uuid_versions_on_context_id ON public.uuid_versions USING btree (context_id);


--
-- Name: index_uuid_versions_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uuid_versions_on_created_at ON public.uuid_versions USING btree (created_at);


--
-- Name: index_uuid_versions_on_event; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uuid_versions_on_event ON public.uuid_versions USING btree (event);


--
-- Name: index_uuid_versions_on_item_id_and_item_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_uuid_versions_on_item_id_and_item_type ON public.uuid_versions USING btree (item_id, item_type);


--
-- Name: delivery_informations fk_rails_04842698b7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_informations
    ADD CONSTRAINT fk_rails_04842698b7 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: billing_informations fk_rails_0ae4f22b90; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_informations
    ADD CONSTRAINT fk_rails_0ae4f22b90 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: payments fk_rails_2bc1cfea36; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_2bc1cfea36 FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: billing_informations_carts fk_rails_314ea0ecbc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_informations_carts
    ADD CONSTRAINT fk_rails_314ea0ecbc FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: carts fk_rails_511bc15c1c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_rails_511bc15c1c FOREIGN KEY (delivery_information_id) REFERENCES public.delivery_informations(id);


--
-- Name: cart_items fk_rails_681a180e84; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_rails_681a180e84 FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: cart_items fk_rails_6cdb1f0139; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_rails_6cdb1f0139 FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: carts_delivery_informations fk_rails_6efe453fc7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts_delivery_informations
    ADD CONSTRAINT fk_rails_6efe453fc7 FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- Name: carts fk_rails_772f954818; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_rails_772f954818 FOREIGN KEY (billing_information_id) REFERENCES public.billing_informations(id);


--
-- Name: payments fk_rails_81b2605d2a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_81b2605d2a FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: uuid_versions fk_rails_8aa0e36113; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.uuid_versions
    ADD CONSTRAINT fk_rails_8aa0e36113 FOREIGN KEY (actor_id) REFERENCES public.accounts(id);


--
-- Name: cart_items fk_rails_c0ea132c68; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_rails_c0ea132c68 FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: gutentag_taggings fk_rails_cb73a18b77; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gutentag_taggings
    ADD CONSTRAINT fk_rails_cb73a18b77 FOREIGN KEY (tag_id) REFERENCES public.gutentag_tags(id);


--
-- Name: bigint_versions fk_rails_da90abbf6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bigint_versions
    ADD CONSTRAINT fk_rails_da90abbf6a FOREIGN KEY (actor_id) REFERENCES public.accounts(id);


--
-- Name: carts_delivery_informations fk_rails_f16a9ea94b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts_delivery_informations
    ADD CONSTRAINT fk_rails_f16a9ea94b FOREIGN KEY (delivery_information_id) REFERENCES public.delivery_informations(id);


--
-- Name: carts fk_rails_f37446ef7b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT fk_rails_f37446ef7b FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: billing_informations_carts fk_rails_fc1ca91f0a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_informations_carts
    ADD CONSTRAINT fk_rails_fc1ca91f0a FOREIGN KEY (billing_information_id) REFERENCES public.billing_informations(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20171203045258'),
('20171203045306'),
('20171203045307'),
('20171203064940'),
('20171230031126'),
('20171231104815'),
('20171231104816'),
('20180127234151'),
('20180127234212'),
('20180127234443'),
('20180127234444'),
('20180127234445'),
('20180127234446'),
('20180128190453'),
('20180128190504'),
('20180408203926'),
('20180702062857'),
('20180702062940'),
('20180702080347');


