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
    id bigint NOT NULL,
    account_id uuid NOT NULL,
    namespace character varying,
    event character varying NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: account_role_state_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_role_state_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_role_state_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_role_state_transitions_id_seq OWNED BY account_role_state_transitions.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email citext NOT NULL,
    username citext NOT NULL,
    role_state citext NOT NULL,
    encrypted_password character varying NOT NULL,
    authentication_secret character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
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
-- Name: billing_informations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE billing_informations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    postal character varying NOT NULL,
    city character varying NOT NULL,
    state character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: cart_checkout_state_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cart_checkout_state_transitions (
    id bigint NOT NULL,
    cart_id uuid NOT NULL,
    namespace character varying,
    event character varying NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: cart_checkout_state_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cart_checkout_state_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_checkout_state_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cart_checkout_state_transitions_id_seq OWNED BY cart_checkout_state_transitions.id;


--
-- Name: cart_item_purchase_state_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cart_item_purchase_state_transitions (
    id bigint NOT NULL,
    cart_item_id uuid NOT NULL,
    namespace character varying,
    event character varying NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: cart_item_purchase_state_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cart_item_purchase_state_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_item_purchase_state_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cart_item_purchase_state_transitions_id_seq OWNED BY cart_item_purchase_state_transitions.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cart_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    cart_id uuid NOT NULL,
    product_id uuid NOT NULL,
    price_cents integer NOT NULL,
    account_id uuid NOT NULL,
    purchase_state character varying NOT NULL,
    price_currency character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE carts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    account_id uuid NOT NULL,
    billing_information_id uuid,
    shipping_information_id uuid,
    payment_id uuid,
    checkout_state character varying NOT NULL,
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
    tag_id integer NOT NULL,
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
    id bigint NOT NULL,
    name citext NOT NULL,
    taggings_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: gutentag_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE gutentag_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: gutentag_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE gutentag_tags_id_seq OWNED BY gutentag_tags.id;


--
-- Name: payment_purchase_state_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE payment_purchase_state_transitions (
    id bigint NOT NULL,
    payment_id uuid NOT NULL,
    namespace character varying,
    event character varying NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: payment_purchase_state_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payment_purchase_state_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_purchase_state_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payment_purchase_state_transitions_id_seq OWNED BY payment_purchase_state_transitions.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    type character varying NOT NULL,
    external_id text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: product_visibility_state_transitions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE product_visibility_state_transitions (
    id bigint NOT NULL,
    product_id uuid NOT NULL,
    namespace character varying,
    event character varying NOT NULL,
    "from" character varying NOT NULL,
    "to" character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: product_visibility_state_transitions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_visibility_state_transitions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_visibility_state_transitions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_visibility_state_transitions_id_seq OWNED BY product_visibility_state_transitions.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    description character varying NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    checksum character varying NOT NULL,
    price_cents integer NOT NULL,
    price_currency character varying NOT NULL,
    visibility_state character varying NOT NULL,
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
-- Name: shipping_informations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE shipping_informations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    address text NOT NULL,
    postal character varying NOT NULL,
    city character varying NOT NULL,
    state character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: account_role_state_transitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_role_state_transitions ALTER COLUMN id SET DEFAULT nextval('account_role_state_transitions_id_seq'::regclass);


--
-- Name: cart_checkout_state_transitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_checkout_state_transitions ALTER COLUMN id SET DEFAULT nextval('cart_checkout_state_transitions_id_seq'::regclass);


--
-- Name: cart_item_purchase_state_transitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_item_purchase_state_transitions ALTER COLUMN id SET DEFAULT nextval('cart_item_purchase_state_transitions_id_seq'::regclass);


--
-- Name: friendly_id_slugs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: gutentag_taggings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gutentag_taggings ALTER COLUMN id SET DEFAULT nextval('gutentag_taggings_id_seq'::regclass);


--
-- Name: gutentag_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY gutentag_tags ALTER COLUMN id SET DEFAULT nextval('gutentag_tags_id_seq'::regclass);


--
-- Name: payment_purchase_state_transitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY payment_purchase_state_transitions ALTER COLUMN id SET DEFAULT nextval('payment_purchase_state_transitions_id_seq'::regclass);


--
-- Name: product_visibility_state_transitions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_visibility_state_transitions ALTER COLUMN id SET DEFAULT nextval('product_visibility_state_transitions_id_seq'::regclass);


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
-- Name: billing_informations billing_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY billing_informations
    ADD CONSTRAINT billing_informations_pkey PRIMARY KEY (id);


--
-- Name: cart_checkout_state_transitions cart_checkout_state_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_checkout_state_transitions
    ADD CONSTRAINT cart_checkout_state_transitions_pkey PRIMARY KEY (id);


--
-- Name: cart_item_purchase_state_transitions cart_item_purchase_state_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_item_purchase_state_transitions
    ADD CONSTRAINT cart_item_purchase_state_transitions_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


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
-- Name: payment_purchase_state_transitions payment_purchase_state_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payment_purchase_state_transitions
    ADD CONSTRAINT payment_purchase_state_transitions_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: product_visibility_state_transitions product_visibility_state_transitions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_visibility_state_transitions
    ADD CONSTRAINT product_visibility_state_transitions_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shipping_informations shipping_informations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY shipping_informations
    ADD CONSTRAINT shipping_informations_pkey PRIMARY KEY (id);


--
-- Name: index_account_role_state_transitions_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_account_role_state_transitions_on_account_id ON account_role_state_transitions USING btree (account_id);


--
-- Name: index_accounts_on_authentication_secret; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_authentication_secret ON accounts USING btree (authentication_secret);


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
-- Name: index_cart_checkout_state_transitions_on_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_checkout_state_transitions_on_cart_id ON cart_checkout_state_transitions USING btree (cart_id);


--
-- Name: index_cart_item_purchase_state_transitions_on_cart_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_item_purchase_state_transitions_on_cart_item_id ON cart_item_purchase_state_transitions USING btree (cart_item_id);


--
-- Name: index_cart_items_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_account_id ON cart_items USING btree (account_id);


--
-- Name: index_cart_items_on_cart_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_cart_id ON cart_items USING btree (cart_id);


--
-- Name: index_cart_items_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_product_id ON cart_items USING btree (product_id);


--
-- Name: index_cart_items_on_purchase_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_cart_items_on_purchase_state ON cart_items USING btree (purchase_state);


--
-- Name: index_carts_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_carts_on_account_id ON carts USING btree (account_id);


--
-- Name: index_carts_on_billing_information_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_billing_information_id ON carts USING btree (billing_information_id);


--
-- Name: index_carts_on_checkout_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_checkout_state ON carts USING btree (checkout_state);


--
-- Name: index_carts_on_payment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_payment_id ON carts USING btree (payment_id);


--
-- Name: index_carts_on_shipping_information_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_carts_on_shipping_information_id ON carts USING btree (shipping_information_id);


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
-- Name: index_payment_purchase_state_transitions_on_payment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payment_purchase_state_transitions_on_payment_id ON payment_purchase_state_transitions USING btree (payment_id);


--
-- Name: index_payments_on_external_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_payments_on_external_id ON payments USING btree (external_id);


--
-- Name: index_payments_on_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_type ON payments USING btree (type);


--
-- Name: index_product_visibility_state_transitions_on_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_product_visibility_state_transitions_on_product_id ON product_visibility_state_transitions USING btree (product_id);


--
-- Name: index_products_on_checksum; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_checksum ON products USING btree (checksum);


--
-- Name: index_products_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_products_on_slug ON products USING btree (slug);


--
-- Name: index_products_on_visibility_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_visibility_state ON products USING btree (visibility_state);


--
-- Name: account_role_state_transitions fk_rails_0c30cd3475; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_role_state_transitions
    ADD CONSTRAINT fk_rails_0c30cd3475 FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: cart_checkout_state_transitions fk_rails_496a55b319; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_checkout_state_transitions
    ADD CONSTRAINT fk_rails_496a55b319 FOREIGN KEY (cart_id) REFERENCES carts(id);


--
-- Name: carts fk_rails_4b615673ca; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT fk_rails_4b615673ca FOREIGN KEY (payment_id) REFERENCES payments(id);


--
-- Name: product_visibility_state_transitions fk_rails_53abab5280; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_visibility_state_transitions
    ADD CONSTRAINT fk_rails_53abab5280 FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: cart_items fk_rails_681a180e84; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_items
    ADD CONSTRAINT fk_rails_681a180e84 FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: cart_items fk_rails_6cdb1f0139; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_items
    ADD CONSTRAINT fk_rails_6cdb1f0139 FOREIGN KEY (cart_id) REFERENCES carts(id);


--
-- Name: carts fk_rails_772f954818; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT fk_rails_772f954818 FOREIGN KEY (billing_information_id) REFERENCES billing_informations(id);


--
-- Name: carts fk_rails_955c878d40; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT fk_rails_955c878d40 FOREIGN KEY (shipping_information_id) REFERENCES shipping_informations(id);


--
-- Name: cart_items fk_rails_c0ea132c68; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_items
    ADD CONSTRAINT fk_rails_c0ea132c68 FOREIGN KEY (account_id) REFERENCES accounts(id);


--
-- Name: gutentag_taggings fk_rails_cb73a18b77; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY gutentag_taggings
    ADD CONSTRAINT fk_rails_cb73a18b77 FOREIGN KEY (tag_id) REFERENCES gutentag_tags(id);


--
-- Name: cart_item_purchase_state_transitions fk_rails_ccf8aa366a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cart_item_purchase_state_transitions
    ADD CONSTRAINT fk_rails_ccf8aa366a FOREIGN KEY (cart_item_id) REFERENCES cart_items(id);


--
-- Name: payment_purchase_state_transitions fk_rails_eb6c2d47dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY payment_purchase_state_transitions
    ADD CONSTRAINT fk_rails_eb6c2d47dd FOREIGN KEY (payment_id) REFERENCES payments(id);


--
-- Name: carts fk_rails_f37446ef7b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY carts
    ADD CONSTRAINT fk_rails_f37446ef7b FOREIGN KEY (account_id) REFERENCES accounts(id);


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
('20180106211741'),
('20180127234151'),
('20180127234212'),
('20180127234414'),
('20180127234442'),
('20180127234443'),
('20180127234444'),
('20180128190453'),
('20180128190503'),
('20180128190504'),
('20180128190505');


