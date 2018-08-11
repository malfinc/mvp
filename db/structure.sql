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
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name text NOT NULL,
    moderation_state text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


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
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
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
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('public.friendly_id_slugs_id_seq'::regclass);


--
-- Name: gutentag_taggings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gutentag_taggings ALTER COLUMN id SET DEFAULT nextval('public.gutentag_taggings_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


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
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


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
-- Name: index_payment_types_on_moderation_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payment_types_on_moderation_state ON public.payment_types USING btree (moderation_state);


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
-- Name: index_versions_on_actor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_actor_id ON public.versions USING btree (actor_id) WHERE (actor_id IS NOT NULL);


--
-- Name: index_versions_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_context_id ON public.versions USING btree (context_id);


--
-- Name: index_versions_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_created_at ON public.versions USING btree (created_at);


--
-- Name: index_versions_on_event; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_event ON public.versions USING btree (event);


--
-- Name: index_versions_on_item_id_and_item_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_item_id_and_item_type ON public.versions USING btree (item_id, item_type);


--
-- Name: versions fk_rails_2e5ab7c04d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT fk_rails_2e5ab7c04d FOREIGN KEY (actor_id) REFERENCES public.accounts(id);


--
-- Name: payments fk_rails_81b2605d2a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_81b2605d2a FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: gutentag_taggings fk_rails_cb73a18b77; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.gutentag_taggings
    ADD CONSTRAINT fk_rails_cb73a18b77 FOREIGN KEY (tag_id) REFERENCES public.gutentag_tags(id);


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
('20180127234446'),
('20180408203926'),
('20180702080347');


