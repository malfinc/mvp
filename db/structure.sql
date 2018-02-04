SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_role_state_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE account_role_state_transitions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    account_id uuid NOT NULL,
    namespace character varying NOT NULL,
    event character varying NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text,
    email citext NOT NULL,
    username citext NOT NULL,
    role_state citext NOT NULL,
    encrypted_password character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email citext,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE friendly_id_slugs (
    id bigint NOT NULL,
    slug citext NOT NULL,
    sluggable_id uuid NOT NULL,
    sluggable_type character varying NOT NULL,
    scope character varying,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: gutentag_taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gutentag_taggings (
    id bigint NOT NULL,
    tag_id uuid NOT NULL,
    taggable_id uuid NOT NULL,
    taggable_type character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: gutentag_taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gutentag_taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gutentag_taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gutentag_taggings_id_seq OWNED BY gutentag_taggings.id;


--
-- Name: gutentag_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE gutentag_tags (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name citext NOT NULL,
    taggings_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: recipe_queue_state_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE recipe_queue_state_transitions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    recipe_id uuid NOT NULL,
    namespace character varying NOT NULL,
    event character varying NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: recipes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE recipes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug citext NOT NULL,
    queue_state citext NOT NULL,
    description text NOT NULL,
    author_id uuid NOT NULL,
    approver_id uuid,
    publisher_id uuid,
    denier_id uuid,
    remover_id uuid,
    ingredients text[] DEFAULT '{}'::text[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: gutentag_taggings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gutentag_taggings ALTER COLUMN id SET DEFAULT nextval('gutentag_taggings_id_seq'::regclass);


--
-- Name: account_role_state_transitions account_role_state_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_role_state_transitions
    ADD CONSTRAINT account_role_state_transitions_pkey PRIMARY KEY (id);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: friendly_id_slugs friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: gutentag_taggings gutentag_taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gutentag_taggings
    ADD CONSTRAINT gutentag_taggings_pkey PRIMARY KEY (id);


--
-- Name: gutentag_tags gutentag_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gutentag_tags
    ADD CONSTRAINT gutentag_tags_pkey PRIMARY KEY (id);


--
-- Name: recipe_queue_state_transitions recipe_queue_state_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipe_queue_state_transitions
    ADD CONSTRAINT recipe_queue_state_transitions_pkey PRIMARY KEY (id);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_account_role_state_transitions_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_account_role_state_transitions_on_account_id ON account_role_state_transitions USING btree (account_id);


--
-- Name: index_accounts_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_confirmation_token ON accounts USING btree (confirmation_token);


--
-- Name: index_accounts_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_email ON accounts USING btree (email);


--
-- Name: index_accounts_on_role_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_role_state ON accounts USING btree (role_state);


--
-- Name: index_accounts_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_unlock_token ON accounts USING btree (unlock_token);


--
-- Name: index_accounts_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_username ON accounts USING btree (username);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope ON friendly_id_slugs USING btree (slug, sluggable_type, scope);


--
-- Name: index_friendly_id_slugs_on_sluggable_id_and_sluggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id_and_sluggable_type ON friendly_id_slugs USING btree (sluggable_id, sluggable_type);


--
-- Name: index_guten_taggings_on_unique_tagging; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_guten_taggings_on_unique_tagging ON gutentag_taggings USING btree (tag_id, taggable_id, taggable_type);


--
-- Name: index_gutentag_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_taggings_on_tag_id ON gutentag_taggings USING btree (tag_id);


--
-- Name: index_gutentag_taggings_on_taggable_id_and_taggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_taggings_on_taggable_id_and_taggable_type ON gutentag_taggings USING btree (taggable_id, taggable_type);


--
-- Name: index_gutentag_tags_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_tags_on_created_at ON gutentag_tags USING btree (created_at);


--
-- Name: index_gutentag_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_gutentag_tags_on_name ON gutentag_tags USING btree (name);


--
-- Name: index_gutentag_tags_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_gutentag_tags_on_updated_at ON gutentag_tags USING btree (updated_at);


--
-- Name: index_recipe_queue_state_transitions_on_recipe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipe_queue_state_transitions_on_recipe_id ON recipe_queue_state_transitions USING btree (recipe_id);


--
-- Name: index_recipes_on_approver_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_approver_id ON recipes USING btree (approver_id);


--
-- Name: index_recipes_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_author_id ON recipes USING btree (author_id);


--
-- Name: index_recipes_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_created_at ON recipes USING btree (created_at);


--
-- Name: index_recipes_on_denier_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_denier_id ON recipes USING btree (denier_id);


--
-- Name: index_recipes_on_publisher_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_publisher_id ON recipes USING btree (publisher_id);


--
-- Name: index_recipes_on_queue_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_queue_state ON recipes USING btree (queue_state);


--
-- Name: index_recipes_on_remover_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_remover_id ON recipes USING btree (remover_id);


--
-- Name: index_recipes_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_recipes_on_slug ON recipes USING btree (slug);


--
-- Name: index_recipes_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_recipes_on_updated_at ON recipes USING btree (updated_at);


--
-- Name: recipes fk_rails_08ee84afe6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT fk_rails_08ee84afe6 FOREIGN KEY (author_id) REFERENCES accounts(id);


--
-- Name: account_role_state_transitions fk_rails_0c30cd3475; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_role_state_transitions
    ADD CONSTRAINT fk_rails_0c30cd3475 FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: recipes fk_rails_2622a71154; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT fk_rails_2622a71154 FOREIGN KEY (publisher_id) REFERENCES accounts(id);


--
-- Name: recipes fk_rails_31dbc9f309; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT fk_rails_31dbc9f309 FOREIGN KEY (denier_id) REFERENCES accounts(id);


--
-- Name: recipe_queue_state_transitions fk_rails_43d582b07f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipe_queue_state_transitions
    ADD CONSTRAINT fk_rails_43d582b07f FOREIGN KEY (recipe_id) REFERENCES recipes(id);


--
-- Name: recipes fk_rails_4453ed7f7d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT fk_rails_4453ed7f7d FOREIGN KEY (approver_id) REFERENCES accounts(id);


--
-- Name: recipes fk_rails_486627d510; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY recipes
    ADD CONSTRAINT fk_rails_486627d510 FOREIGN KEY (remover_id) REFERENCES accounts(id);


--
-- Name: gutentag_taggings fk_rails_cb73a18b77; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gutentag_taggings
    ADD CONSTRAINT fk_rails_cb73a18b77 FOREIGN KEY (tag_id) REFERENCES gutentag_tags(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20171203045258'),
('20171203045306'),
('20171203045307'),
('20171203064940'),
('20171210085937'),
('20171230031126'),
('20171231104815'),
('20180106211740'),
('20180106211741');


