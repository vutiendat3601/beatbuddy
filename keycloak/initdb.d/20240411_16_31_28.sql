--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO beatbuddy;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO beatbuddy;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO beatbuddy;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO beatbuddy;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO beatbuddy;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO beatbuddy;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO beatbuddy;

--
-- Name: client; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO beatbuddy;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO beatbuddy;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO beatbuddy;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO beatbuddy;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO beatbuddy;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO beatbuddy;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO beatbuddy;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO beatbuddy;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO beatbuddy;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO beatbuddy;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO beatbuddy;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO beatbuddy;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO beatbuddy;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO beatbuddy;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO beatbuddy;

--
-- Name: component; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO beatbuddy;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO beatbuddy;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO beatbuddy;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO beatbuddy;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO beatbuddy;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO beatbuddy;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO beatbuddy;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO beatbuddy;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO beatbuddy;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO beatbuddy;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO beatbuddy;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO beatbuddy;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO beatbuddy;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO beatbuddy;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO beatbuddy;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO beatbuddy;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO beatbuddy;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO beatbuddy;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO beatbuddy;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO beatbuddy;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO beatbuddy;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO beatbuddy;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO beatbuddy;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO beatbuddy;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO beatbuddy;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO beatbuddy;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO beatbuddy;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO beatbuddy;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO beatbuddy;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO beatbuddy;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO beatbuddy;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO beatbuddy;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO beatbuddy;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO beatbuddy;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO beatbuddy;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO beatbuddy;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO beatbuddy;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO beatbuddy;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO beatbuddy;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO beatbuddy;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO beatbuddy;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO beatbuddy;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO beatbuddy;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO beatbuddy;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO beatbuddy;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO beatbuddy;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO beatbuddy;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO beatbuddy;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO beatbuddy;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO beatbuddy;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO beatbuddy;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO beatbuddy;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO beatbuddy;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO beatbuddy;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO beatbuddy;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO beatbuddy;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO beatbuddy;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO beatbuddy;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO beatbuddy;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO beatbuddy;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO beatbuddy;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO beatbuddy;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO beatbuddy;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO beatbuddy;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO beatbuddy;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO beatbuddy;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO beatbuddy;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO beatbuddy;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO beatbuddy;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: beatbuddy
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO beatbuddy;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
cf275b33-579b-40dc-9b25-e647d8b60130	28efea65-0e3a-4204-a743-7c89e5947024
681b7462-7c70-4f50-9c07-901d7733b3f3	ba5c96f2-9954-45ac-b881-0e0394d944ea
681b7462-7c70-4f50-9c07-901d7733b3f3	43475189-4811-4a7e-b7bb-8dda49db566b
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
03bd544a-608e-430a-982a-6033bb9d37f2	\N	auth-cookie	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9a6cdc73-dcf9-4ba6-bf2f-9643649d55cb	2	10	f	\N	\N
b22cc870-3925-4d71-b11e-ac980c15ac52	\N	auth-spnego	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9a6cdc73-dcf9-4ba6-bf2f-9643649d55cb	3	20	f	\N	\N
b9d3c1a6-18e6-4bf8-8d94-d840d0ab3963	\N	identity-provider-redirector	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9a6cdc73-dcf9-4ba6-bf2f-9643649d55cb	2	25	f	\N	\N
467658f3-5543-4428-b6e7-8058b28f30b3	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9a6cdc73-dcf9-4ba6-bf2f-9643649d55cb	2	30	t	bc9b3caf-c0c8-413c-94df-334914a9e4b6	\N
b58f9916-0c0c-405b-9782-e507e2da2936	\N	auth-username-password-form	2a297db7-66c5-448b-80fc-9d7d0ffecd68	bc9b3caf-c0c8-413c-94df-334914a9e4b6	0	10	f	\N	\N
52663cb0-4471-426a-bdb9-5c12f86ef9f8	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	bc9b3caf-c0c8-413c-94df-334914a9e4b6	1	20	t	9b2f5972-637a-4057-8166-442197397415	\N
36966c96-7627-492f-a51d-4195ffd6bc8e	\N	conditional-user-configured	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9b2f5972-637a-4057-8166-442197397415	0	10	f	\N	\N
7688a004-b3dc-43da-b0a8-9d93571efbd7	\N	auth-otp-form	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9b2f5972-637a-4057-8166-442197397415	0	20	f	\N	\N
123f4ec8-87cd-40d8-a86c-dc9c5def5445	\N	direct-grant-validate-username	2a297db7-66c5-448b-80fc-9d7d0ffecd68	d28818a2-1403-4d16-91e7-7704f01c8cff	0	10	f	\N	\N
6ef01029-fd71-40e4-a46e-51cac56d728e	\N	direct-grant-validate-password	2a297db7-66c5-448b-80fc-9d7d0ffecd68	d28818a2-1403-4d16-91e7-7704f01c8cff	0	20	f	\N	\N
1e6a074b-ce13-4401-8431-e679815dea2a	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	d28818a2-1403-4d16-91e7-7704f01c8cff	1	30	t	94b67500-3ca5-40f0-86d1-050d2d7eea71	\N
fa2543df-9e4e-4c69-93a7-2cc46cca7a82	\N	conditional-user-configured	2a297db7-66c5-448b-80fc-9d7d0ffecd68	94b67500-3ca5-40f0-86d1-050d2d7eea71	0	10	f	\N	\N
22acea65-5975-41c5-91e0-08e6ef6e2f23	\N	direct-grant-validate-otp	2a297db7-66c5-448b-80fc-9d7d0ffecd68	94b67500-3ca5-40f0-86d1-050d2d7eea71	0	20	f	\N	\N
db010374-8bb8-446d-b858-4839ad6938e9	\N	registration-page-form	2a297db7-66c5-448b-80fc-9d7d0ffecd68	a1d75a60-e129-404f-81d4-63f7b24aa0cd	0	10	t	9c8d5349-179d-4274-8678-f46162a11f74	\N
249e10c6-678e-493c-a29a-d7486618b2f1	\N	registration-user-creation	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9c8d5349-179d-4274-8678-f46162a11f74	0	20	f	\N	\N
ef9f5f0e-023c-4072-b71e-bf3acccbb1fd	\N	registration-password-action	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9c8d5349-179d-4274-8678-f46162a11f74	0	50	f	\N	\N
67196564-dde6-42a7-8c19-8efcf6966607	\N	registration-recaptcha-action	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9c8d5349-179d-4274-8678-f46162a11f74	3	60	f	\N	\N
93fee8eb-02fd-4242-94a3-56d2fa6de2e3	\N	registration-terms-and-conditions	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9c8d5349-179d-4274-8678-f46162a11f74	3	70	f	\N	\N
12d835f1-38e8-4f7c-a12d-8d758b3ab922	\N	reset-credentials-choose-user	2a297db7-66c5-448b-80fc-9d7d0ffecd68	4b0718dd-1b4b-4f03-9f47-e795e5f769c4	0	10	f	\N	\N
3a06c256-c02d-421e-965f-99e032a07b15	\N	reset-credential-email	2a297db7-66c5-448b-80fc-9d7d0ffecd68	4b0718dd-1b4b-4f03-9f47-e795e5f769c4	0	20	f	\N	\N
fd08c0cc-b242-42e4-ba34-6477a0f6f6cc	\N	reset-password	2a297db7-66c5-448b-80fc-9d7d0ffecd68	4b0718dd-1b4b-4f03-9f47-e795e5f769c4	0	30	f	\N	\N
6b690c35-dfe8-4819-b32d-4f0d40421c5d	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	4b0718dd-1b4b-4f03-9f47-e795e5f769c4	1	40	t	9378ff83-7ae2-48cb-a633-b96c605f7395	\N
8bb29e5c-5863-4aa7-8371-c019d865a820	\N	conditional-user-configured	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9378ff83-7ae2-48cb-a633-b96c605f7395	0	10	f	\N	\N
6328b8e1-bcf8-4d6d-a276-1590adbe96ae	\N	reset-otp	2a297db7-66c5-448b-80fc-9d7d0ffecd68	9378ff83-7ae2-48cb-a633-b96c605f7395	0	20	f	\N	\N
3a3f7a44-4372-401e-af65-23cbb78d70c8	\N	client-secret	2a297db7-66c5-448b-80fc-9d7d0ffecd68	7529fd0d-9be7-4270-ad81-ad2bd256f674	2	10	f	\N	\N
e703e3f4-704f-4277-92a2-1a9a54f2ea35	\N	client-jwt	2a297db7-66c5-448b-80fc-9d7d0ffecd68	7529fd0d-9be7-4270-ad81-ad2bd256f674	2	20	f	\N	\N
f5f26431-9521-4b69-ade7-7c29b3e74597	\N	client-secret-jwt	2a297db7-66c5-448b-80fc-9d7d0ffecd68	7529fd0d-9be7-4270-ad81-ad2bd256f674	2	30	f	\N	\N
cc955f49-e7d1-4b4f-9b8f-8ea97c4dd11f	\N	client-x509	2a297db7-66c5-448b-80fc-9d7d0ffecd68	7529fd0d-9be7-4270-ad81-ad2bd256f674	2	40	f	\N	\N
c7632359-2e5e-4039-9454-42de3fcfa9b0	\N	idp-review-profile	2a297db7-66c5-448b-80fc-9d7d0ffecd68	71186211-de78-44c6-a937-42cd061ea396	0	10	f	\N	8ac77bf3-cf13-4f22-a8a2-75fcd640ae78
ff30e82d-fd00-4ffa-afd8-3d1c7a2d2101	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	71186211-de78-44c6-a937-42cd061ea396	0	20	t	a19d58a4-46e4-4ade-b6d9-d12e3b5bad48	\N
d5007e1e-34f7-4c16-8bbe-c45a9c4e1374	\N	idp-create-user-if-unique	2a297db7-66c5-448b-80fc-9d7d0ffecd68	a19d58a4-46e4-4ade-b6d9-d12e3b5bad48	2	10	f	\N	48f348aa-1624-4629-8e17-a365e9c28e6b
b5536a54-7801-4c9b-b65b-3bac44bd7130	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	a19d58a4-46e4-4ade-b6d9-d12e3b5bad48	2	20	t	98335e69-3ff4-4871-a059-fc9f5d1e5d02	\N
d0125950-7d2e-4f9c-bad2-aaaeaed07ca6	\N	idp-confirm-link	2a297db7-66c5-448b-80fc-9d7d0ffecd68	98335e69-3ff4-4871-a059-fc9f5d1e5d02	0	10	f	\N	\N
38f8cf78-e559-4d45-8879-d05173c29bef	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	98335e69-3ff4-4871-a059-fc9f5d1e5d02	0	20	t	1d5b7b2b-1005-4a3d-9bb4-388842ea071b	\N
2457f83d-62cf-4a85-a727-fb9ac90e89b3	\N	idp-email-verification	2a297db7-66c5-448b-80fc-9d7d0ffecd68	1d5b7b2b-1005-4a3d-9bb4-388842ea071b	2	10	f	\N	\N
65855183-fc3a-43f2-88a3-fbdc2cd0f739	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	1d5b7b2b-1005-4a3d-9bb4-388842ea071b	2	20	t	52af5be9-a8c5-49e6-856c-f8875b788694	\N
c3852801-2d3e-48c6-a870-f36aee917160	\N	idp-username-password-form	2a297db7-66c5-448b-80fc-9d7d0ffecd68	52af5be9-a8c5-49e6-856c-f8875b788694	0	10	f	\N	\N
91b1802c-13d8-48d1-9db3-5a0eeb40affb	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	52af5be9-a8c5-49e6-856c-f8875b788694	1	20	t	3f77d622-8710-4594-9885-bc5b81cc7eee	\N
eebc1340-868b-497c-904b-d877395679c5	\N	conditional-user-configured	2a297db7-66c5-448b-80fc-9d7d0ffecd68	3f77d622-8710-4594-9885-bc5b81cc7eee	0	10	f	\N	\N
e32c4501-91fa-44b9-b3a8-8f475b08c5fb	\N	auth-otp-form	2a297db7-66c5-448b-80fc-9d7d0ffecd68	3f77d622-8710-4594-9885-bc5b81cc7eee	0	20	f	\N	\N
b5cadd8e-7e2f-408e-bd7f-48fa96b99cf8	\N	http-basic-authenticator	2a297db7-66c5-448b-80fc-9d7d0ffecd68	dc65c215-501b-4f43-8ac5-dacdb80f7716	0	10	f	\N	\N
2de1140f-fbf6-4f80-88ed-01a121f5519e	\N	docker-http-basic-authenticator	2a297db7-66c5-448b-80fc-9d7d0ffecd68	30091d9e-dd78-4b57-a21b-eaac0f392572	0	10	f	\N	\N
6560c12e-a3ac-4b11-bbab-4a5e42c66bab	\N	auth-cookie	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	d3bf310a-9714-4f38-aca5-b09da074d1a3	2	10	f	\N	\N
4556f37b-a7fa-4fa5-9a20-873414f909f1	\N	auth-spnego	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	d3bf310a-9714-4f38-aca5-b09da074d1a3	3	20	f	\N	\N
5d53ed7e-480a-48df-ba8c-adbe6417bf8d	\N	identity-provider-redirector	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	d3bf310a-9714-4f38-aca5-b09da074d1a3	2	25	f	\N	\N
15387e47-959b-4012-b36a-904a127870a5	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	d3bf310a-9714-4f38-aca5-b09da074d1a3	2	30	t	6f6ef937-310d-456c-8ff5-93b44cfccad1	\N
dd154178-3405-4e72-8288-70689c46afa4	\N	auth-username-password-form	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	6f6ef937-310d-456c-8ff5-93b44cfccad1	0	10	f	\N	\N
99c72840-bcec-43aa-98ca-ad3c4789e1d5	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	6f6ef937-310d-456c-8ff5-93b44cfccad1	1	20	t	f9e08679-963e-49e1-9094-de2962abc224	\N
3e1168f3-0845-45fc-92d4-04f1ac47ec7f	\N	conditional-user-configured	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f9e08679-963e-49e1-9094-de2962abc224	0	10	f	\N	\N
c14ae51c-88eb-4a6b-9cca-77615a9c9a31	\N	auth-otp-form	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f9e08679-963e-49e1-9094-de2962abc224	0	20	f	\N	\N
cb8f0a4d-d649-4f30-b7d8-0d30cc8137ab	\N	direct-grant-validate-username	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	119e1b7a-cbc2-40c2-8394-d3223318f660	0	10	f	\N	\N
ace0072a-6775-450f-8c88-c6f70ef6065e	\N	direct-grant-validate-password	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	119e1b7a-cbc2-40c2-8394-d3223318f660	0	20	f	\N	\N
401738a7-0359-4e95-9b3e-bf073d7b3af8	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	119e1b7a-cbc2-40c2-8394-d3223318f660	1	30	t	f9a436b2-dde8-4806-a0e3-2c52e60ba5d8	\N
35a05270-f651-453b-a2da-58dff2033c34	\N	conditional-user-configured	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f9a436b2-dde8-4806-a0e3-2c52e60ba5d8	0	10	f	\N	\N
3c6d0e0f-f974-4b2b-ad6f-ca0acae89450	\N	direct-grant-validate-otp	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f9a436b2-dde8-4806-a0e3-2c52e60ba5d8	0	20	f	\N	\N
4a597164-156e-4c83-9727-fd4a192694d9	\N	registration-page-form	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	7544016c-d236-4a70-911d-059b4d0cf38e	0	10	t	f8a40d73-da91-49ab-a4f8-3b0a5b26b7e6	\N
3f9c5fb4-da45-4a35-b412-88d92fc917d0	\N	registration-user-creation	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f8a40d73-da91-49ab-a4f8-3b0a5b26b7e6	0	20	f	\N	\N
1df83c38-1493-46a8-929a-2768c4009e25	\N	registration-password-action	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f8a40d73-da91-49ab-a4f8-3b0a5b26b7e6	0	50	f	\N	\N
ee3a3069-4757-4466-9d6b-c12f63a31e08	\N	registration-recaptcha-action	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f8a40d73-da91-49ab-a4f8-3b0a5b26b7e6	3	60	f	\N	\N
17eb72bc-4c44-4ef1-9fc5-cf4fb6552111	\N	reset-credentials-choose-user	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	4982259e-b78a-4924-86a2-6ba4518f443c	0	10	f	\N	\N
bdd1b09c-d0d6-4117-8429-5602d523f190	\N	reset-credential-email	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	4982259e-b78a-4924-86a2-6ba4518f443c	0	20	f	\N	\N
23915f57-bf84-4b3c-a4f9-03aa4d6c0f74	\N	reset-password	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	4982259e-b78a-4924-86a2-6ba4518f443c	0	30	f	\N	\N
6d018afb-64c2-4b05-b37a-b67457b40f63	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	4982259e-b78a-4924-86a2-6ba4518f443c	1	40	t	209d1075-76c8-4347-8661-89507834b76c	\N
45e749c5-7c3d-47a8-a5d3-10388a2c1e92	\N	conditional-user-configured	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	209d1075-76c8-4347-8661-89507834b76c	0	10	f	\N	\N
6dd31484-e1a6-4ac4-8364-99587b53e7df	\N	reset-otp	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	209d1075-76c8-4347-8661-89507834b76c	0	20	f	\N	\N
96803949-e49e-43bd-a4f6-869320f9430a	\N	client-secret	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	2ce1f5ef-1f59-4aa0-ac31-86e0b66b0636	2	10	f	\N	\N
d5159181-43d8-4c89-a4d0-bc9c8e1a2b7c	\N	client-jwt	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	2ce1f5ef-1f59-4aa0-ac31-86e0b66b0636	2	20	f	\N	\N
2901ece9-f0ce-4504-9ff3-01a29f9f0301	\N	client-secret-jwt	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	2ce1f5ef-1f59-4aa0-ac31-86e0b66b0636	2	30	f	\N	\N
8411f341-9e26-4efc-8750-6985706c8f8e	\N	client-x509	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	2ce1f5ef-1f59-4aa0-ac31-86e0b66b0636	2	40	f	\N	\N
0a4a97e3-468a-4fef-b9eb-845d81be248f	\N	idp-review-profile	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f3627af4-2b64-4a60-be1d-c93f7cf99814	0	10	f	\N	fc8a16e5-c860-497c-b798-344a44894f48
fe1db907-23b5-413c-81c2-3c62c8c48b4b	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f3627af4-2b64-4a60-be1d-c93f7cf99814	0	20	t	20be611e-85b2-4698-b0a8-638d1f9722da	\N
2119c808-6e44-445a-a404-187c57de5eb1	\N	idp-create-user-if-unique	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	20be611e-85b2-4698-b0a8-638d1f9722da	2	10	f	\N	0a4342ee-5972-4f7a-98a9-7fdee78d819f
76917273-dbb6-40d8-bec6-a9f54ee9a9fe	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	20be611e-85b2-4698-b0a8-638d1f9722da	2	20	t	c35bafbf-e239-4987-88cf-8fafa62161c8	\N
e08605a6-e4e5-4c5a-8165-6de1d8fbe2f5	\N	idp-confirm-link	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	c35bafbf-e239-4987-88cf-8fafa62161c8	0	10	f	\N	\N
a05f7c3a-d346-4073-bfe7-57bc588714b9	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	c35bafbf-e239-4987-88cf-8fafa62161c8	0	20	t	3befc021-04ef-40fa-85b6-c29391e2d4cd	\N
a6495566-02f1-4bbc-8f5e-7e1c6e48a8fe	\N	idp-email-verification	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	3befc021-04ef-40fa-85b6-c29391e2d4cd	2	10	f	\N	\N
ed9b4c6f-6168-4f74-9f7f-118837ffa9a4	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	3befc021-04ef-40fa-85b6-c29391e2d4cd	2	20	t	971079f2-f9b0-433f-a218-dbd195e3952d	\N
431ab1c9-956e-4ead-9956-0912b13641b2	\N	idp-username-password-form	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	971079f2-f9b0-433f-a218-dbd195e3952d	0	10	f	\N	\N
42cfc9da-54f6-4ab8-95ed-4f332f379a33	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	971079f2-f9b0-433f-a218-dbd195e3952d	1	20	t	65baf045-0404-41ed-a32a-47b6f85b6758	\N
03cbf4fd-03de-4ed6-818a-a9063b9e8370	\N	conditional-user-configured	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	65baf045-0404-41ed-a32a-47b6f85b6758	0	10	f	\N	\N
10bb6b50-79a2-4c75-93cf-417ac794121f	\N	auth-otp-form	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	65baf045-0404-41ed-a32a-47b6f85b6758	0	20	f	\N	\N
416be5ee-748a-4e2f-9a9f-e44173f11d15	\N	http-basic-authenticator	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	19b803ab-596f-4dc7-aa89-71b4252fdbad	0	10	f	\N	\N
47af9995-b5c2-4489-98a5-e074d1c30f9d	\N	docker-http-basic-authenticator	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	fbc60ac4-b250-48c9-b2ac-e4cba5407e70	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
9a6cdc73-dcf9-4ba6-bf2f-9643649d55cb	browser	browser based authentication	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	t	t
bc9b3caf-c0c8-413c-94df-334914a9e4b6	forms	Username, password, otp and other auth forms.	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
9b2f5972-637a-4057-8166-442197397415	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
d28818a2-1403-4d16-91e7-7704f01c8cff	direct grant	OpenID Connect Resource Owner Grant	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	t	t
94b67500-3ca5-40f0-86d1-050d2d7eea71	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
a1d75a60-e129-404f-81d4-63f7b24aa0cd	registration	registration flow	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	t	t
9c8d5349-179d-4274-8678-f46162a11f74	registration form	registration form	2a297db7-66c5-448b-80fc-9d7d0ffecd68	form-flow	f	t
4b0718dd-1b4b-4f03-9f47-e795e5f769c4	reset credentials	Reset credentials for a user if they forgot their password or something	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	t	t
9378ff83-7ae2-48cb-a633-b96c605f7395	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
7529fd0d-9be7-4270-ad81-ad2bd256f674	clients	Base authentication for clients	2a297db7-66c5-448b-80fc-9d7d0ffecd68	client-flow	t	t
71186211-de78-44c6-a937-42cd061ea396	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	t	t
a19d58a4-46e4-4ade-b6d9-d12e3b5bad48	User creation or linking	Flow for the existing/non-existing user alternatives	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
98335e69-3ff4-4871-a059-fc9f5d1e5d02	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
1d5b7b2b-1005-4a3d-9bb4-388842ea071b	Account verification options	Method with which to verity the existing account	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
52af5be9-a8c5-49e6-856c-f8875b788694	Verify Existing Account by Re-authentication	Reauthentication of existing account	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
3f77d622-8710-4594-9885-bc5b81cc7eee	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	f	t
dc65c215-501b-4f43-8ac5-dacdb80f7716	saml ecp	SAML ECP Profile Authentication Flow	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	t	t
30091d9e-dd78-4b57-a21b-eaac0f392572	docker auth	Used by Docker clients to authenticate against the IDP	2a297db7-66c5-448b-80fc-9d7d0ffecd68	basic-flow	t	t
d3bf310a-9714-4f38-aca5-b09da074d1a3	browser	browser based authentication	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	t	t
6f6ef937-310d-456c-8ff5-93b44cfccad1	forms	Username, password, otp and other auth forms.	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
f9e08679-963e-49e1-9094-de2962abc224	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
119e1b7a-cbc2-40c2-8394-d3223318f660	direct grant	OpenID Connect Resource Owner Grant	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	t	t
f9a436b2-dde8-4806-a0e3-2c52e60ba5d8	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
7544016c-d236-4a70-911d-059b4d0cf38e	registration	registration flow	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	t	t
f8a40d73-da91-49ab-a4f8-3b0a5b26b7e6	registration form	registration form	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	form-flow	f	t
4982259e-b78a-4924-86a2-6ba4518f443c	reset credentials	Reset credentials for a user if they forgot their password or something	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	t	t
209d1075-76c8-4347-8661-89507834b76c	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
2ce1f5ef-1f59-4aa0-ac31-86e0b66b0636	clients	Base authentication for clients	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	client-flow	t	t
f3627af4-2b64-4a60-be1d-c93f7cf99814	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	t	t
20be611e-85b2-4698-b0a8-638d1f9722da	User creation or linking	Flow for the existing/non-existing user alternatives	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
c35bafbf-e239-4987-88cf-8fafa62161c8	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
3befc021-04ef-40fa-85b6-c29391e2d4cd	Account verification options	Method with which to verity the existing account	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
971079f2-f9b0-433f-a218-dbd195e3952d	Verify Existing Account by Re-authentication	Reauthentication of existing account	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
65baf045-0404-41ed-a32a-47b6f85b6758	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	f	t
19b803ab-596f-4dc7-aa89-71b4252fdbad	saml ecp	SAML ECP Profile Authentication Flow	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	t	t
fbc60ac4-b250-48c9-b2ac-e4cba5407e70	docker auth	Used by Docker clients to authenticate against the IDP	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
8ac77bf3-cf13-4f22-a8a2-75fcd640ae78	review profile config	2a297db7-66c5-448b-80fc-9d7d0ffecd68
48f348aa-1624-4629-8e17-a365e9c28e6b	create unique user config	2a297db7-66c5-448b-80fc-9d7d0ffecd68
fc8a16e5-c860-497c-b798-344a44894f48	review profile config	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c
0a4342ee-5972-4f7a-98a9-7fdee78d819f	create unique user config	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
48f348aa-1624-4629-8e17-a365e9c28e6b	false	require.password.update.after.registration
8ac77bf3-cf13-4f22-a8a2-75fcd640ae78	missing	update.profile.on.first.login
0a4342ee-5972-4f7a-98a9-7fdee78d819f	false	require.password.update.after.registration
fc8a16e5-c860-497c-b798-344a44894f48	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
fa100695-6a07-4106-8855-8672a32a12ef	t	f	master-realm	0	f	\N	\N	t	\N	f	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	2a297db7-66c5-448b-80fc-9d7d0ffecd68	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e42f0f38-dd87-4140-999e-d9af160f6ef0	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	2a297db7-66c5-448b-80fc-9d7d0ffecd68	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
98e1f74a-f741-49b8-a6fe-471faeacbf86	t	f	broker	0	f	\N	\N	t	\N	f	2a297db7-66c5-448b-80fc-9d7d0ffecd68	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
0fbdf72f-3d4e-48f7-8a22-d4497600516d	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	2a297db7-66c5-448b-80fc-9d7d0ffecd68	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	t	f	admin-cli	0	t	\N	\N	f	\N	f	2a297db7-66c5-448b-80fc-9d7d0ffecd68	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
cc97d42e-a486-4687-8259-8121218c6a01	t	f	beatbuddy-realm	0	f	\N	\N	t	\N	f	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N	0	f	f	beatbuddy Realm	f	client-secret	\N	\N	\N	t	f	f	f
eecd06c1-cff6-4883-bd05-1e4fefca991c	t	f	realm-management	0	f	\N	\N	t	\N	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	f	account	0	t	\N	/realms/beatbuddy/account/	f	\N	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
43bbaeba-5eab-49be-b8c4-c011637e5b2c	t	f	account-console	0	t	\N	/realms/beatbuddy/account/	f	\N	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a3a878c5-eec3-42c2-a568-3828a8fcfc02	t	f	broker	0	f	\N	\N	t	\N	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
644da31f-f3cb-4452-90d8-07489751327c	t	f	security-admin-console	0	t	\N	/admin/beatbuddy/console/	f	\N	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
473116bd-9658-4ab3-904d-1c9602ea55d9	t	f	admin-cli	0	t	\N	\N	f	\N	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
d1187be3-8efe-4de2-aa98-be80379464e0	t	t	bbapi	0	f	SG01wIpg7l8FB4wxFVFVcFbfmJ8Wy7To		f		f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	-1	t	f	Beat Buddy API	t	client-secret			\N	f	f	f	f
7c0a850a-6743-4cee-ac92-a5159f7da291	t	t	bbweb	0	t	\N	https://beatbuddy.io.vn	f		f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	-1	t	f	Beat Buddy web application	f	client-secret	https://beatbuddy.io.vn		\N	t	f	f	t
091f5e08-80d8-4221-a8e0-e401d5fffca1	t	t	web	0	t	\N	https://beatbuddy.io.vn	f	https://beatbuddy.io.vn	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	-1	t	f	Beat Buddy - Web Application	f	client-secret	https://beatbuddy.io.vn		\N	t	f	f	f
653b5484-afde-49bc-b7ef-30ad0e436b9e	t	t	webconfidential	0	f	z5EDrLy7UfiYOBF3d8OVRs0cJZev6HW2		f		f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	-1	t	f	Web Confidential	t	client-secret			\N	f	f	f	f
61752460-3001-450d-b7ee-ff9b6d1aeae5	t	t	kmashopapp	0	f	oitIHnjJ9ZNhvvfwmz8nRXpKfrp8E1mM		f		f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	-1	t	f		t	client-secret			\N	f	f	f	f
50bed23d-759e-487d-b1ea-6ac18dc59811	t	t	beatbuddy	0	f	g3cQyG74X192BTW4bsr9jfV0kUTGnmG6		f		f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	openid-connect	-1	t	t	Beat Buddy	t	client-secret			\N	f	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	post.logout.redirect.uris	+
e42f0f38-dd87-4140-999e-d9af160f6ef0	post.logout.redirect.uris	+
e42f0f38-dd87-4140-999e-d9af160f6ef0	pkce.code.challenge.method	S256
0fbdf72f-3d4e-48f7-8a22-d4497600516d	post.logout.redirect.uris	+
0fbdf72f-3d4e-48f7-8a22-d4497600516d	pkce.code.challenge.method	S256
959a6f97-3f51-459e-928a-1f8d01ffb9ea	post.logout.redirect.uris	+
43bbaeba-5eab-49be-b8c4-c011637e5b2c	post.logout.redirect.uris	+
43bbaeba-5eab-49be-b8c4-c011637e5b2c	pkce.code.challenge.method	S256
644da31f-f3cb-4452-90d8-07489751327c	post.logout.redirect.uris	+
644da31f-f3cb-4452-90d8-07489751327c	pkce.code.challenge.method	S256
7c0a850a-6743-4cee-ac92-a5159f7da291	oauth2.device.authorization.grant.enabled	false
7c0a850a-6743-4cee-ac92-a5159f7da291	oidc.ciba.grant.enabled	false
7c0a850a-6743-4cee-ac92-a5159f7da291	post.logout.redirect.uris	+
7c0a850a-6743-4cee-ac92-a5159f7da291	backchannel.logout.session.required	true
7c0a850a-6743-4cee-ac92-a5159f7da291	backchannel.logout.revoke.offline.tokens	false
7c0a850a-6743-4cee-ac92-a5159f7da291	login_theme	keycloak
7c0a850a-6743-4cee-ac92-a5159f7da291	display.on.consent.screen	false
d1187be3-8efe-4de2-aa98-be80379464e0	client.secret.creation.time	1709230739
d1187be3-8efe-4de2-aa98-be80379464e0	oauth2.device.authorization.grant.enabled	false
d1187be3-8efe-4de2-aa98-be80379464e0	oidc.ciba.grant.enabled	false
d1187be3-8efe-4de2-aa98-be80379464e0	backchannel.logout.session.required	true
d1187be3-8efe-4de2-aa98-be80379464e0	backchannel.logout.revoke.offline.tokens	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	oauth2.device.authorization.grant.enabled	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	oidc.ciba.grant.enabled	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	post.logout.redirect.uris	/*
091f5e08-80d8-4221-a8e0-e401d5fffca1	backchannel.logout.session.required	true
091f5e08-80d8-4221-a8e0-e401d5fffca1	backchannel.logout.revoke.offline.tokens	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	display.on.consent.screen	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	login_theme	keycloak
091f5e08-80d8-4221-a8e0-e401d5fffca1	use.refresh.tokens	true
091f5e08-80d8-4221-a8e0-e401d5fffca1	client_credentials.use_refresh_token	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	token.response.type.bearer.lower-case	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	tls.client.certificate.bound.access.tokens	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	require.pushed.authorization.requests	false
091f5e08-80d8-4221-a8e0-e401d5fffca1	acr.loa.map	{}
091f5e08-80d8-4221-a8e0-e401d5fffca1	access.token.lifespan	86400
61752460-3001-450d-b7ee-ff9b6d1aeae5	client.secret.creation.time	1712215717
61752460-3001-450d-b7ee-ff9b6d1aeae5	oauth2.device.authorization.grant.enabled	false
61752460-3001-450d-b7ee-ff9b6d1aeae5	oidc.ciba.grant.enabled	false
61752460-3001-450d-b7ee-ff9b6d1aeae5	backchannel.logout.session.required	true
61752460-3001-450d-b7ee-ff9b6d1aeae5	backchannel.logout.revoke.offline.tokens	false
50bed23d-759e-487d-b1ea-6ac18dc59811	client.secret.creation.time	1712606102
50bed23d-759e-487d-b1ea-6ac18dc59811	oauth2.device.authorization.grant.enabled	false
50bed23d-759e-487d-b1ea-6ac18dc59811	oidc.ciba.grant.enabled	false
50bed23d-759e-487d-b1ea-6ac18dc59811	backchannel.logout.session.required	true
50bed23d-759e-487d-b1ea-6ac18dc59811	backchannel.logout.revoke.offline.tokens	false
50bed23d-759e-487d-b1ea-6ac18dc59811	login_theme	keycloak
50bed23d-759e-487d-b1ea-6ac18dc59811	display.on.consent.screen	true
091f5e08-80d8-4221-a8e0-e401d5fffca1	client.secret.creation.time	1712735191
653b5484-afde-49bc-b7ef-30ad0e436b9e	client.secret.creation.time	1712735557
653b5484-afde-49bc-b7ef-30ad0e436b9e	oauth2.device.authorization.grant.enabled	false
653b5484-afde-49bc-b7ef-30ad0e436b9e	oidc.ciba.grant.enabled	false
653b5484-afde-49bc-b7ef-30ad0e436b9e	backchannel.logout.session.required	true
653b5484-afde-49bc-b7ef-30ad0e436b9e	backchannel.logout.revoke.offline.tokens	false
653b5484-afde-49bc-b7ef-30ad0e436b9e	display.on.consent.screen	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
c8a33997-8823-4a02-b1ec-b4e8cf444785	offline_access	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect built-in scope: offline_access	openid-connect
fed6f2c5-d144-414c-89e3-4a1564d44fb4	role_list	2a297db7-66c5-448b-80fc-9d7d0ffecd68	SAML role list	saml
dbc56f8d-7bfc-4add-aa73-c6684541fcf4	profile	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect built-in scope: profile	openid-connect
33623af0-f6fb-456c-9ac8-fefec09a5975	email	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect built-in scope: email	openid-connect
05007875-b461-4fb4-a857-e98f323ad7db	address	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect built-in scope: address	openid-connect
42968e1f-162c-4070-a14e-ab26a2fdca10	phone	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect built-in scope: phone	openid-connect
a8cfd613-c92a-4985-92e0-8263b445d3d7	roles	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect scope for add user roles to the access token	openid-connect
776e9199-fc33-436e-b47a-02c26f88c84e	web-origins	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect scope for add allowed web origins to the access token	openid-connect
d8d2107d-35cc-48ef-95bb-66c9cb49df97	microprofile-jwt	2a297db7-66c5-448b-80fc-9d7d0ffecd68	Microprofile - JWT built-in scope	openid-connect
068aeb71-d5ea-452f-8d6a-b4a1aca0b784	acr	2a297db7-66c5-448b-80fc-9d7d0ffecd68	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
3b557e1f-a258-4183-9a88-57af50977fda	offline_access	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect built-in scope: offline_access	openid-connect
47679dcf-1005-4b40-a1da-8569d08d95dc	role_list	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	SAML role list	saml
1a18fc4e-219a-49b5-aefa-ed1085eb04ea	profile	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect built-in scope: profile	openid-connect
af365cb4-27ce-492e-8ce7-d78dc7fab611	email	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect built-in scope: email	openid-connect
d28a310c-1f68-4a35-9669-6a30361b3cf8	address	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect built-in scope: address	openid-connect
e2427baf-a533-4c32-8902-fd7fa554bd29	phone	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect built-in scope: phone	openid-connect
bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	roles	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect scope for add user roles to the access token	openid-connect
e0648e33-f320-41bc-abaa-1fd40d2c588d	web-origins	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect scope for add allowed web origins to the access token	openid-connect
2375f6b6-ba7e-4dfb-9b2a-f74033043de8	microprofile-jwt	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	Microprofile - JWT built-in scope	openid-connect
e75ccea0-a73c-4548-ade2-b600d688bd3f	acr	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
c8a33997-8823-4a02-b1ec-b4e8cf444785	true	display.on.consent.screen
c8a33997-8823-4a02-b1ec-b4e8cf444785	${offlineAccessScopeConsentText}	consent.screen.text
fed6f2c5-d144-414c-89e3-4a1564d44fb4	true	display.on.consent.screen
fed6f2c5-d144-414c-89e3-4a1564d44fb4	${samlRoleListScopeConsentText}	consent.screen.text
dbc56f8d-7bfc-4add-aa73-c6684541fcf4	true	display.on.consent.screen
dbc56f8d-7bfc-4add-aa73-c6684541fcf4	${profileScopeConsentText}	consent.screen.text
dbc56f8d-7bfc-4add-aa73-c6684541fcf4	true	include.in.token.scope
33623af0-f6fb-456c-9ac8-fefec09a5975	true	display.on.consent.screen
33623af0-f6fb-456c-9ac8-fefec09a5975	${emailScopeConsentText}	consent.screen.text
33623af0-f6fb-456c-9ac8-fefec09a5975	true	include.in.token.scope
05007875-b461-4fb4-a857-e98f323ad7db	true	display.on.consent.screen
05007875-b461-4fb4-a857-e98f323ad7db	${addressScopeConsentText}	consent.screen.text
05007875-b461-4fb4-a857-e98f323ad7db	true	include.in.token.scope
42968e1f-162c-4070-a14e-ab26a2fdca10	true	display.on.consent.screen
42968e1f-162c-4070-a14e-ab26a2fdca10	${phoneScopeConsentText}	consent.screen.text
42968e1f-162c-4070-a14e-ab26a2fdca10	true	include.in.token.scope
a8cfd613-c92a-4985-92e0-8263b445d3d7	true	display.on.consent.screen
a8cfd613-c92a-4985-92e0-8263b445d3d7	${rolesScopeConsentText}	consent.screen.text
a8cfd613-c92a-4985-92e0-8263b445d3d7	false	include.in.token.scope
776e9199-fc33-436e-b47a-02c26f88c84e	false	display.on.consent.screen
776e9199-fc33-436e-b47a-02c26f88c84e		consent.screen.text
776e9199-fc33-436e-b47a-02c26f88c84e	false	include.in.token.scope
d8d2107d-35cc-48ef-95bb-66c9cb49df97	false	display.on.consent.screen
d8d2107d-35cc-48ef-95bb-66c9cb49df97	true	include.in.token.scope
068aeb71-d5ea-452f-8d6a-b4a1aca0b784	false	display.on.consent.screen
068aeb71-d5ea-452f-8d6a-b4a1aca0b784	false	include.in.token.scope
3b557e1f-a258-4183-9a88-57af50977fda	true	display.on.consent.screen
3b557e1f-a258-4183-9a88-57af50977fda	${offlineAccessScopeConsentText}	consent.screen.text
47679dcf-1005-4b40-a1da-8569d08d95dc	true	display.on.consent.screen
47679dcf-1005-4b40-a1da-8569d08d95dc	${samlRoleListScopeConsentText}	consent.screen.text
1a18fc4e-219a-49b5-aefa-ed1085eb04ea	true	display.on.consent.screen
1a18fc4e-219a-49b5-aefa-ed1085eb04ea	${profileScopeConsentText}	consent.screen.text
1a18fc4e-219a-49b5-aefa-ed1085eb04ea	true	include.in.token.scope
af365cb4-27ce-492e-8ce7-d78dc7fab611	true	display.on.consent.screen
af365cb4-27ce-492e-8ce7-d78dc7fab611	${emailScopeConsentText}	consent.screen.text
af365cb4-27ce-492e-8ce7-d78dc7fab611	true	include.in.token.scope
d28a310c-1f68-4a35-9669-6a30361b3cf8	true	display.on.consent.screen
d28a310c-1f68-4a35-9669-6a30361b3cf8	${addressScopeConsentText}	consent.screen.text
d28a310c-1f68-4a35-9669-6a30361b3cf8	true	include.in.token.scope
e2427baf-a533-4c32-8902-fd7fa554bd29	true	display.on.consent.screen
e2427baf-a533-4c32-8902-fd7fa554bd29	${phoneScopeConsentText}	consent.screen.text
e2427baf-a533-4c32-8902-fd7fa554bd29	true	include.in.token.scope
bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	true	display.on.consent.screen
bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	${rolesScopeConsentText}	consent.screen.text
bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	false	include.in.token.scope
e0648e33-f320-41bc-abaa-1fd40d2c588d	false	display.on.consent.screen
e0648e33-f320-41bc-abaa-1fd40d2c588d		consent.screen.text
e0648e33-f320-41bc-abaa-1fd40d2c588d	false	include.in.token.scope
2375f6b6-ba7e-4dfb-9b2a-f74033043de8	false	display.on.consent.screen
2375f6b6-ba7e-4dfb-9b2a-f74033043de8	true	include.in.token.scope
e75ccea0-a73c-4548-ade2-b600d688bd3f	false	display.on.consent.screen
e75ccea0-a73c-4548-ade2-b600d688bd3f	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	33623af0-f6fb-456c-9ac8-fefec09a5975	t
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	dbc56f8d-7bfc-4add-aa73-c6684541fcf4	t
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	068aeb71-d5ea-452f-8d6a-b4a1aca0b784	t
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	776e9199-fc33-436e-b47a-02c26f88c84e	t
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	a8cfd613-c92a-4985-92e0-8263b445d3d7	t
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	c8a33997-8823-4a02-b1ec-b4e8cf444785	f
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	d8d2107d-35cc-48ef-95bb-66c9cb49df97	f
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	05007875-b461-4fb4-a857-e98f323ad7db	f
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	42968e1f-162c-4070-a14e-ab26a2fdca10	f
e42f0f38-dd87-4140-999e-d9af160f6ef0	33623af0-f6fb-456c-9ac8-fefec09a5975	t
e42f0f38-dd87-4140-999e-d9af160f6ef0	dbc56f8d-7bfc-4add-aa73-c6684541fcf4	t
e42f0f38-dd87-4140-999e-d9af160f6ef0	068aeb71-d5ea-452f-8d6a-b4a1aca0b784	t
e42f0f38-dd87-4140-999e-d9af160f6ef0	776e9199-fc33-436e-b47a-02c26f88c84e	t
e42f0f38-dd87-4140-999e-d9af160f6ef0	a8cfd613-c92a-4985-92e0-8263b445d3d7	t
e42f0f38-dd87-4140-999e-d9af160f6ef0	c8a33997-8823-4a02-b1ec-b4e8cf444785	f
e42f0f38-dd87-4140-999e-d9af160f6ef0	d8d2107d-35cc-48ef-95bb-66c9cb49df97	f
e42f0f38-dd87-4140-999e-d9af160f6ef0	05007875-b461-4fb4-a857-e98f323ad7db	f
e42f0f38-dd87-4140-999e-d9af160f6ef0	42968e1f-162c-4070-a14e-ab26a2fdca10	f
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	33623af0-f6fb-456c-9ac8-fefec09a5975	t
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	dbc56f8d-7bfc-4add-aa73-c6684541fcf4	t
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	068aeb71-d5ea-452f-8d6a-b4a1aca0b784	t
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	776e9199-fc33-436e-b47a-02c26f88c84e	t
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	a8cfd613-c92a-4985-92e0-8263b445d3d7	t
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	c8a33997-8823-4a02-b1ec-b4e8cf444785	f
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	d8d2107d-35cc-48ef-95bb-66c9cb49df97	f
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	05007875-b461-4fb4-a857-e98f323ad7db	f
6f64a3c3-7c1d-4ab0-a01b-b3ef6203559d	42968e1f-162c-4070-a14e-ab26a2fdca10	f
98e1f74a-f741-49b8-a6fe-471faeacbf86	33623af0-f6fb-456c-9ac8-fefec09a5975	t
98e1f74a-f741-49b8-a6fe-471faeacbf86	dbc56f8d-7bfc-4add-aa73-c6684541fcf4	t
98e1f74a-f741-49b8-a6fe-471faeacbf86	068aeb71-d5ea-452f-8d6a-b4a1aca0b784	t
98e1f74a-f741-49b8-a6fe-471faeacbf86	776e9199-fc33-436e-b47a-02c26f88c84e	t
98e1f74a-f741-49b8-a6fe-471faeacbf86	a8cfd613-c92a-4985-92e0-8263b445d3d7	t
98e1f74a-f741-49b8-a6fe-471faeacbf86	c8a33997-8823-4a02-b1ec-b4e8cf444785	f
98e1f74a-f741-49b8-a6fe-471faeacbf86	d8d2107d-35cc-48ef-95bb-66c9cb49df97	f
98e1f74a-f741-49b8-a6fe-471faeacbf86	05007875-b461-4fb4-a857-e98f323ad7db	f
98e1f74a-f741-49b8-a6fe-471faeacbf86	42968e1f-162c-4070-a14e-ab26a2fdca10	f
fa100695-6a07-4106-8855-8672a32a12ef	33623af0-f6fb-456c-9ac8-fefec09a5975	t
fa100695-6a07-4106-8855-8672a32a12ef	dbc56f8d-7bfc-4add-aa73-c6684541fcf4	t
fa100695-6a07-4106-8855-8672a32a12ef	068aeb71-d5ea-452f-8d6a-b4a1aca0b784	t
fa100695-6a07-4106-8855-8672a32a12ef	776e9199-fc33-436e-b47a-02c26f88c84e	t
fa100695-6a07-4106-8855-8672a32a12ef	a8cfd613-c92a-4985-92e0-8263b445d3d7	t
fa100695-6a07-4106-8855-8672a32a12ef	c8a33997-8823-4a02-b1ec-b4e8cf444785	f
fa100695-6a07-4106-8855-8672a32a12ef	d8d2107d-35cc-48ef-95bb-66c9cb49df97	f
fa100695-6a07-4106-8855-8672a32a12ef	05007875-b461-4fb4-a857-e98f323ad7db	f
fa100695-6a07-4106-8855-8672a32a12ef	42968e1f-162c-4070-a14e-ab26a2fdca10	f
0fbdf72f-3d4e-48f7-8a22-d4497600516d	33623af0-f6fb-456c-9ac8-fefec09a5975	t
0fbdf72f-3d4e-48f7-8a22-d4497600516d	dbc56f8d-7bfc-4add-aa73-c6684541fcf4	t
0fbdf72f-3d4e-48f7-8a22-d4497600516d	068aeb71-d5ea-452f-8d6a-b4a1aca0b784	t
0fbdf72f-3d4e-48f7-8a22-d4497600516d	776e9199-fc33-436e-b47a-02c26f88c84e	t
0fbdf72f-3d4e-48f7-8a22-d4497600516d	a8cfd613-c92a-4985-92e0-8263b445d3d7	t
0fbdf72f-3d4e-48f7-8a22-d4497600516d	c8a33997-8823-4a02-b1ec-b4e8cf444785	f
0fbdf72f-3d4e-48f7-8a22-d4497600516d	d8d2107d-35cc-48ef-95bb-66c9cb49df97	f
0fbdf72f-3d4e-48f7-8a22-d4497600516d	05007875-b461-4fb4-a857-e98f323ad7db	f
0fbdf72f-3d4e-48f7-8a22-d4497600516d	42968e1f-162c-4070-a14e-ab26a2fdca10	f
959a6f97-3f51-459e-928a-1f8d01ffb9ea	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
959a6f97-3f51-459e-928a-1f8d01ffb9ea	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
959a6f97-3f51-459e-928a-1f8d01ffb9ea	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
959a6f97-3f51-459e-928a-1f8d01ffb9ea	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
959a6f97-3f51-459e-928a-1f8d01ffb9ea	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
959a6f97-3f51-459e-928a-1f8d01ffb9ea	3b557e1f-a258-4183-9a88-57af50977fda	f
959a6f97-3f51-459e-928a-1f8d01ffb9ea	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
959a6f97-3f51-459e-928a-1f8d01ffb9ea	e2427baf-a533-4c32-8902-fd7fa554bd29	f
959a6f97-3f51-459e-928a-1f8d01ffb9ea	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
43bbaeba-5eab-49be-b8c4-c011637e5b2c	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
43bbaeba-5eab-49be-b8c4-c011637e5b2c	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
43bbaeba-5eab-49be-b8c4-c011637e5b2c	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
43bbaeba-5eab-49be-b8c4-c011637e5b2c	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
43bbaeba-5eab-49be-b8c4-c011637e5b2c	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
43bbaeba-5eab-49be-b8c4-c011637e5b2c	3b557e1f-a258-4183-9a88-57af50977fda	f
43bbaeba-5eab-49be-b8c4-c011637e5b2c	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
43bbaeba-5eab-49be-b8c4-c011637e5b2c	e2427baf-a533-4c32-8902-fd7fa554bd29	f
43bbaeba-5eab-49be-b8c4-c011637e5b2c	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
473116bd-9658-4ab3-904d-1c9602ea55d9	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
473116bd-9658-4ab3-904d-1c9602ea55d9	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
473116bd-9658-4ab3-904d-1c9602ea55d9	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
473116bd-9658-4ab3-904d-1c9602ea55d9	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
473116bd-9658-4ab3-904d-1c9602ea55d9	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
473116bd-9658-4ab3-904d-1c9602ea55d9	3b557e1f-a258-4183-9a88-57af50977fda	f
473116bd-9658-4ab3-904d-1c9602ea55d9	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
473116bd-9658-4ab3-904d-1c9602ea55d9	e2427baf-a533-4c32-8902-fd7fa554bd29	f
473116bd-9658-4ab3-904d-1c9602ea55d9	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
a3a878c5-eec3-42c2-a568-3828a8fcfc02	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
a3a878c5-eec3-42c2-a568-3828a8fcfc02	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
a3a878c5-eec3-42c2-a568-3828a8fcfc02	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
a3a878c5-eec3-42c2-a568-3828a8fcfc02	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
a3a878c5-eec3-42c2-a568-3828a8fcfc02	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
a3a878c5-eec3-42c2-a568-3828a8fcfc02	3b557e1f-a258-4183-9a88-57af50977fda	f
a3a878c5-eec3-42c2-a568-3828a8fcfc02	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
a3a878c5-eec3-42c2-a568-3828a8fcfc02	e2427baf-a533-4c32-8902-fd7fa554bd29	f
a3a878c5-eec3-42c2-a568-3828a8fcfc02	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
eecd06c1-cff6-4883-bd05-1e4fefca991c	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
eecd06c1-cff6-4883-bd05-1e4fefca991c	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
eecd06c1-cff6-4883-bd05-1e4fefca991c	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
eecd06c1-cff6-4883-bd05-1e4fefca991c	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
eecd06c1-cff6-4883-bd05-1e4fefca991c	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
eecd06c1-cff6-4883-bd05-1e4fefca991c	3b557e1f-a258-4183-9a88-57af50977fda	f
eecd06c1-cff6-4883-bd05-1e4fefca991c	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
eecd06c1-cff6-4883-bd05-1e4fefca991c	e2427baf-a533-4c32-8902-fd7fa554bd29	f
eecd06c1-cff6-4883-bd05-1e4fefca991c	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
644da31f-f3cb-4452-90d8-07489751327c	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
644da31f-f3cb-4452-90d8-07489751327c	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
644da31f-f3cb-4452-90d8-07489751327c	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
644da31f-f3cb-4452-90d8-07489751327c	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
644da31f-f3cb-4452-90d8-07489751327c	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
644da31f-f3cb-4452-90d8-07489751327c	3b557e1f-a258-4183-9a88-57af50977fda	f
644da31f-f3cb-4452-90d8-07489751327c	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
644da31f-f3cb-4452-90d8-07489751327c	e2427baf-a533-4c32-8902-fd7fa554bd29	f
644da31f-f3cb-4452-90d8-07489751327c	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
7c0a850a-6743-4cee-ac92-a5159f7da291	3b557e1f-a258-4183-9a88-57af50977fda	f
7c0a850a-6743-4cee-ac92-a5159f7da291	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
d1187be3-8efe-4de2-aa98-be80379464e0	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
d1187be3-8efe-4de2-aa98-be80379464e0	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
d1187be3-8efe-4de2-aa98-be80379464e0	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
d1187be3-8efe-4de2-aa98-be80379464e0	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
d1187be3-8efe-4de2-aa98-be80379464e0	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
d1187be3-8efe-4de2-aa98-be80379464e0	3b557e1f-a258-4183-9a88-57af50977fda	f
d1187be3-8efe-4de2-aa98-be80379464e0	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
d1187be3-8efe-4de2-aa98-be80379464e0	e2427baf-a533-4c32-8902-fd7fa554bd29	f
d1187be3-8efe-4de2-aa98-be80379464e0	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
091f5e08-80d8-4221-a8e0-e401d5fffca1	3b557e1f-a258-4183-9a88-57af50977fda	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	e2427baf-a533-4c32-8902-fd7fa554bd29	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
61752460-3001-450d-b7ee-ff9b6d1aeae5	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
61752460-3001-450d-b7ee-ff9b6d1aeae5	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
61752460-3001-450d-b7ee-ff9b6d1aeae5	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
61752460-3001-450d-b7ee-ff9b6d1aeae5	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
61752460-3001-450d-b7ee-ff9b6d1aeae5	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
61752460-3001-450d-b7ee-ff9b6d1aeae5	3b557e1f-a258-4183-9a88-57af50977fda	f
61752460-3001-450d-b7ee-ff9b6d1aeae5	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
61752460-3001-450d-b7ee-ff9b6d1aeae5	e2427baf-a533-4c32-8902-fd7fa554bd29	f
61752460-3001-450d-b7ee-ff9b6d1aeae5	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	e75ccea0-a73c-4548-ade2-b600d688bd3f	f
091f5e08-80d8-4221-a8e0-e401d5fffca1	e0648e33-f320-41bc-abaa-1fd40d2c588d	f
7c0a850a-6743-4cee-ac92-a5159f7da291	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
7c0a850a-6743-4cee-ac92-a5159f7da291	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
7c0a850a-6743-4cee-ac92-a5159f7da291	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
7c0a850a-6743-4cee-ac92-a5159f7da291	e2427baf-a533-4c32-8902-fd7fa554bd29	t
7c0a850a-6743-4cee-ac92-a5159f7da291	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
7c0a850a-6743-4cee-ac92-a5159f7da291	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
7c0a850a-6743-4cee-ac92-a5159f7da291	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	t
50bed23d-759e-487d-b1ea-6ac18dc59811	3b557e1f-a258-4183-9a88-57af50977fda	f
50bed23d-759e-487d-b1ea-6ac18dc59811	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
50bed23d-759e-487d-b1ea-6ac18dc59811	e2427baf-a533-4c32-8902-fd7fa554bd29	f
50bed23d-759e-487d-b1ea-6ac18dc59811	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
50bed23d-759e-487d-b1ea-6ac18dc59811	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	f
50bed23d-759e-487d-b1ea-6ac18dc59811	af365cb4-27ce-492e-8ce7-d78dc7fab611	f
50bed23d-759e-487d-b1ea-6ac18dc59811	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
50bed23d-759e-487d-b1ea-6ac18dc59811	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
50bed23d-759e-487d-b1ea-6ac18dc59811	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
653b5484-afde-49bc-b7ef-30ad0e436b9e	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
653b5484-afde-49bc-b7ef-30ad0e436b9e	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
653b5484-afde-49bc-b7ef-30ad0e436b9e	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
653b5484-afde-49bc-b7ef-30ad0e436b9e	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
653b5484-afde-49bc-b7ef-30ad0e436b9e	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
653b5484-afde-49bc-b7ef-30ad0e436b9e	3b557e1f-a258-4183-9a88-57af50977fda	f
653b5484-afde-49bc-b7ef-30ad0e436b9e	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
653b5484-afde-49bc-b7ef-30ad0e436b9e	e2427baf-a533-4c32-8902-fd7fa554bd29	f
653b5484-afde-49bc-b7ef-30ad0e436b9e	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
c8a33997-8823-4a02-b1ec-b4e8cf444785	6db8c1f0-503e-4f08-9480-447e4ec7de33
3b557e1f-a258-4183-9a88-57af50977fda	f48b3cd7-fd1a-4273-b3a6-2f6615df7b95
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
7b21ba3c-702a-4acf-a32f-9d6b500a0a34	Trusted Hosts	2a297db7-66c5-448b-80fc-9d7d0ffecd68	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	anonymous
4faa615e-1961-4796-8ef3-9449aba4539d	Consent Required	2a297db7-66c5-448b-80fc-9d7d0ffecd68	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	anonymous
db04046a-e9c1-4a69-b91f-6ddceeba85af	Full Scope Disabled	2a297db7-66c5-448b-80fc-9d7d0ffecd68	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	anonymous
f8689100-455a-4071-a23d-17a71a46d9e0	Max Clients Limit	2a297db7-66c5-448b-80fc-9d7d0ffecd68	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	anonymous
ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	Allowed Protocol Mapper Types	2a297db7-66c5-448b-80fc-9d7d0ffecd68	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	anonymous
716524d6-c4fa-470c-beca-8f06312e041b	Allowed Client Scopes	2a297db7-66c5-448b-80fc-9d7d0ffecd68	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	anonymous
34530f1e-1be9-480c-a4dd-80e037c1a92e	Allowed Protocol Mapper Types	2a297db7-66c5-448b-80fc-9d7d0ffecd68	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	authenticated
5fbd6391-5e8f-41ac-bf94-a6f177da52ab	Allowed Client Scopes	2a297db7-66c5-448b-80fc-9d7d0ffecd68	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	authenticated
61baac98-7035-439b-a15e-d5a36ff8c31b	rsa-generated	2a297db7-66c5-448b-80fc-9d7d0ffecd68	rsa-generated	org.keycloak.keys.KeyProvider	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N
7c5e5447-67ce-42d0-a887-f75afdfae6f0	rsa-enc-generated	2a297db7-66c5-448b-80fc-9d7d0ffecd68	rsa-enc-generated	org.keycloak.keys.KeyProvider	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N
10f3f8ac-9615-49d8-861c-11cfb9ed8e06	hmac-generated	2a297db7-66c5-448b-80fc-9d7d0ffecd68	hmac-generated	org.keycloak.keys.KeyProvider	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N
f66f119c-94a4-404d-ad9e-9987ead7ae75	aes-generated	2a297db7-66c5-448b-80fc-9d7d0ffecd68	aes-generated	org.keycloak.keys.KeyProvider	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N
04dd517c-3270-463a-8875-54c98fa4fca1	rsa-generated	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	rsa-generated	org.keycloak.keys.KeyProvider	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N
a8dd57fd-db0c-431c-9597-c88de709fbf1	rsa-enc-generated	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	rsa-enc-generated	org.keycloak.keys.KeyProvider	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N
3917f929-068f-4fb7-a5cb-82d7db5c846b	hmac-generated	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	hmac-generated	org.keycloak.keys.KeyProvider	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N
042aa750-68cf-4517-ae7c-624d64eab286	aes-generated	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	aes-generated	org.keycloak.keys.KeyProvider	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N
3b4fd2e2-761c-4a02-9f6b-de80526452b6	Trusted Hosts	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	anonymous
aabeb4a4-f1ab-4ab8-94f2-e2b6f9875c4e	Consent Required	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	anonymous
19258f99-abb0-483a-8d62-2fe1085b2aa0	Full Scope Disabled	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	anonymous
29e631bf-b9c0-477c-8e4a-ce5e0fa7cb62	Max Clients Limit	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	anonymous
fbc878ff-3af4-4a53-969a-2222cc63ca4b	Allowed Protocol Mapper Types	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	anonymous
84420526-acdf-489a-9b57-5c0d3cae2f9d	Allowed Client Scopes	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	anonymous
1b5bf82c-2935-4359-996c-aeee6a609cc8	Allowed Protocol Mapper Types	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	authenticated
5a24f22d-3e7a-4113-8eab-1078daf9afa0	Allowed Client Scopes	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	authenticated
caafb727-054e-47e9-9b6c-8b9e8e30c055	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N
cac5e949-22b9-4fb9-8782-b408c83ce5ae	hmac-generated-hs512	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	hmac-generated	org.keycloak.keys.KeyProvider	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N
27e96fd2-f3c3-4ee0-b295-843741d8cf79	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N
db3a2ebe-a49f-4ad0-8b1a-0c1edd9bd368	hmac-generated-hs512	2a297db7-66c5-448b-80fc-9d7d0ffecd68	hmac-generated	org.keycloak.keys.KeyProvider	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
5bf63cf3-08c6-4496-86c6-9fd53d5ad474	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	oidc-address-mapper
3660e022-e1b8-4147-b74a-935fd8104a4d	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	saml-user-attribute-mapper
5c65c6c7-a15a-493b-b3d7-159aded6259e	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8f87705a-9511-4fd0-867b-67059d227917	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	saml-user-property-mapper
91f7e22c-322a-4515-ba34-cbc6e8439cc9	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	oidc-full-name-mapper
1ead9a28-9f65-4397-ab6f-50039970bc80	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9d63b903-1d6a-41dd-8b6a-4bfc25863f95	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3975da49-56c3-4cd8-ac9a-30ae9808c871	34530f1e-1be9-480c-a4dd-80e037c1a92e	allowed-protocol-mapper-types	saml-role-list-mapper
365f2646-72ef-4e39-a943-977b6f95c5a4	f8689100-455a-4071-a23d-17a71a46d9e0	max-clients	200
a0602ed4-c53a-4465-b5dd-8cd4d2b43bfa	716524d6-c4fa-470c-beca-8f06312e041b	allow-default-scopes	true
924960f2-9207-47f0-bdcc-cb03503e7861	7b21ba3c-702a-4acf-a32f-9d6b500a0a34	client-uris-must-match	true
332be744-e902-4b53-9d57-f5b51f2e1406	7b21ba3c-702a-4acf-a32f-9d6b500a0a34	host-sending-registration-request-must-match	true
a9566897-2b31-432e-9ed0-5e3ff5b3fb75	5fbd6391-5e8f-41ac-bf94-a6f177da52ab	allow-default-scopes	true
2e0dabbf-337e-41b0-91af-78c1bb6b2aae	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	oidc-address-mapper
e80c0b80-890b-42e0-8c77-083d08f25d43	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
aaa6a8f2-bc08-481a-ae42-ada800fc9d05	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	saml-user-property-mapper
6e244700-b047-422a-a1f3-a0caaeb8aa7e	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	saml-user-attribute-mapper
166e5b0a-16e3-49ad-8527-1d237187fdbf	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	oidc-full-name-mapper
fc483bef-b9b1-43b3-b2f9-329c9cecfeae	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8d53cf6c-3521-43a3-8a79-96a08c09c65d	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	saml-role-list-mapper
c850d4e3-9006-4bf0-a51d-392b3b6e9463	ab95cc27-ad8d-4eaa-8eb2-4fa42a73f69b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b73412b1-f828-49b6-9baf-58c6e069df63	f66f119c-94a4-404d-ad9e-9987ead7ae75	secret	C5FnpIG7fLKOZQKnpMEZyQ
7c98f05f-ae7b-41bf-9d6b-598507bd0de9	f66f119c-94a4-404d-ad9e-9987ead7ae75	priority	100
5e96aba1-eb7d-4836-b922-f8ea86e0e42f	f66f119c-94a4-404d-ad9e-9987ead7ae75	kid	28a16b74-1b0f-4021-88fc-3c35505733ea
fa2bf8de-bb06-4248-a8c2-75658745349d	10f3f8ac-9615-49d8-861c-11cfb9ed8e06	priority	100
ff76cb0d-cd31-43cd-ae40-f42f7b637ade	10f3f8ac-9615-49d8-861c-11cfb9ed8e06	kid	8b5e523f-d209-4d2d-ad51-63f6f43d6be6
b63504f2-0e8f-4266-8357-61def031859c	10f3f8ac-9615-49d8-861c-11cfb9ed8e06	algorithm	HS256
1f299eb2-7fd1-414a-97e5-e2f119d5a992	10f3f8ac-9615-49d8-861c-11cfb9ed8e06	secret	_dq1PJYJbmD6UB0khrqn5vSzGfjU3V2nmCh0VUlZrwHRrfxIu4ibs-7V-1LQSeNjHq_71OGMU_yjuSbe2Tiq7w
9ab0a5ae-bca5-4373-9a19-400dc8e6af54	61baac98-7035-439b-a15e-d5a36ff8c31b	priority	100
70d59409-89fb-42bf-a684-7118fd5c46b7	61baac98-7035-439b-a15e-d5a36ff8c31b	certificate	MIICmzCCAYMCBgGN9g1JbzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMjI5MTgwNjIyWhcNMzQwMjI4MTgwODAyWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6AFyCXy/ltqDNmPk7ipW3eL3jga7pxeONL66fHuvvy4z2ll7WVquXCgR/t7awEu23N2M/r8AXJfNCiQJQXqowCICWbbFcfaN3v7GQ+MxbbhGne5eo4Tz+6F2SkMEDy1RnqaAk/UxcRRei6eLXNFfUGzo+VG34LxQ00rjUN52QfTaEstEbH8SeXQnU8HZ7LVwaXjLQ7yywU1Xq9YltCGItmMJTtmfkmiEAmfvKuV/rJuaw/9QcVlAO1wqW9aZKiEDfZbIsERwOg39j8GSTf2EGphfV9SZppQoqxl5OQn3u/4wvI4lD398WqjgjAEGS8wODjfcTTBrVXQZ20hTh2SehAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADVqlw2xJqLqPQTSs/lF2jftyZ/Q4xS9fYZV1yhte+fYGAwwFTQtW2KqQPFbuCa71kMitX6nM5kKTe2zDtVjKcDXt16kdok3IbjzwmOKywfGZGk7agpAXj8hg7wH40VJzlq7uDkqicr0iAxQ0YkCiWKl7Sb3XGFSVgKwN/zGnnAFlRw+njwdQjOMGcae4z2KzwXRxTwwnV8iLBFsMFBVty5tCHuMiQNEPVKgWb0lw5gTlfSUHhGvbdTsVeJ0vWInAko19rN5V3ksI/NHs22XUKTAYejZ6qzLXO7GZaF5prI83C0Yb+9uxTTHSzsYVzS8S/bMycvWrYQScqoPbV1gTi8=
46508acd-8fdc-4021-b5d4-4c84af535220	61baac98-7035-439b-a15e-d5a36ff8c31b	keyUse	SIG
fb9ae30b-a5ed-47ef-82b4-055475a785bc	61baac98-7035-439b-a15e-d5a36ff8c31b	privateKey	MIIEowIBAAKCAQEAugBcgl8v5bagzZj5O4qVt3i944Gu6cXjjS+unx7r78uM9pZe1larlwoEf7e2sBLttzdjP6/AFyXzQokCUF6qMAiAlm2xXH2jd7+xkPjMW24Rp3uXqOE8/uhdkpDBA8tUZ6mgJP1MXEUXouni1zRX1Bs6PlRt+C8UNNK41DedkH02hLLRGx/Enl0J1PB2ey1cGl4y0O8ssFNV6vWJbQhiLZjCU7Zn5JohAJn7yrlf6ybmsP/UHFZQDtcKlvWmSohA32WyLBEcDoN/Y/Bkk39hBqYX1fUmaaUKKsZeTkJ97v+MLyOJQ9/fFqo4IwBBkvMDg433E0wa1V0GdtIU4dknoQIDAQABAoIBAEuMlQbBWgegn/0Siv1Dw58jtGFhzeWXYt94hCGOoj+iuo14M2o1BvpQ79XejZ5D+flGzpHSNaBRYlbepql1YgQjl/NB9939DDY6Dwo2/G6QrSwNl+LZJfjV8hfzouqDHrQCYpFTrz31NG4QOPq3gIsfSg+CJK6/lKIGC1vrgRzsBbPU3Tvxo3QSeLBUgt7NTmmUU0lqzC3pv/3FYM3aIjRHxjykTFfdh9tKEdKAE77USWsc44moVzcRskOn6IrlpYQAyb4YjnHIClSuZRbIQ5sKWWC2NQgpGPcnBqT6KoTPS4JLG+x78T7W9K0+18nJbsCvRe+oDHn0zd0mNuRUea8CgYEA376j1Gwy7Ood8K0fgUNW8PqDyxSVu8rO9xQ33jaCL5XhDfqjKLikZoaDBfAIrpZXEoz5nuLnMg0IamhjY92VXWv3P/MbpcbPEadt5xUmWqZ+E/OQ271Ic0yUUQR1GREC4YmRsmJtwclxdD7k3d3Bf/lYspzaSlrhlUNLlHywYycCgYEA1NDLmF/6+JF1KZ8ryKeZlrveG+ru8PlPPzy03RvPCodtNMY5HSefsoQIzZUVUCg45Z2kj2XWQsiLIphFLV76bxG4PW0dIvlsJ98YWrKPVopCkE+z46vsQHdhURBrYKLJVS32ODpZ+7E6Iq3d6s+kk3+IbyYA1RvmqL6oowBku/cCgYAHluDZwL3NeXeAhW7PJKibTfQQfGdD0nJIwT/P4stxr8TNg5XrOLAi5iclmWnB+kmD0JJbCFlNQlHpwha0+XwqihH98lIawm6dq683qmj9pC4coSNlwLrnZk6VnPAX5JLTcaYmhd4xN5MInWWH/RCmNaADlvx0jzadqIW0yLH2+wKBgCfViTZVSNm8CE0pIP3m+SWwtotNNzpdwAqbJ1N3wBI9dSB6tfgSEZ9NfYRVkm61iKjaEBJTQn6voPNxwwkSDRg7HdxJjzmbrDXuWVWotJHDQWBXutkztf3/GnUc+KxW7A6IktzFd1BYRQR2vOIVyb1eEsCTQXaiSVNulIwmJ7TTAoGBALmvq2xjRLdZyCIU6aV+Rqqc8IIWBQmQdX/+NO0VBI1ZTL5QSV3cs4EHzNS3IFsg3lCHB1dArb65/k770ZEAYgGipDunshdyVPEmimRXwLfJlnSFu3qHD39ofKx04PUBxLugwe2GbfmeC7oqgCJZOdfoulbvLMwPsHFDbWiW6fLX
b36e370d-37a1-4229-99ff-f3b6b4cd212b	7c5e5447-67ce-42d0-a887-f75afdfae6f0	priority	100
65ede113-378e-4d14-bc12-ef7c3e0eb9e2	7c5e5447-67ce-42d0-a887-f75afdfae6f0	certificate	MIICmzCCAYMCBgGN9g1MczANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMjI5MTgwNjIzWhcNMzQwMjI4MTgwODAzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC2o+ywOPYmW3ZlTEP2QEc4INOGYfbFpS8ezEqGSe9PSIltH3FvvkXyL0oEbHHl7sU0HtGnztSnqUaRc8FYv9wj64tG0HU94m1amjc9vfTVJr+dSvdcL933RfDys0ZZjxuHDKiG4SHwf7jRAm7l7bk/ZAKjgr+swykMZ9GNusqZnkGGQUaBfaxjZNn8GFaFZPpCejO0zlS6SPLnYdqVjJMBjBGCbDR5CAjFa9me1XiI2YP3DQDvnkFIpKN2tQJrthzvCrz7TSJSmfoUFbrSKbEaLxc60lQa4As/CelOTp2Ke8T/6Ow2Qx0Y1eIGYv9i/ooJX13TUg/h1DLVUfyqcc3RAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAE6ezH2IK+PqdnaM0Tgw+qPzQ0Z0WAoUL/ZK2+ZW7Zlv6gtoW8zz6DGs4RPmuHSSYCiDmPosNVXCL4kU4QjywLibqIxAoJqmQ7LY76YEc1M9/xOV5InOAZPFpnR18oUw2u7xnL4D82KmNGP+vN7eTDc0sv6nWbpze4JawQwiB150o9Lh0mmHk6ofyxbd+VYyHyx81702brMG3Aw/neObtgZnIt8p+cW2Hy3WKOfwVtubzpk+afwu9hPym15+UbLkeeL/BN6Xn/6L5eNY1+gXqL8t/k9ZU7/YeBi+oOycBfJS0FkEvlvs27HwN0DUYzlcN/xM9kqztz0/rHkZScM8vak=
71071345-c7d5-43ae-8921-ba44c486ed91	7c5e5447-67ce-42d0-a887-f75afdfae6f0	algorithm	RSA-OAEP
9b45010b-978f-4fc5-b3db-e9e5f17ce3b8	7c5e5447-67ce-42d0-a887-f75afdfae6f0	keyUse	ENC
5a646c2b-95de-46b9-83c5-67e36e08a8ae	7c5e5447-67ce-42d0-a887-f75afdfae6f0	privateKey	MIIEpAIBAAKCAQEAtqPssDj2Jlt2ZUxD9kBHOCDThmH2xaUvHsxKhknvT0iJbR9xb75F8i9KBGxx5e7FNB7Rp87Up6lGkXPBWL/cI+uLRtB1PeJtWpo3Pb301Sa/nUr3XC/d90Xw8rNGWY8bhwyohuEh8H+40QJu5e25P2QCo4K/rMMpDGfRjbrKmZ5BhkFGgX2sY2TZ/BhWhWT6QnoztM5Uukjy52HalYyTAYwRgmw0eQgIxWvZntV4iNmD9w0A755BSKSjdrUCa7Yc7wq8+00iUpn6FBW60imxGi8XOtJUGuALPwnpTk6dinvE/+jsNkMdGNXiBmL/Yv6KCV9d01IP4dQy1VH8qnHN0QIDAQABAoIBAAt/Py+KrmgUutu+lMqkGjeczWP4t72SW+h+6LQSZGejw87kO1JS8nk/49NqdjMIuE5DIGSFXxqcy83tMP8iuLtkIPTYu4ClR8f7zD1tP0PJuCcxKGgbtUfTFctZYLTTjuKN9+/hrS7EA4DYu91qfQ5R/96GJQW9lVBsGqNm3kkUM1lSf8DV7G2U/fu4lvYVJK3/o1oIe59IoE2jH0lefcjXTENI97roj/0Bdp5RNRr0fPmNGiqTtXtTAWJu8YRmHZ/s+BrxOPmsDfukyhALqszAYvoC+BbU4xB21M9B4s6VZskSWUdQhPiN2A7mPQagtrJAgq69/5I9+f/qPk+wbP8CgYEA8pl9n5fkQ/LJVlyM0eb4aM3ekrx8/3jaqmMU58N1FV4Uo5hmmQYUl/wMDIBFPK90sT8unKT2Zd+ytEIQgzqBopqSGf8He15i+oEzhF4DPSO+1YBvXow/NNKbW79DVf8/lj3UfxX0TkkuRjbSHE9w2SpTR2F2/hr+9X/pOQV/Q/sCgYEAwLqSoBjPiG2KcgyJZZzV0zEi8eBoENtGqC+yIXwxa1/S07z1AdAy1Y59JQf8pTSLRPSdKRT03H5qjXnPuEpzzTME0Aqd9XUox09yMa+VMkDkAKv2bA9T7eOMmccYzZSXmE/kz1Co5CchSasfVaJ6V1yhPH+mvT7XNdT5rNgQf6MCgYB9TZ4/Ijr6hZpMiv0JJZ1EtKCzdbuyUH/Q5eBUXPZKlQ9f+EV14FgesEag5lfcoltJeXLf4ayKreIljMHupfdzPxcbakg5BmVlMfqj8dMGb0IQEIh1c0bqR6WK290xu+bh+QmaooJPNSk7hvE7QiTtZhkhk0vcr6DkuK6Djz1OpQKBgQCWqUM2JC8YV4mC3ooKBTCiiCbpLqQriT8S+zYlNxDq/12waGafpEIY7+qkqDm4a/rzTMYO93Lza1+geTkIuCsOnnOErsgMuinGpTR/4uKfBls2qzdYAiN6NAgVrq6VBzP6vXoBFuzwbiZ3kG5OY1WANclVofSWvClAy9ziYYWEQQKBgQCKdgH8HUJwhadnosgCovAw00EzH2R/1uxgkz5cUORN0EnxIb9saOFZ5Y8S4F0qieFcEm2rVkQw80sUrumAbRY8LG9k2V18nCXSjMoMBvXf1qEDFtJcWI8SltuPeHztxQ+QHqZ3P1StjHkh15fxzocvWLwoYiCLIlHwL1ZcurjaTA==
fdec7a89-cd3c-47b8-9b0f-093515bd714c	04dd517c-3270-463a-8875-54c98fa4fca1	keyUse	SIG
b0e0a640-4041-444f-98be-4937a3628261	04dd517c-3270-463a-8875-54c98fa4fca1	priority	100
96b49602-2ad2-4f2a-af99-3fb36ba359a0	04dd517c-3270-463a-8875-54c98fa4fca1	privateKey	MIIEowIBAAKCAQEAz4Gs4Oa6p1KNQUPg28A/f1gAMUL2zd+vpaGPTTZrBzgWTGdsQgGe+vT+84iP6iGcYScmODxQLKD7+nwn8la9g8OttI5Ay6B90wiXaQWE0MwsH1b6GViQqgMSyuVA3AlgO5+2NGOGSB5sBBw2prf9ESRW00JrudV6+T58kmIvbglsMxidNS3SkcTGc0aixCZDg1VIj0in8Vr+2VzFs76rbCrZEdBoOGAW6dsqfnO1p1f57Y+rDeZzUQN7rq3+7LVT6OHJhjOvKPbx6QfU5nDEtORH8TlkxvX/kIaKEM4WUxnoWxHu3uJxUoa2PjhvyJYlBHDcaJEqgNrbMw9tBPTaDwIDAQABAoIBAB/whlMhwJYzozFqCMjaWQu5WGI8u+9pYEhey0dnumakj+4XtzabuERJhJqoqPoxTTg5Be1+/xo3d0GRbbaj+ky3SFvzz25oWCWs+107b7uRybLTOPDAzJeWnIRlcCvON6VFyo5ayVb9c8PYMeNMi6PhU4n1/c3fWavWnecMPN+zRU/ZCoEkN7wqBxyl3LAFqpY21a1ln5sKG+ExOs+ZeZjMBBYB032oGnutZhEPmptNZkESDZrWwfE1Elq9RH9K1mzDrh3l2SzO3rsNexELeoIJzA+HgkD0nleEHQ+hlx5uRDoVmYglmiuDZD2reuS7sW3wVKRNH3cdcFItnix+tTECgYEA/bz267K1cTHjd7uUOwxEzKA6yO+rNPVyMmwo3DcSUT8016Unix7NNXSYi+2kXzE4segYCdIkVf5Tef0DABC0/8uzKCfTnkmouiIcxpqOw/aYgmwNehcRiLx0LXcX5BtetG51uWD0p9Ek8HTOerlSfW+EuEeBmbhnW9ivXXR/AjECgYEA0Vs1l+yOnVU6Nkytw+GX09l8vUK5YKTyR31AZd5e/suiOSdhTES2v7YAmuzJtld3KelDvXtYn727ONuW1uZ5T/mMgaGtrrgYcOecv8oCkvu6bfh/9hhqLEo7iRTuMu2A8ZpQXTB/UlPgsaXXUmgvt1NNGHOyhfQKS3pAYVREUD8CgYEAiEh2VyIlUib5hdW6R/zO9xkYedRAoLE0JODzEVSDAiBwwWJzWsWwcoWtaXq6TmahjOyb/Kph2c5AB8VdVyuiC8Hc+DRr9RibB15LFmDtTVOllmdy1aCOSmLuA31z15DbzQ2HLYpl3bz3mi8it8fSBo1fO5ssgOQKn8pCZm+ryAECgYBPBzIk5kwzge+Wfb1+WtM4Sjn3K4/Uto8qg1Ji4d1UK0RSdNYatzmRBsAVu1qtdTjrXj2O8lfS/QkGfoXjG18h3F64tHJeqOm4/QVDtJriJxoJ1ytel3rEu0TcC0WbfeIV0Z2Sf/Mf/b+s76BnYCLa/hv1Jf9251dXhI927htXewKBgALq4Nk5o5Oi4B+YbNorJq7kMm+9gnVJFqnH2Jl7n6+pkAwfhUFnCADy1J0YwN08WbVBiAfep0OXfhKsBDRtv1RPf1LFqEKYMlLYG24yVYuPnKbM9hC9e40SyfKnPbWUGvwQrEuq2qVlA326j55XdFu6v5B2ggyf7ZZiCVeYbEN6
c12d953e-47e3-46ab-af55-c7ea9be636f8	04dd517c-3270-463a-8875-54c98fa4fca1	certificate	MIICoTCCAYkCBgGN9g3hwTANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAliZWF0YnVkZHkwHhcNMjQwMjI5MTgwNzAxWhcNMzQwMjI4MTgwODQxWjAUMRIwEAYDVQQDDAliZWF0YnVkZHkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDPgazg5rqnUo1BQ+DbwD9/WAAxQvbN36+loY9NNmsHOBZMZ2xCAZ769P7ziI/qIZxhJyY4PFAsoPv6fCfyVr2Dw620jkDLoH3TCJdpBYTQzCwfVvoZWJCqAxLK5UDcCWA7n7Y0Y4ZIHmwEHDamt/0RJFbTQmu51Xr5PnySYi9uCWwzGJ01LdKRxMZzRqLEJkODVUiPSKfxWv7ZXMWzvqtsKtkR0Gg4YBbp2yp+c7WnV/ntj6sN5nNRA3uurf7stVPo4cmGM68o9vHpB9TmcMS05EfxOWTG9f+QhooQzhZTGehbEe7e4nFShrY+OG/IliUEcNxokSqA2tszD20E9NoPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKcqq4TM2TEG9sA6U4bhv7EKV1wrfSU3D3txoV236/9W4mID8V42L8W5zYnchyizoZBHuCoCcXswNXCfkSc6iEepDHa3s/OBPuHyicHV44P7OHcq8OzhtDla2sLKQ8so4r0nTyZlOnLta1y2sFHtWg6QRVJzemsabauJWLkq/yewwqawpIbfl+3JEQ6FgpIYbMNV/rd/f7ujowL0enIUaT6CNx3eFSACTXNGfuZA2CPWHUKbl4kKRd75DPmMWrW2mMXQ8PeV/3CD0hpXxYUwNwTlYi9uVDHNiYQgPQDEa8O/Enx8nsJ/y2Cv2Hmg27UK/g8TDayWojrwJz/eVo6/WuA=
82e83ca2-dbe3-486f-bf7b-8cef9fb67af2	3917f929-068f-4fb7-a5cb-82d7db5c846b	secret	3rTi3LsshiU4X9Z1JJ-lxGKTECbfrMHgVgTwwdkEcLdFzR-n4jM9a9UcvLO3EunsVsSYIoKmzURwhPa7I9kuHg
926ab652-90b0-4b4e-9968-6ff42cfd2fd8	3917f929-068f-4fb7-a5cb-82d7db5c846b	algorithm	HS256
cfd8bf46-f83e-420f-bf60-6376be0671fc	3917f929-068f-4fb7-a5cb-82d7db5c846b	kid	87f5c9bd-de87-4215-b286-2567567bcc4b
92a0edaa-02ed-4942-83d4-e9b86e64d03e	3917f929-068f-4fb7-a5cb-82d7db5c846b	priority	100
b179f1a7-9478-4aee-b513-311b5e631ed2	a8dd57fd-db0c-431c-9597-c88de709fbf1	certificate	MIICoTCCAYkCBgGN9g3jlzANBgkqhkiG9w0BAQsFADAUMRIwEAYDVQQDDAliZWF0YnVkZHkwHhcNMjQwMjI5MTgwNzAxWhcNMzQwMjI4MTgwODQxWjAUMRIwEAYDVQQDDAliZWF0YnVkZHkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDTY3SRyeu6N5+czgcy6DSFwM7NOzWJZ2jAWfZGd1JME6ubDf5NBOND8yWPVbqJd+kvJUygdU6AYvI/KCKAoTyOYNKaIE8TmJK4yti5Wp5JlEtgtRvN297fMWMY+f110Dbeb/KQ/87aXP/Osf/WyM77SlUAzDqZgxZewlNkDlKovQaUVG9KDBOt/2ZYUxK1HnGCwM7EnDurC0v1lZ6re/aBsoFpjkECNTO+V6G7WNk/mJEA8qME8sKHrf0Nsn2Hp+xNqdt3znNLnkZvRiai82g++pwQ3kQDhproB0LTYNoaNDKKKghpXkgPqANCMjTJij77zdGlNgoEF5tHXMRZvVxXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGQYmKK0Hsit71KwF4KrFfDaH7YnVM9QSOJjep+57+VhmgU+w6a/5wlltTiWHWCTAMrV+NtGii0D5ZMyqG1bUTaikOR9poTRgVJJEDVxI4aJAUYir3uu58Y6VUHbI8NTv83aUyrk7qbN54LA973IPv4laddmVgawpzCqk18wzaIDa0hLV27++O4UN3VLLiwtZPnxJIgXGsMW3+STnuoQvCMrp/tWxtm78ha20CtYAX1QEXCc4IwlxZvZG8QOVntsn88p6n1r3Tp1rInOQo4JUZ9Kw1eLDg+HH4QNXsApLqyJ2dT3+KgyaluwgWE10DDwwFVeONv0SozhKcRrGbw0k4s=
b027c7ef-adaf-4220-8647-073ab44cd57e	a8dd57fd-db0c-431c-9597-c88de709fbf1	algorithm	RSA-OAEP
4095d0f9-75ed-4d89-ab9b-03534a071f91	a8dd57fd-db0c-431c-9597-c88de709fbf1	priority	100
205fc28a-7376-4932-bceb-1a4d230240de	a8dd57fd-db0c-431c-9597-c88de709fbf1	keyUse	ENC
ab81cb19-7875-4b8f-999c-43c5ab7abee5	a8dd57fd-db0c-431c-9597-c88de709fbf1	privateKey	MIIEpAIBAAKCAQEA02N0kcnrujefnM4HMug0hcDOzTs1iWdowFn2RndSTBOrmw3+TQTjQ/Mlj1W6iXfpLyVMoHVOgGLyPygigKE8jmDSmiBPE5iSuMrYuVqeSZRLYLUbzdve3zFjGPn9ddA23m/ykP/O2lz/zrH/1sjO+0pVAMw6mYMWXsJTZA5SqL0GlFRvSgwTrf9mWFMStR5xgsDOxJw7qwtL9ZWeq3v2gbKBaY5BAjUzvlehu1jZP5iRAPKjBPLCh639DbJ9h6fsTanbd85zS55Gb0YmovNoPvqcEN5EA4aa6AdC02DaGjQyiioIaV5ID6gDQjI0yYo++83RpTYKBBebR1zEWb1cVwIDAQABAoIBAA/mvECXqcgjlTnXuu2AT5JWK1hMR9Ey7bIDTAYHkmT1pj2InNeqi/WZenq6exWkAKI5K8P2pXXKVUKDk62mzPLa43/2xgWjC9QJy90mYDmhuNZCZjm8ledznbdykR3sXT94HvOVKQUx5LsY/OlPyFe/3JgURNfPNBh864ZfZQybR63ou/SXbBVWw2FrNfUggw7p57e8Gbapoq8X1XMtOd/gyGF9gy1ofsdCA4Ulc0Ey5pZ0Ur+afUBlnYqvkgjkpbgNRuM7HCX3Tvjxyddt6g4I+5Aiu58OjmFUFjYveISOVq/e/xVMKe8sSyRZKx+W52BXBcgNGVFNGo76gDYfPlkCgYEA9ww6Wx8zGcDKGOvwKYbVChYuB7PYBlFnOc8BbcUPorrp2NVogQPtyo/2woXru7xt5ZTKFCbav5ijtz74Tmr2UdigwcuMnEsySIsqK6DVkIrUZXF8iHIb/IDP+uNLBKBoHMtJpASxwcM9oS1FfNgrqYkoJfgiRL21RvNN5wBkWdkCgYEA2wxt6x3vKUbOv657FvwMRmwqPq387Uf6RjJZm9hnYYwvbRyz9OGDIk1FU0Jw4UigFbS3hrP9FCdflU8tAuxYMWrM/dV3p2ktsmfc9hxLuMnTyGzXJj6Lsz92KJhz1CJ3hz6EOOdifTmJzH7kx7stC9TCkURQPg89mP0PWRzz2a8CgYEA405w8x6F2hA04zFTTCIvKpS1zYiAH3AO1nXNDr7eYBAy0bup5+tBg7tqhBjMiXQaeb6pIFmPs/Ix0I0z0pNACJaVczpiKfxWS8EgD/xwBAp42s3Mk47KiU3MDz/K6nrc0IGLREq9c1a9Aeuxn+kWY2s7cZQZk74paRq8dus5aiECgYEAuiV032H/1LbsiW3wAldM4yeWOs/GaapKIA83oT2klPv5baL/trFRq/u4VwnWPUxnZiq974XTIqZXDt5K5PoN9GjLLUaTuTujbsHev3LKUo2JIQCFUWXDeB8M/XCYtgRYSSEyYd0YEEyuMo7/QlBo9m3mrmY8PpDbCsC6o0L8YtcCgYBgpEveWMj/1TBehZ2hVvMIvRyTpAZw2qmjVcBiMoA9e7YutqoICTdE5s943DG7OF9MulmbeUle5LWYacniyh1yvowfDzM4mjRlJfZxbg83zKMncn3GgS6VzvfFnLOVVPP4YfDxYPSkaLwHGpDuW16+Zcas54fYzlcNj6PJJPNHOA==
861398f5-11e6-4163-8d28-fb4ce6210c92	042aa750-68cf-4517-ae7c-624d64eab286	kid	a3b074e6-0242-4128-aa80-fd73755a3278
be3f05cf-6325-41be-8ed4-cd5d8fab63e6	042aa750-68cf-4517-ae7c-624d64eab286	secret	kDruqBxchWLYc9epRSrBYQ
0ba392c4-fe2c-47cf-b40f-ff28cafcf6ec	042aa750-68cf-4517-ae7c-624d64eab286	priority	100
9c9dd987-6625-4318-afb6-6d41dcc607af	84420526-acdf-489a-9b57-5c0d3cae2f9d	allow-default-scopes	true
60443a8d-f8c4-4b99-8cff-1e1c554e4bd9	3b4fd2e2-761c-4a02-9f6b-de80526452b6	host-sending-registration-request-must-match	true
2542cc89-f0d4-4362-982d-8c572cf5ab85	3b4fd2e2-761c-4a02-9f6b-de80526452b6	client-uris-must-match	true
23904545-5cf2-46a8-85d9-3bf50dd3b675	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
5d199fb6-9d3f-4aa0-9b55-b4cafceedbab	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	saml-role-list-mapper
da39d524-81d0-4a85-82b3-15a1c7a54e21	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	saml-user-property-mapper
ee690fb9-068f-44ba-9dfa-8654450418cc	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	oidc-full-name-mapper
66f0e18f-927b-48d6-a1c1-8d2592b7e322	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	oidc-address-mapper
cafa2342-d3d5-4f33-9844-cd7f64f0d4cb	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
cfec12fa-5e03-411d-a147-67362dd83527	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
96a510aa-5f0f-4e90-9dba-969ff2e4719a	fbc878ff-3af4-4a53-969a-2222cc63ca4b	allowed-protocol-mapper-types	saml-user-attribute-mapper
1e18902f-2589-46e1-93ee-9daec4bbb3bc	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ad60b022-4596-49c3-8171-988b0af34efe	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	saml-user-property-mapper
dfc85218-129a-4c83-a3e9-5d6cc326c9bc	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
19bd78d3-a86c-438f-bf75-941ffd966127	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	oidc-address-mapper
93881f96-4676-498c-9212-1b6b01a2dd40	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d7e981bf-6fc3-4e63-83bb-9450c8f6817e	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	oidc-full-name-mapper
d729de51-1b49-4640-9123-0f27ffe09c66	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	saml-user-attribute-mapper
5cf7a0e5-646c-4e0c-94fe-96925a1abb2f	1b5bf82c-2935-4359-996c-aeee6a609cc8	allowed-protocol-mapper-types	saml-role-list-mapper
6cc1c71f-abdd-4a62-a48f-ea22ddf2f18d	29e631bf-b9c0-477c-8e4a-ce5e0fa7cb62	max-clients	200
55186044-d536-4ae0-a7d4-95f7008462c1	5a24f22d-3e7a-4113-8eab-1078daf9afa0	allow-default-scopes	true
90b7c305-0138-44aa-b21e-29148a3c7aa9	cac5e949-22b9-4fb9-8782-b408c83ce5ae	algorithm	HS512
3955f176-33de-4d02-86dc-8081b2731f71	cac5e949-22b9-4fb9-8782-b408c83ce5ae	priority	100
ddff7116-15ec-47bb-8841-f90de583a3a8	cac5e949-22b9-4fb9-8782-b408c83ce5ae	kid	b539f190-93d1-41ee-b650-6431cfcc0c71
76f39151-d38e-41fb-977d-f697fea022d0	cac5e949-22b9-4fb9-8782-b408c83ce5ae	secret	NwrLThydwiOD3fpDsAv_7PUHvVJXxF4NjxrPxLyj0xQw4y7U8XwjP5Cnu2osorPBwuYQ16wJO3XlKJtwq7x20nBSf9IADXknkvyJhIbKutM6wX5q57_tXKLIUbtyPLiQV9AlHAlRGiKStjpBCiywaU4k_H8aeOJTVicObuDfW0I
d5ad7d50-250e-41c1-9835-6a3a3c5dfcd4	caafb727-054e-47e9-9b6c-8b9e8e30c055	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
bd41f2c3-97fc-450c-acbe-7f8a9caa1095	27e96fd2-f3c3-4ee0-b295-843741d8cf79	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
4114e5d5-190b-483c-be17-ebe7de79d059	db3a2ebe-a49f-4ad0-8b1a-0c1edd9bd368	algorithm	HS512
4d88151a-9945-4abf-b10a-6f06cb0c4689	db3a2ebe-a49f-4ad0-8b1a-0c1edd9bd368	priority	100
2a6ffa95-6152-4257-b596-905de7f78d98	db3a2ebe-a49f-4ad0-8b1a-0c1edd9bd368	kid	01c6e6b0-629f-4ee3-8afa-ecfbbead7395
8b0c9e3c-3c8a-42cd-98b1-9b9925de3834	db3a2ebe-a49f-4ad0-8b1a-0c1edd9bd368	secret	fSgzyILpHlGMaf-bjDmKwzcPsHwgff4_Sh3RNUHiB1MHKNEzaISX83xrX3Xf9WYPgYjstQp31L_XFQEOCq86FlsA_KabcalPkZ3SRhEr1ZwdqJJdF-rkyna4z1yyEhHax4J0pQWnmLe1N0nyC7F-gradbS9wlckM_QetdK8LdOs
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.composite_role (composite, child_role) FROM stdin;
53b669be-79f4-458c-af64-e3907ddea213	994dd118-8ebc-40ed-b677-4105d6f21798
53b669be-79f4-458c-af64-e3907ddea213	2d1b0616-187b-4dac-8e38-8a041aed671d
53b669be-79f4-458c-af64-e3907ddea213	49e1875a-b891-4cba-8202-fd64d23c0aa3
53b669be-79f4-458c-af64-e3907ddea213	9c9cdc62-e032-494c-86e7-063f54004637
53b669be-79f4-458c-af64-e3907ddea213	5b4759c5-83b8-4501-a01a-6abb3bc7b019
53b669be-79f4-458c-af64-e3907ddea213	8b1d4f85-8583-43dc-8466-176e314c8998
53b669be-79f4-458c-af64-e3907ddea213	cf36dc16-c0d0-4e70-ae82-d961ce054da2
53b669be-79f4-458c-af64-e3907ddea213	687583d0-87af-4a28-98f1-35405fd39c32
53b669be-79f4-458c-af64-e3907ddea213	a468989b-8e5b-4057-a22d-27e482e1578d
53b669be-79f4-458c-af64-e3907ddea213	dd413582-a5ab-4188-b8da-0441f768e87e
53b669be-79f4-458c-af64-e3907ddea213	0356394d-ccde-4c6d-9598-a1e0b8a9d162
53b669be-79f4-458c-af64-e3907ddea213	85a63fa3-021e-4696-ae29-1868c4c68e9e
53b669be-79f4-458c-af64-e3907ddea213	67d02b05-3a26-4357-ad15-1d8398eff80b
53b669be-79f4-458c-af64-e3907ddea213	f13bca44-46e6-43fe-a1f7-59cee3acac62
53b669be-79f4-458c-af64-e3907ddea213	31cb123a-5d61-466e-8dad-1cb0fe1361a4
53b669be-79f4-458c-af64-e3907ddea213	84b240f7-fa0a-4c9d-8d78-fea44e1d833a
53b669be-79f4-458c-af64-e3907ddea213	de25733d-0145-4528-a771-953602d77236
53b669be-79f4-458c-af64-e3907ddea213	1ae89d8d-5ab3-4292-9d21-da9ae165d9a2
0cdd42b3-92f0-4462-933e-193096de1054	c1d5bb7f-4957-42d6-b13e-091edda49ca7
5b4759c5-83b8-4501-a01a-6abb3bc7b019	84b240f7-fa0a-4c9d-8d78-fea44e1d833a
9c9cdc62-e032-494c-86e7-063f54004637	31cb123a-5d61-466e-8dad-1cb0fe1361a4
9c9cdc62-e032-494c-86e7-063f54004637	1ae89d8d-5ab3-4292-9d21-da9ae165d9a2
0cdd42b3-92f0-4462-933e-193096de1054	5028226d-1974-4fec-a42f-31c31f96701b
5028226d-1974-4fec-a42f-31c31f96701b	f4ba6609-a55e-4b55-82a4-bb49fe114efe
726a758e-f9c5-4611-a8ff-bdfccdeaa206	a29d464d-d634-4364-92cb-2862f8becf57
53b669be-79f4-458c-af64-e3907ddea213	492c68ec-a51b-461c-a9fc-8607f76b5bb0
0cdd42b3-92f0-4462-933e-193096de1054	6db8c1f0-503e-4f08-9480-447e4ec7de33
0cdd42b3-92f0-4462-933e-193096de1054	e8646388-7147-4706-bb46-dca39b621d34
53b669be-79f4-458c-af64-e3907ddea213	1d708059-fea2-4da3-867a-00b687b95149
53b669be-79f4-458c-af64-e3907ddea213	87c40bcb-42ba-4bcd-8e4e-80a97f07d9a0
53b669be-79f4-458c-af64-e3907ddea213	9aa35a10-047d-4e1c-b401-f3f384adf0d3
53b669be-79f4-458c-af64-e3907ddea213	16ea30dd-aef8-4c25-971a-65249777a09d
53b669be-79f4-458c-af64-e3907ddea213	7e146706-628e-4d02-a3b0-84398d480672
53b669be-79f4-458c-af64-e3907ddea213	3b15e2c7-377b-4aaa-a4fa-2479f30ba60e
53b669be-79f4-458c-af64-e3907ddea213	f8d22d5c-b5ab-419e-9676-16f12d9cce65
53b669be-79f4-458c-af64-e3907ddea213	f3009026-8ab1-4638-9d4b-e0a7a9299618
53b669be-79f4-458c-af64-e3907ddea213	b1f8ddc7-12de-46fe-8c7c-3bd5f80e4dc4
53b669be-79f4-458c-af64-e3907ddea213	840db824-c087-42dd-9f87-43b6c4670c4e
53b669be-79f4-458c-af64-e3907ddea213	a694c843-577e-4344-a074-f733e1600197
53b669be-79f4-458c-af64-e3907ddea213	3fb51f28-683a-4631-b649-521ce4e1d9c7
53b669be-79f4-458c-af64-e3907ddea213	ee6e08b3-4e31-4401-b12a-236b0c09d277
53b669be-79f4-458c-af64-e3907ddea213	b961753f-e7d4-4daa-8e21-b7b121ecb7c9
53b669be-79f4-458c-af64-e3907ddea213	25b521f9-d8b9-4a9a-8176-99f04c8f1f40
53b669be-79f4-458c-af64-e3907ddea213	7c9bcb90-b7d8-4c01-b934-998d7f29a8ef
53b669be-79f4-458c-af64-e3907ddea213	a16bbe7e-8167-488c-8ac5-56ff9c3fa647
16ea30dd-aef8-4c25-971a-65249777a09d	25b521f9-d8b9-4a9a-8176-99f04c8f1f40
9aa35a10-047d-4e1c-b401-f3f384adf0d3	a16bbe7e-8167-488c-8ac5-56ff9c3fa647
9aa35a10-047d-4e1c-b401-f3f384adf0d3	b961753f-e7d4-4daa-8e21-b7b121ecb7c9
e632c6e1-8780-48c2-8adc-61e6c56910a0	11c0b7d7-686f-4cc9-8a7d-569b477d681a
e632c6e1-8780-48c2-8adc-61e6c56910a0	3212a2ac-2115-407f-a613-d560e62b4e90
e632c6e1-8780-48c2-8adc-61e6c56910a0	9ab98715-77c7-4353-a696-3bbd41d1d2e5
e632c6e1-8780-48c2-8adc-61e6c56910a0	8713e091-9b5c-45e1-b036-8be0902a1fb2
e632c6e1-8780-48c2-8adc-61e6c56910a0	4c4eb9fa-51dc-4546-ac5a-60f9b85997c7
e632c6e1-8780-48c2-8adc-61e6c56910a0	f42001ca-7085-4f19-90c4-51d21bd8c05c
e632c6e1-8780-48c2-8adc-61e6c56910a0	0d8e1004-593d-4890-a193-37b6db371148
e632c6e1-8780-48c2-8adc-61e6c56910a0	8d3667f2-740c-4fd7-832d-beef26bffda1
e632c6e1-8780-48c2-8adc-61e6c56910a0	990521cb-e322-4963-9e29-8919c2f3b664
e632c6e1-8780-48c2-8adc-61e6c56910a0	31ac0c8e-e05b-448e-894a-699bbfdfd6bc
e632c6e1-8780-48c2-8adc-61e6c56910a0	e6043f68-8468-4bb5-a425-dafdc5c343f4
e632c6e1-8780-48c2-8adc-61e6c56910a0	5e191395-75d9-4f2b-adb5-3e5762fe6db5
e632c6e1-8780-48c2-8adc-61e6c56910a0	030856d3-f970-490f-b3d3-7de928e244a7
e632c6e1-8780-48c2-8adc-61e6c56910a0	7c2ecdb6-8668-4083-83da-209e250ee13d
e632c6e1-8780-48c2-8adc-61e6c56910a0	fefd8617-ec3d-43f9-8bdb-872986f76e8b
e632c6e1-8780-48c2-8adc-61e6c56910a0	045828b7-4f47-472e-989e-7c83ca900997
e632c6e1-8780-48c2-8adc-61e6c56910a0	ce556194-f89d-4d29-86da-d2e57b511e5f
5eb9be7a-4c63-41c8-8720-af3203a01554	c13110a7-b8e8-4738-915b-86f827631c28
8713e091-9b5c-45e1-b036-8be0902a1fb2	fefd8617-ec3d-43f9-8bdb-872986f76e8b
9ab98715-77c7-4353-a696-3bbd41d1d2e5	7c2ecdb6-8668-4083-83da-209e250ee13d
9ab98715-77c7-4353-a696-3bbd41d1d2e5	ce556194-f89d-4d29-86da-d2e57b511e5f
5eb9be7a-4c63-41c8-8720-af3203a01554	abb5ff64-44a4-4def-88ae-78678f40d8c8
abb5ff64-44a4-4def-88ae-78678f40d8c8	1a7b1a3c-57a9-47eb-8a8f-97c6aee63023
8265531e-5fbe-436e-befd-ba58940b6955	4a94633a-903b-487b-a132-04f7692a321a
53b669be-79f4-458c-af64-e3907ddea213	8425212e-6808-4938-a817-827887f478cd
e632c6e1-8780-48c2-8adc-61e6c56910a0	7dd0b03d-524a-419c-9404-be493bc64142
5eb9be7a-4c63-41c8-8720-af3203a01554	f48b3cd7-fd1a-4273-b3a6-2f6615df7b95
5eb9be7a-4c63-41c8-8720-af3203a01554	208a1e1c-4f71-43df-a781-501042379b99
5eb9be7a-4c63-41c8-8720-af3203a01554	1a7b1a3c-57a9-47eb-8a8f-97c6aee63023
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
0d998f13-5ef0-4815-96ed-e81ca5defe0a	\N	password	b42e4aeb-7841-4f9a-95ca-70201dc5f1ef	1709230460086	My password	{"value":"LrWigilMeuKfl1GDQX0OgTHQotaWmo9R++m8v0GnDwQ=","salt":"v1RMX8QRsQ/R8oKwY2T5EA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
9e043c54-a24a-4647-bcf9-2960f754682b	\N	password	5d9ae386-bdf1-4376-bac7-908a83b36383	1709539541354	\N	{"value":"yS6LvQkQYy6sz4c1578afcaSYpsVt8lvw3j3DXef4is=","salt":"GbM1BefB4G3BUXAwO4K7Xg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
bb9ea39f-9329-4299-9b44-12a93fb14a55	\N	password	2d455703-6b41-47ea-a01e-cfaf72361d0b	1710745254843	\N	{"value":"EK/egw599XnuQyus40gMx31yJyAkB60P2kgFA75k5WI=","salt":"GXDFQrKAqAzCQm3Ru7sDWQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
4ef372b9-851a-44b2-838d-2f2dda3ab6a5	\N	password	49dc8f5d-20e4-4bdc-a7e6-5b6a0a5c58cd	1712219570970	My password	{"value":"H7hqe9tZp1YYskZkeLX+JN741HdFJObqQNaiYAchNbQ=","salt":"IB2mhdcRX9xkAkVtHRNf2g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
07236e6c-863e-4e62-99c4-7459bb9ba6b5	\N	password	912061cc-34e7-4433-b9fc-ce64757dd35a	1709230085718	\N	{"value":"NQmNLTnv+ex2xeRCqrICP+QZPG6+26G0yCTfYLUMlpdiW5J00z0QbzHm13ueCPhmriEA0ceAp4OSvRwSazRkqQ==","salt":"KVJAVmFU5EmGLWzsDOEmUQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
c3d081af-4179-4722-92a6-cd40c4ce96d9	\N	password	3422392b-730f-4774-a81e-a68e56535bf0	1712665801275	My password	{"value":"Mbx1f7PSeHzYhE4c83/pbocpC16Ajk26M4rVrsAdUn9JhNxIXFF0o1PibcDsDbElnhLRksVyuURYM0FT0lr7uw==","salt":"x1qU8MGmzPtMiizXybmtPQ==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-02-29 18:07:49.118513	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	9230065418
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-02-29 18:07:49.360483	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	9230065418
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-02-29 18:07:49.548025	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	9230065418
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-02-29 18:07:49.568619	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9230065418
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-02-29 18:07:49.893435	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	9230065418
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-02-29 18:07:49.968105	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	9230065418
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-02-29 18:07:50.35389	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	9230065418
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-02-29 18:07:50.474402	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	9230065418
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-02-29 18:07:50.510803	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	9230065418
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-02-29 18:07:50.820878	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	9230065418
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-02-29 18:07:50.98708	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9230065418
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-02-29 18:07:51.032117	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9230065418
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-02-29 18:07:51.111404	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9230065418
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-29 18:07:51.158307	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	9230065418
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-29 18:07:51.162597	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9230065418
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-29 18:07:51.179513	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	9230065418
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-02-29 18:07:51.189688	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	9230065418
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-02-29 18:07:51.328456	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	9230065418
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-02-29 18:07:51.478331	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	9230065418
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-02-29 18:07:51.493424	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	9230065418
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-04-05 18:47:14.012288	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	2342833691
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-02-29 18:07:51.534087	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	9230065418
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-02-29 18:07:51.550013	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	9230065418
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-02-29 18:07:51.635747	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	9230065418
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-02-29 18:07:51.658235	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	9230065418
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-02-29 18:07:51.661182	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	9230065418
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-02-29 18:07:51.731845	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	9230065418
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-02-29 18:07:51.929674	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	9230065418
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-02-29 18:07:51.946914	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	9230065418
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-02-29 18:07:52.086524	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	9230065418
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-02-29 18:07:52.129199	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	9230065418
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-02-29 18:07:52.178244	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	9230065418
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-02-29 18:07:52.193056	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	9230065418
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-29 18:07:52.211837	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9230065418
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-29 18:07:52.224938	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	9230065418
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-29 18:07:52.304837	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	9230065418
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-02-29 18:07:52.318834	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	9230065418
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-02-29 18:07:52.32962	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9230065418
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-02-29 18:07:52.341142	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	9230065418
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-02-29 18:07:52.354083	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	9230065418
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-02-29 18:07:52.356433	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	9230065418
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-02-29 18:07:52.371203	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	9230065418
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-02-29 18:07:52.384396	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	9230065418
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-02-29 18:07:52.661393	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	9230065418
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-02-29 18:07:52.677559	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	9230065418
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-29 18:07:52.693453	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	9230065418
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-29 18:07:52.708432	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	9230065418
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-29 18:07:52.713259	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	9230065418
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-29 18:07:52.830341	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	9230065418
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-02-29 18:07:52.8465	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	9230065418
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-02-29 18:07:52.917338	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	9230065418
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-02-29 18:07:52.965117	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	9230065418
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-02-29 18:07:52.977184	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9230065418
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-02-29 18:07:52.985936	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	9230065418
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-02-29 18:07:52.999229	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	9230065418
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-29 18:07:53.021373	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	9230065418
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-29 18:07:53.030787	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	9230065418
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-29 18:07:53.083376	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	9230065418
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-02-29 18:07:53.395949	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	9230065418
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-02-29 18:07:53.470631	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	9230065418
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-02-29 18:07:53.492958	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	9230065418
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-02-29 18:07:53.514421	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	9230065418
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-02-29 18:07:53.525094	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	9230065418
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-02-29 18:07:53.530254	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	9230065418
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-02-29 18:07:53.540668	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	9230065418
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-02-29 18:07:53.545137	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	9230065418
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-02-29 18:07:53.569502	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	9230065418
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-02-29 18:07:53.581148	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	9230065418
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-02-29 18:07:53.591856	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	9230065418
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-02-29 18:07:53.626593	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	9230065418
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-02-29 18:07:53.64207	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	9230065418
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-02-29 18:07:53.661625	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	9230065418
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-29 18:07:53.685313	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9230065418
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-29 18:07:53.709681	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9230065418
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-29 18:07:53.719033	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9230065418
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-29 18:07:53.785316	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	9230065418
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-02-29 18:07:53.79853	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	9230065418
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-29 18:07:53.803256	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	9230065418
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-29 18:07:53.806854	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	9230065418
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-29 18:07:53.882452	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	9230065418
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-02-29 18:07:53.895048	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	9230065418
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-29 18:07:53.917763	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	9230065418
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-29 18:07:53.919836	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9230065418
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-29 18:07:53.932148	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9230065418
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-29 18:07:53.940136	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9230065418
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-02-29 18:07:53.959053	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9230065418
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-02-29 18:07:53.967114	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	9230065418
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-02-29 18:07:53.992842	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	9230065418
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-02-29 18:07:54.01962	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	9230065418
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.034612	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	9230065418
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.051491	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	9230065418
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.076296	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9230065418
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.095498	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	9230065418
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.097904	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	9230065418
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.131075	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	9230065418
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.14268	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	9230065418
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-02-29 18:07:54.161523	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	9230065418
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-29 18:07:54.184435	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9230065418
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-29 18:07:54.187909	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9230065418
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-29 18:07:54.216912	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9230065418
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-29 18:07:54.227198	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9230065418
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-29 18:07:54.23082	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9230065418
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-29 18:07:54.244614	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	9230065418
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-02-29 18:07:54.255901	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	9230065418
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-02-29 18:07:54.273698	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	9230065418
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-02-29 18:07:54.287208	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	9230065418
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-02-29 18:07:54.296348	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	9230065418
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-02-29 18:07:54.30988	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	9230065418
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-02-29 18:07:54.322422	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	9230065418
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-02-29 18:07:54.325964	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	9230065418
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-02-29 18:07:54.353259	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9230065418
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-02-29 18:07:54.368023	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	9230065418
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-02-29 18:07:54.403552	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	9230065418
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-02-29 18:07:54.418751	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	9230065418
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-02-29 18:07:54.436059	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	9230065418
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-02-29 18:07:54.445401	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	9230065418
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-02-29 18:07:54.471991	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	9230065418
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-02-29 18:07:54.487321	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9230065418
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-04-05 18:47:13.959556	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	2342833691
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-04-05 18:47:14.047437	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2342833691
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-04-05 18:47:14.071365	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2342833691
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-04-05 18:47:14.100577	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	2342833691
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-04-05 18:47:14.108342	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2342833691
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-04-05 18:47:14.11688	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	2342833691
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
2a297db7-66c5-448b-80fc-9d7d0ffecd68	c8a33997-8823-4a02-b1ec-b4e8cf444785	f
2a297db7-66c5-448b-80fc-9d7d0ffecd68	fed6f2c5-d144-414c-89e3-4a1564d44fb4	t
2a297db7-66c5-448b-80fc-9d7d0ffecd68	dbc56f8d-7bfc-4add-aa73-c6684541fcf4	t
2a297db7-66c5-448b-80fc-9d7d0ffecd68	33623af0-f6fb-456c-9ac8-fefec09a5975	t
2a297db7-66c5-448b-80fc-9d7d0ffecd68	05007875-b461-4fb4-a857-e98f323ad7db	f
2a297db7-66c5-448b-80fc-9d7d0ffecd68	42968e1f-162c-4070-a14e-ab26a2fdca10	f
2a297db7-66c5-448b-80fc-9d7d0ffecd68	a8cfd613-c92a-4985-92e0-8263b445d3d7	t
2a297db7-66c5-448b-80fc-9d7d0ffecd68	776e9199-fc33-436e-b47a-02c26f88c84e	t
2a297db7-66c5-448b-80fc-9d7d0ffecd68	d8d2107d-35cc-48ef-95bb-66c9cb49df97	f
2a297db7-66c5-448b-80fc-9d7d0ffecd68	068aeb71-d5ea-452f-8d6a-b4a1aca0b784	t
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	3b557e1f-a258-4183-9a88-57af50977fda	f
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	47679dcf-1005-4b40-a1da-8569d08d95dc	t
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1a18fc4e-219a-49b5-aefa-ed1085eb04ea	t
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	af365cb4-27ce-492e-8ce7-d78dc7fab611	t
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	d28a310c-1f68-4a35-9669-6a30361b3cf8	f
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	e2427baf-a533-4c32-8902-fd7fa554bd29	f
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda	t
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	e0648e33-f320-41bc-abaa-1fd40d2c588d	t
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	2375f6b6-ba7e-4dfb-9b2a-f74033043de8	f
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	e75ccea0-a73c-4548-ade2-b600d688bd3f	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	118057195799152264159	thanhthu10102006@gmail.com	\N	eb3891ad-af4e-404e-acdc-8a6e6645d00e
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	104289106272037548025	withlovemootita@gmail.com	\N	4cd7f002-398b-4fad-bc3e-f7b6fec12717
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	100479055513971186275	nguyenvominhhieu182@gmail.com	\N	b03895ae-38ba-4f7c-9b43-79d262aa24e6
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	109742196251821494794	phamnguyenhoang.quan.1412@gmail.com	\N	57ea0847-70d8-4e5c-9eae-64846dc5e650
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	115305796972478240038	luongvu.work@gmail.com	\N	234f0d42-9390-4bcc-9303-da4a5dec1e42
microsoft	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	86a663f3b579a02c	richardvu.work@gmail.com	\N	931c7385-5590-437e-bd57-3e703c5ce395
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	107507442299169937526	richardvu.work@gmail.com	\N	931c7385-5590-437e-bd57-3e703c5ce395
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	104252751069420241668	duyduydz13@gmail.com	\N	7c5787ae-3ded-4397-8677-af6b26be94a2
microsoft	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	dab327bb-8dd4-4c4b-b6c5-326b4462e1aa	ct06n0116@actvn.edu.vn	\N	7a7e1939-00d1-4665-836c-d375564021d1
microsoft	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	dbe01e57-07de-4a13-8d65-a8d4b66430bb	ct06n0130@actvn.edu.vn	\N	106206fa-4e0c-4899-b9f1-8cb10dd2050e
microsoft	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	7dc9ab00-46a4-436f-aec8-602a8bee465b	ct06n0110@actvn.edu.vn	\N	90363e29-158c-4ab3-b917-313d3df0d5f7
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	111360646318490639273	vutien.dat.3601@gmail.com	\N	3422392b-730f-4774-a81e-a68e56535bf0
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	108773760352291125239	andinhtran123@gmail.com	\N	5e1ad023-6821-4a3e-88c2-7e426c3a7256
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	113338528810047228327	hungtaithe12@gmail.com	\N	5d9ae386-bdf1-4376-bac7-908a83b36383
microsoft	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	984f070f-735d-41d0-a617-ba5c28d97cf0	ct06n0122@actvn.edu.vn	\N	015d41a6-c043-4d5f-bac0-e98b0b883cb6
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	113535069920122427384	accdetest01@gmail.com	\N	2d455703-6b41-47ea-a01e-cfaf72361d0b
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	109889046354992070805	khuongdavid111@gmail.com	\N	3049d4e1-dd32-4e9c-957d-66a1693f5ae5
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	113339088022101235756	kjnwjnpham@gmail.com	\N	0608edd4-ef17-4c1b-9b17-95adbdf727cf
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	107759226644840364663	huynhphatsn@gmail.com	\N	fa3c22d7-66ff-4ba0-941f-948c28537b8c
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	106594437173297376492	thuhuynh10206@gmail.com	\N	4407d91f-4cf5-4e5e-9795-e2aa82132956
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	106584462589638690137	nguyennam080800@gmail.com	\N	2d4767f0-5f64-4ecd-bf5c-48e272f524ef
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	111110587602027277151	ipquylinh@gmail.com	\N	eb53e6d4-047e-446b-b813-40cba456ffd3
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	114231685095350174299	nguyenducquyen2603@gmail.com	\N	219249e3-eaf0-48c8-9fa4-88448140bead
google	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	118274241136968328507	lebao210203@gmail.com	\N	5ea6bcdb-be42-4db4-b42e-f1290319718d
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
7f7774c7-4177-4f50-9cc2-626cabe4070d	t	google	google	f	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f	t	f3627af4-2b64-4a60-be1d-c93f7cf99814	\N	\N	f
9258d9c2-3b45-408a-ac23-97896593405d	t	microsoft	microsoft	f	f	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f	t	f3627af4-2b64-4a60-be1d-c93f7cf99814	\N	\N	f
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
9258d9c2-3b45-408a-ac23-97896593405d	false	hideOnLoginPage
9258d9c2-3b45-408a-ac23-97896593405d	5f9c2098-e8da-464f-bc73-ef7123140364	clientId
9258d9c2-3b45-408a-ac23-97896593405d	false	acceptsPromptNoneForwardFromClient
9258d9c2-3b45-408a-ac23-97896593405d	false	disableUserInfo
9258d9c2-3b45-408a-ac23-97896593405d	false	filteredByClaim
9258d9c2-3b45-408a-ac23-97896593405d	IMPORT	syncMode
9258d9c2-3b45-408a-ac23-97896593405d	g.z8Q~KNEwezBhjMrzybYH3943g~-skfW6k4kaua	clientSecret
9258d9c2-3b45-408a-ac23-97896593405d	1	guiOrder
7f7774c7-4177-4f50-9cc2-626cabe4070d	false	hideOnLoginPage
7f7774c7-4177-4f50-9cc2-626cabe4070d	true	offlineAccess
7f7774c7-4177-4f50-9cc2-626cabe4070d	false	acceptsPromptNoneForwardFromClient
7f7774c7-4177-4f50-9cc2-626cabe4070d	14259924623-ds5v0d7mi1167dccnvpbtb39pui1nc9j.apps.googleusercontent.com	clientId
7f7774c7-4177-4f50-9cc2-626cabe4070d	false	disableUserInfo
7f7774c7-4177-4f50-9cc2-626cabe4070d	false	filteredByClaim
7f7774c7-4177-4f50-9cc2-626cabe4070d	IMPORT	syncMode
7f7774c7-4177-4f50-9cc2-626cabe4070d	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	clientSecret
7f7774c7-4177-4f50-9cc2-626cabe4070d	0	guiOrder
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
03b4f2f0-178f-4047-8f78-437ee26c4f15	avatar	google	google-user-attribute-mapper	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c
e6dd5750-02b5-4dec-b2c8-6f04a638443a	avatar	microsoft	microsoft-user-attribute-mapper	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
03b4f2f0-178f-4047-8f78-437ee26c4f15	INHERIT	syncMode
03b4f2f0-178f-4047-8f78-437ee26c4f15	picture	jsonField
e6dd5750-02b5-4dec-b2c8-6f04a638443a	INHERIT	syncMode
e6dd5750-02b5-4dec-b2c8-6f04a638443a	picture	jsonField
e6dd5750-02b5-4dec-b2c8-6f04a638443a	avatar	userAttribute
03b4f2f0-178f-4047-8f78-437ee26c4f15	picture	userAttribute
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
0cdd42b3-92f0-4462-933e-193096de1054	2a297db7-66c5-448b-80fc-9d7d0ffecd68	f	${role_default-roles}	default-roles-master	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N	\N
53b669be-79f4-458c-af64-e3907ddea213	2a297db7-66c5-448b-80fc-9d7d0ffecd68	f	${role_admin}	admin	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N	\N
994dd118-8ebc-40ed-b677-4105d6f21798	2a297db7-66c5-448b-80fc-9d7d0ffecd68	f	${role_create-realm}	create-realm	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N	\N
2d1b0616-187b-4dac-8e38-8a041aed671d	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_create-client}	create-client	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
49e1875a-b891-4cba-8202-fd64d23c0aa3	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_view-realm}	view-realm	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
9c9cdc62-e032-494c-86e7-063f54004637	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_view-users}	view-users	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
5b4759c5-83b8-4501-a01a-6abb3bc7b019	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_view-clients}	view-clients	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
8b1d4f85-8583-43dc-8466-176e314c8998	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_view-events}	view-events	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
cf36dc16-c0d0-4e70-ae82-d961ce054da2	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_view-identity-providers}	view-identity-providers	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
687583d0-87af-4a28-98f1-35405fd39c32	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_view-authorization}	view-authorization	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
a468989b-8e5b-4057-a22d-27e482e1578d	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_manage-realm}	manage-realm	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
dd413582-a5ab-4188-b8da-0441f768e87e	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_manage-users}	manage-users	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
0356394d-ccde-4c6d-9598-a1e0b8a9d162	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_manage-clients}	manage-clients	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
85a63fa3-021e-4696-ae29-1868c4c68e9e	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_manage-events}	manage-events	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
67d02b05-3a26-4357-ad15-1d8398eff80b	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_manage-identity-providers}	manage-identity-providers	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
f13bca44-46e6-43fe-a1f7-59cee3acac62	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_manage-authorization}	manage-authorization	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
31cb123a-5d61-466e-8dad-1cb0fe1361a4	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_query-users}	query-users	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
84b240f7-fa0a-4c9d-8d78-fea44e1d833a	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_query-clients}	query-clients	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
de25733d-0145-4528-a771-953602d77236	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_query-realms}	query-realms	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
1ae89d8d-5ab3-4292-9d21-da9ae165d9a2	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_query-groups}	query-groups	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
c1d5bb7f-4957-42d6-b13e-091edda49ca7	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_view-profile}	view-profile	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
5028226d-1974-4fec-a42f-31c31f96701b	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_manage-account}	manage-account	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
f4ba6609-a55e-4b55-82a4-bb49fe114efe	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_manage-account-links}	manage-account-links	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
8f64e244-1872-483c-936a-5166d39fc4ab	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_view-applications}	view-applications	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
a29d464d-d634-4364-92cb-2862f8becf57	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_view-consent}	view-consent	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
726a758e-f9c5-4611-a8ff-bdfccdeaa206	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_manage-consent}	manage-consent	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
01b14307-4880-4e12-b9a8-1abc11a05482	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_view-groups}	view-groups	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
8db8fb9b-49c2-473b-a77b-a7aac5250dc0	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	t	${role_delete-account}	delete-account	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	\N
e601e572-3cd4-44d6-af33-9118d93edbad	98e1f74a-f741-49b8-a6fe-471faeacbf86	t	${role_read-token}	read-token	2a297db7-66c5-448b-80fc-9d7d0ffecd68	98e1f74a-f741-49b8-a6fe-471faeacbf86	\N
492c68ec-a51b-461c-a9fc-8607f76b5bb0	fa100695-6a07-4106-8855-8672a32a12ef	t	${role_impersonation}	impersonation	2a297db7-66c5-448b-80fc-9d7d0ffecd68	fa100695-6a07-4106-8855-8672a32a12ef	\N
6db8c1f0-503e-4f08-9480-447e4ec7de33	2a297db7-66c5-448b-80fc-9d7d0ffecd68	f	${role_offline-access}	offline_access	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N	\N
e8646388-7147-4706-bb46-dca39b621d34	2a297db7-66c5-448b-80fc-9d7d0ffecd68	f	${role_uma_authorization}	uma_authorization	2a297db7-66c5-448b-80fc-9d7d0ffecd68	\N	\N
5eb9be7a-4c63-41c8-8720-af3203a01554	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f	${role_default-roles}	default-roles-beatbuddy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N	\N
1d708059-fea2-4da3-867a-00b687b95149	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_create-client}	create-client	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
87c40bcb-42ba-4bcd-8e4e-80a97f07d9a0	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_view-realm}	view-realm	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
9aa35a10-047d-4e1c-b401-f3f384adf0d3	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_view-users}	view-users	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
16ea30dd-aef8-4c25-971a-65249777a09d	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_view-clients}	view-clients	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
7e146706-628e-4d02-a3b0-84398d480672	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_view-events}	view-events	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
3b15e2c7-377b-4aaa-a4fa-2479f30ba60e	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_view-identity-providers}	view-identity-providers	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
f8d22d5c-b5ab-419e-9676-16f12d9cce65	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_view-authorization}	view-authorization	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
f3009026-8ab1-4638-9d4b-e0a7a9299618	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_manage-realm}	manage-realm	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
b1f8ddc7-12de-46fe-8c7c-3bd5f80e4dc4	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_manage-users}	manage-users	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
840db824-c087-42dd-9f87-43b6c4670c4e	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_manage-clients}	manage-clients	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
a694c843-577e-4344-a074-f733e1600197	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_manage-events}	manage-events	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
3fb51f28-683a-4631-b649-521ce4e1d9c7	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_manage-identity-providers}	manage-identity-providers	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
ee6e08b3-4e31-4401-b12a-236b0c09d277	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_manage-authorization}	manage-authorization	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
b961753f-e7d4-4daa-8e21-b7b121ecb7c9	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_query-users}	query-users	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
25b521f9-d8b9-4a9a-8176-99f04c8f1f40	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_query-clients}	query-clients	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
7c9bcb90-b7d8-4c01-b934-998d7f29a8ef	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_query-realms}	query-realms	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
a16bbe7e-8167-488c-8ac5-56ff9c3fa647	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_query-groups}	query-groups	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
e632c6e1-8780-48c2-8adc-61e6c56910a0	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_realm-admin}	realm-admin	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
11c0b7d7-686f-4cc9-8a7d-569b477d681a	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_create-client}	create-client	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
3212a2ac-2115-407f-a613-d560e62b4e90	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_view-realm}	view-realm	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
9ab98715-77c7-4353-a696-3bbd41d1d2e5	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_view-users}	view-users	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
8713e091-9b5c-45e1-b036-8be0902a1fb2	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_view-clients}	view-clients	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
4c4eb9fa-51dc-4546-ac5a-60f9b85997c7	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_view-events}	view-events	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
f42001ca-7085-4f19-90c4-51d21bd8c05c	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_view-identity-providers}	view-identity-providers	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
0d8e1004-593d-4890-a193-37b6db371148	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_view-authorization}	view-authorization	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
8d3667f2-740c-4fd7-832d-beef26bffda1	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_manage-realm}	manage-realm	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
990521cb-e322-4963-9e29-8919c2f3b664	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_manage-users}	manage-users	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
31ac0c8e-e05b-448e-894a-699bbfdfd6bc	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_manage-clients}	manage-clients	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
e6043f68-8468-4bb5-a425-dafdc5c343f4	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_manage-events}	manage-events	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
5e191395-75d9-4f2b-adb5-3e5762fe6db5	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_manage-identity-providers}	manage-identity-providers	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
030856d3-f970-490f-b3d3-7de928e244a7	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_manage-authorization}	manage-authorization	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
7c2ecdb6-8668-4083-83da-209e250ee13d	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_query-users}	query-users	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
fefd8617-ec3d-43f9-8bdb-872986f76e8b	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_query-clients}	query-clients	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
045828b7-4f47-472e-989e-7c83ca900997	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_query-realms}	query-realms	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
ce556194-f89d-4d29-86da-d2e57b511e5f	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_query-groups}	query-groups	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
c13110a7-b8e8-4738-915b-86f827631c28	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_view-profile}	view-profile	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
abb5ff64-44a4-4def-88ae-78678f40d8c8	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_manage-account}	manage-account	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
1a7b1a3c-57a9-47eb-8a8f-97c6aee63023	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_manage-account-links}	manage-account-links	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
fcffe263-eb68-4cd2-aa60-2d7c587e4cc2	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_view-applications}	view-applications	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
4a94633a-903b-487b-a132-04f7692a321a	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_view-consent}	view-consent	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
8265531e-5fbe-436e-befd-ba58940b6955	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_manage-consent}	manage-consent	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
56f92204-23dd-4985-98f0-7ab36a1d574b	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_view-groups}	view-groups	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
1e6d6264-7c1a-40fd-a44a-83d6288756c2	959a6f97-3f51-459e-928a-1f8d01ffb9ea	t	${role_delete-account}	delete-account	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	959a6f97-3f51-459e-928a-1f8d01ffb9ea	\N
8425212e-6808-4938-a817-827887f478cd	cc97d42e-a486-4687-8259-8121218c6a01	t	${role_impersonation}	impersonation	2a297db7-66c5-448b-80fc-9d7d0ffecd68	cc97d42e-a486-4687-8259-8121218c6a01	\N
7dd0b03d-524a-419c-9404-be493bc64142	eecd06c1-cff6-4883-bd05-1e4fefca991c	t	${role_impersonation}	impersonation	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	eecd06c1-cff6-4883-bd05-1e4fefca991c	\N
42ff40a4-a6a1-4763-9733-83696524b16f	a3a878c5-eec3-42c2-a568-3828a8fcfc02	t	${role_read-token}	read-token	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	a3a878c5-eec3-42c2-a568-3828a8fcfc02	\N
f48b3cd7-fd1a-4273-b3a6-2f6615df7b95	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f	${role_offline-access}	offline_access	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N	\N
208a1e1c-4f71-43df-a781-501042379b99	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f	${role_uma_authorization}	uma_authorization	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N	\N
69dde0b4-e6fd-477e-bc95-5d19b57eeefe	d1187be3-8efe-4de2-aa98-be80379464e0	t	\N	uma_protection	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	d1187be3-8efe-4de2-aa98-be80379464e0	\N
c0436058-fff8-4bf5-8308-31016ca87604	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f		catalog	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	\N	\N
3e1b9ebc-203b-42fb-ad2c-d8a9c4f8684a	61752460-3001-450d-b7ee-ff9b6d1aeae5	t	\N	uma_protection	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	61752460-3001-450d-b7ee-ff9b6d1aeae5	\N
dfb10299-089e-4d20-8f34-3f151e59c4c4	50bed23d-759e-487d-b1ea-6ac18dc59811	t	\N	uma_protection	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.migration_model (id, version, update_time) FROM stdin;
023pk	23.0.7	1709230075
v7p4k	24.0.2	1712342837
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
1e2b66df-dd08-43ec-87ff-814408e97e5e	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712391097	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1712391097","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"61ZUiazfVi57","scope":"openid profile email offline_access","SSO_AUTH":"true","userSessionStartedAt":"1712390517","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"r6VbVzHcDQkrKo2I","code_challenge":"smzGbkwuKgLRSMcYMtEgpbmoBvrDikdaH8EJ3uwEv_8"}}	local	local
317cae3e-0bb2-4d85-88fe-85c00d22bb19	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712391602	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1712391602","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"KG2J0pZzrF3s","scope":"openid profile email offline_access","userSessionStartedAt":"1712391602","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"jHDWxgdFThOgw78N","code_challenge":"j8ioj8pxkFUe1PIQ_IOgywpcEbaqFymHLmA8KX8kjBo"}}	local	local
17c46ef2-58df-4169-8ef7-79a4dc7f88fe	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712448406	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1712448405","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"BERW4wuLmvwd","scope":"openid profile email offline_access","userSessionStartedAt":"1712448405","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"zMeRhU3bwR7isHd4","code_challenge":"_4YxrH91t4_qORhX7_vJO5KYcqkSGFdZpKHHGIdasT4"}}	local	local
61798b33-4729-429d-8e74-cb66c0b393ad	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712572803	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1712572802","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"wI1CBckXTGHv","scope":"openid profile email offline_access","userSessionStartedAt":"1712572802","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"m1sXbPuJqLLUtno9","code_challenge":"2BsUyIb5so8J2IpHRR2pDQnKZC09WXL25iVPctvIl1Q"}}	local	local
36a46152-c6d7-483b-b025-d9da78b5ce7b	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712668291	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1712668291","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"tvAa9TaaiBIp","scope":"openid profile email offline_access","userSessionStartedAt":"1712668291","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"0UdbhTTOJWUeyGRP","code_challenge":"jbuO3zyeGk55kTPYusYaCEsEKPwjtXxnG7_mfggVBhc"}}	local	local
a8759b15-bf7c-49a8-8ad5-3a9da4b610d0	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1710667729	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","BROKER_NONCE":"5HkKO92VdpDoXbuuFVujUw","startedAt":"1710667729","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"zR9NQwQXOD6d","scope":"openid profile email offline_access","userSessionStartedAt":"1710667729","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"uvrnFf7TC4JHJ1q6","code_challenge":"Fym0x4d8YjGHE24nZfYT3Hsa9cJO-HGkD8BKLCIfX_U"}}	local	local
036a3347-1007-4328-900a-15aaf08e17ee	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1710745255	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1710745255","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"C8Rw55B4hgBb","scope":"openid profile email offline_access","userSessionStartedAt":"1710745255","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"Cjo6S1EvKVKaDGXA","code_challenge":"texy19JNPYSd5HJ7PG-4q4q8aRpai0RX_Ax2h5YcFe8"}}	local	local
eddcd188-2047-40c4-bcb9-79cbdf027940	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1710814168	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","BROKER_NONCE":"q1LnzHjchcFZOkA85WKQZQ","startedAt":"1710814168","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"BOjzTAaChT6N","scope":"openid profile email offline_access","userSessionStartedAt":"1710814168","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"LYlMmJugrW3vcnW9","code_challenge":"-N5PLYGSne74cyVqQ7dn9FTswquauvL8re5LsqPPG6c"}}	local	local
f2b8621b-6eeb-4821-a71f-96d3d5d7b30f	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1710814700	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","BROKER_NONCE":"-wE1GAhkgkKXKEfcZbf1tQ","startedAt":"1710814700","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"svubF9bQbJxG","scope":"openid profile email offline_access","userSessionStartedAt":"1710814700","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"RNc72mI0NYYpTl7p","code_challenge":"lnugpZiPdj21Gk5oBnuANzPJPRpuhrJkfdF4m4RDEfQ"}}	local	local
16f8da5d-779f-45f0-bbc9-ffa25f374c5f	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712219579	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1712219579","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"F2HE7UNySOXV","scope":"openid profile email offline_access","userSessionStartedAt":"1712219579","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"lXSF3m07uBe0CDAO","code_challenge":"jPTaOK5sWtTtKnoq4XyFI1onnZmRZjjzi3eE8n_e_Dk"}}	local	local
4e425aca-ea8b-4062-ad02-b6c26e62a84b	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712227084	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","BROKER_NONCE":"2HISihnAJh1lsYwXbj4-vw","startedAt":"1712227084","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"194yRCTsER0d","scope":"openid profile email offline_access","userSessionStartedAt":"1712227084","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"8bElFWzStCzdxowQ","code_challenge":"ZooBEO9p4uM3hvc-t5yPJ-Jwm821oerxr822AuHvIsE"}}	local	local
4b20ab0b-547b-41ad-93ed-42d2c15fb292	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712228636	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","BROKER_NONCE":"bs-kY8L8IlmWLRJf_oulng","startedAt":"1712228636","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"GUdZ0XiDzJ7S","scope":"openid profile email offline_access","userSessionStartedAt":"1712228636","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"kf4AUAQ3AfawFHTC","code_challenge":"xGowrrs7iOJOVuJAXsOEN3kROrM8eJH8MsxToKA0olQ"}}	local	local
72bdb3f8-617a-4de5-9ca8-abb3356b7aee	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712312796	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","BROKER_NONCE":"sFc7SAnDSnlLPudnKSjOug","startedAt":"1712312796","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"FFQ5D1egeWyC","scope":"openid profile email offline_access","userSessionStartedAt":"1712312796","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"P1Sj2vSkEi4TjWlF","code_challenge":"3NYbUWP8LEcPqq-_TQXi2gi9DTreJmeG0kCu2twBeUc"}}	local	local
358c4a8c-4fee-436f-b2e8-04d7ff1756b3	7c0a850a-6743-4cee-ac92-a5159f7da291	1	1712390603	{"authMethod":"openid-connect","redirectUri":"https://beatbuddy.io.vn/auth/callback","notes":{"clientId":"7c0a850a-6743-4cee-ac92-a5159f7da291","iss":"https://datvutech.io.vn/oauth/realms/beatbuddy","startedAt":"1712390602","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","nonce":"yVcWp4srdezU","scope":"openid profile email offline_access","userSessionStartedAt":"1712390602","redirect_uri":"https://beatbuddy.io.vn/auth/callback","state":"SFZiNBazhkyPljIR","code_challenge":"qWVAGM5N8nFvc0qtSKy-G3RG_a_v4VI-4hgUxY8zl-s"}}	local	local
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
1e2b66df-dd08-43ec-87ff-814408e97e5e	3422392b-730f-4774-a81e-a68e56535bf0	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712390517	1	{"ipAddress":"103.199.57.161","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjE2MSIsIm9zIjoiQW5kcm9pZCIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZSBNb2JpbGUvMTIzLjAuMCIsImRldmljZSI6IksiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOnRydWV9","AUTH_TIME":"1712390517","authenticators-completed":"{\\"dd154178-3405-4e72-8288-70689c46afa4\\":1712390517,\\"6560c12e-a3ac-4b11-bbab-4a5e42c66bab\\":1712391097}"},"state":"LOGGED_IN"}	1712398792
317cae3e-0bb2-4d85-88fe-85c00d22bb19	3422392b-730f-4774-a81e-a68e56535bf0	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712391602	1	{"ipAddress":"116.118.55.73","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTYuMTE4LjU1LjczIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiQ2hyb21lLzEyMy4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1712391602","authenticators-completed":"{\\"dd154178-3405-4e72-8288-70689c46afa4\\":1712391602}"},"state":"LOGGED_IN"}	1712393092
036a3347-1007-4328-900a-15aaf08e17ee	2d455703-6b41-47ea-a01e-cfaf72361d0b	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1710745255	1	{"ipAddress":"103.199.56.203","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU2LjIwMyIsIm9zIjoiV2luZG93cyIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkVkZ2UvMTIyLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1710745255"},"state":"LOGGED_IN"}	1710746971
17c46ef2-58df-4169-8ef7-79a4dc7f88fe	3422392b-730f-4774-a81e-a68e56535bf0	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712448405	1	{"ipAddress":"103.199.57.161","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjU3LjE2MSIsIm9zIjoiQW5kcm9pZCIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZSBNb2JpbGUvMTIzLjAuMCIsImRldmljZSI6IksiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOnRydWV9","AUTH_TIME":"1712448405","authenticators-completed":"{\\"dd154178-3405-4e72-8288-70689c46afa4\\":1712448405}"},"state":"LOGGED_IN"}	1712452194
a8759b15-bf7c-49a8-8ad5-3a9da4b610d0	eb53e6d4-047e-446b-b813-40cba456ffd3	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1710667729	1	{"brokerUserId":"google.111110587602027277151","ipAddress":"125.235.186.96","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_REFRESH_TOKEN":"1//0ecSm5SNXsQddCgYIARAAGA4SNwF-L9IrkWtzZqPtkTwrWKpwmSvt5PH2MlxyYeVb14D2WMRRQ-M37I2p-PFNEzfO9Lgd2kvAa_o","FEDERATED_TOKEN_EXPIRATION":"1710671328","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA5YmNmODAyOGUwNjUzN2Q0ZDNhZTRkODRmNWM1YmFiY2YyYzBmMGEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNDI1OTkyNDYyMy1kczV2MGQ3bWkxMTY3ZGNjbnZwYnRiMzlwdWkxbmM5ai5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjE0MjU5OTI0NjIzLWRzNXYwZDdtaTExNjdkY2NudnBidGIzOXB1aTFuYzlqLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTExMTEwNTg3NjAyMDI3Mjc3MTUxIiwiZW1haWwiOiJpcHF1eWxpbmhAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJNMkpIWElWaUM3b0dwNzlnVXotalBnIiwibm9uY2UiOiI1SGtLTzkyVmRwRG9YYnV1RlZ1alV3IiwibmFtZSI6IlF1w70gTGluaCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NLOExWMk9rRGUyWXdodUJ0Ymh3X3UtMWNYb1Y5NTByOTFINWJVV01adDlrQT1zOTYtYyIsImdpdmVuX25hbWUiOiJRdcO9IExpbmgiLCJsb2NhbGUiOiJ2aSIsImlhdCI6MTcxMDY2NzcyMCwiZXhwIjoxNzEwNjcxMzIwfQ.jiJcEXHvjdrYel7GiC2N97eVVZ-r32eR-6U-m44KG5T8yj0ti5S1KskJmi5KIHX88008HEaldTRSLHkDaeyVxfKp4ZcvWBFd8FDlkEIjoigThm74_4xPZr-__M5iQqD9_2RwocXGTB--oyC3Xrz-zSB5GsO-a7cMmMRMeV0dHP9QmyYByWl1FwYGOCNkbA-eD-QHRV-DvI8Zv_zNDkjPHWOYgjF0bMg-diGq8swlHblxu_TgVoHzDGqswuby6E7Z2qSHivQy2JnxO28UTsbTo9Q5n5Vee03GOYR4ydPCT1_ow848YJ5YZ3UOwlQnFjDY7fc682k85Jsm10P4pb79pw","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0Ad52N398VnPHCKvsEfd1yhAAVvO0jFWyLRDNsTTc1jBgG2nlmqwl3qdNq-q_a0_G8xcSVYnK5isytWIE-7GCIgiQ1nN0glWjE2oz7Xpa4ZNUm0WlfMggqr5zSq86uTkQd4NobkQ_GWHtkBc0vGIXSPLtyN3QiJYy_czkaCgYKAeoSARMSFQHGX2Mi9YbGS91IsQb14VocgzoKew0171","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjUuMjM1LjE4Ni45NiIsIm9zIjoiaU9TIiwib3NWZXJzaW9uIjoiMTYuMS4xIiwiYnJvd3NlciI6Ik1vYmlsZSBTYWZhcmkvMTYuMSIsImRldmljZSI6ImlQaG9uZSIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6dHJ1ZX0=","AUTH_TIME":"1710667729","identity_provider_identity":"ipquylinh@gmail.com"},"state":"LOGGED_IN"}	1710667729
eddcd188-2047-40c4-bcb9-79cbdf027940	219249e3-eaf0-48c8-9fa4-88448140bead	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1710814168	1	{"brokerUserId":"google.114231685095350174299","ipAddress":"125.235.209.43","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_REFRESH_TOKEN":"1//0ePa7BTtigxG3CgYIARAAGA4SNwF-L9IrzwyYC7_1hcm4eTl5Kh8apSOqqBy-p5KXOwigqsSm5WYVfCudWSMJKeIynM6pvadaXO8","FEDERATED_TOKEN_EXPIRATION":"1710817767","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA5YmNmODAyOGUwNjUzN2Q0ZDNhZTRkODRmNWM1YmFiY2YyYzBmMGEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNDI1OTkyNDYyMy1kczV2MGQ3bWkxMTY3ZGNjbnZwYnRiMzlwdWkxbmM5ai5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjE0MjU5OTI0NjIzLWRzNXYwZDdtaTExNjdkY2NudnBidGIzOXB1aTFuYzlqLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE0MjMxNjg1MDk1MzUwMTc0Mjk5IiwiZW1haWwiOiJuZ3V5ZW5kdWNxdXllbjI2MDNAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJYaHhUeG1tdTJKakMyWE1iWFljSDR3Iiwibm9uY2UiOiJxMUxuekhqY2hjRlpPa0E4NVdLUVpRIiwibmFtZSI6IlF1eeG7gW4gTmd1eeG7hW4iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSjI1NUM1eGh0cVB5bkc4SkRpeklaNzdnNjMwZ19vNGQ1VTNHMndheE5sYWc9czk2LWMiLCJnaXZlbl9uYW1lIjoiUXV54buBbiIsImZhbWlseV9uYW1lIjoiTmd1eeG7hW4iLCJpYXQiOjE3MTA4MTQxNjcsImV4cCI6MTcxMDgxNzc2N30.ZqdZDnh0INEMVgiP-rT98ABWY92xLuWF9NUVaYjTlY9MHXUCo7IRqYI2kXQIRR8TTrhFkS6zEJLT1bIhcsXzIoMJCaDRAkWtcRTu0p8BufZm7KBidpvUW33suvZqt_EFsVOz2bhbalC8Mb4J44K3EXSqKMAZHF_V1Lm_ZuYs0a6B_PjDv64bHpxYAav1FlZU2b8gwr9iNHnYbEfH0KpiHjs2vg7o8ps6cfa7GnNZjrYkeYw7BWLTkl1qu_QznBWXG9E1Nc-4_sbi3UmzsBo_PLekC8l7rvUPZlsTFTc_v-p70uXahzP1PJd45eH1_EdzyILp3_0FnRBNkBBLkxQ8Xg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0Ad52N3_7HuVHAVww72fbqPUA5cUP0fPBAuS3edWuV36CalB02ONPM5b77ZRAGgQj4Icn9Z721qem4zdG6mkWgtW6AFlZ-Px99u_OrpJMAmiq1yGRi4aIZagmUrEyLUcBtT41tJ7P8DNFEDHYzaqLJ2t9P8UI2DGzqhiSaCgYKAbkSARESFQHGX2Mi8NgVN9Npb0Xohe7pGR7UYg0171","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMjUuMjM1LjIwOS40MyIsIm9zIjoiQW5kcm9pZCIsIm9zVmVyc2lvbiI6IjEwIiwiYnJvd3NlciI6IkNocm9tZSBNb2JpbGUvMTIyLjAuMCIsImRldmljZSI6IksiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOnRydWV9","AUTH_TIME":"1710814168","identity_provider_identity":"nguyenducquyen2603@gmail.com"},"state":"LOGGED_IN"}	1710814594
f2b8621b-6eeb-4821-a71f-96d3d5d7b30f	5d9ae386-bdf1-4376-bac7-908a83b36383	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1710814700	1	{"brokerUserId":"google.113338528810047228327","ipAddress":"113.185.76.60","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1710818299","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjA5YmNmODAyOGUwNjUzN2Q0ZDNhZTRkODRmNWM1YmFiY2YyYzBmMGEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNDI1OTkyNDYyMy1kczV2MGQ3bWkxMTY3ZGNjbnZwYnRiMzlwdWkxbmM5ai5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjE0MjU5OTI0NjIzLWRzNXYwZDdtaTExNjdkY2NudnBidGIzOXB1aTFuYzlqLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTEzMzM4NTI4ODEwMDQ3MjI4MzI3IiwiZW1haWwiOiJodW5ndGFpdGhlMTJAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF0X2hhc2giOiJpTkJYOER3WWtYdlBhWmFyNDF2RFJ3Iiwibm9uY2UiOiItd0UxR0Foa2drS1hLRWZjWmJmMXRRIiwibmFtZSI6IkjDuW5nIEzDqiBYdcOibiIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NMdkZBbEJrdW9nckJIMlhvcl9IeGNITmJFbUluUEZVNGxMS2xCUmlvWDhzSzg9czk2LWMiLCJnaXZlbl9uYW1lIjoiSMO5bmciLCJmYW1pbHlfbmFtZSI6IkzDqiBYdcOibiIsImlhdCI6MTcxMDgxNDcwMCwiZXhwIjoxNzEwODE4MzAwfQ.kkhYQLuLOaVD4hp5gx3KDOdBXSGc9f2F0XeTqisoeaXq_-7mxCHqugp9enaZh0BBPfkfPTFLgsCaH8BIt5ytdJCEfLN230WBKTxo7fxEl-0BKCZTNU6CU1l3nqxoyW8YNWXJPS8JG2rKKAvFbTNN1iNa-udkO2CLYn2-xc0pYwj3kTA5uI9j2PBBoMyjKGFMy_8aRY99_QmXzchFfHiwmz31MILg9FoiYhy98qtBs1HmpWccKIwszaB3cfXmzNcEMaZy8zXN4dSmr8NHOKtB7RUUBy_WO1e4QRnrloZ-0m-dmx4p7LbUFIfcspd-tNQoTSYY6zRUEm0re9lBBf3Grg","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0Ad52N39V0my3f6MXn9eg4L7lLh6C9h7TD3Vt2GaBDXBal7ZpBiPiUsrJgP3nbwOsZVcJ6EaOaSjHNpRgTGLMcuOFP0kbf_RjcXokKQF-TQFT1andWPRqPCqjnZo8uwPohW7EHPI5BXr9L9uvVlekNfFE_UoAcoXuhnQaCgYKAdYSARESFQHGX2Min6aGaqpO22oo6ZwijBHdrA0170","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTMuMTg1Ljc2LjYwIiwib3MiOiJXaW5kb3dzIiwib3NWZXJzaW9uIjoiMTAiLCJicm93c2VyIjoiQ2hyb21lLzEyMi4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1710814700","identity_provider_identity":"hungtaithe12@gmail.com"},"state":"LOGGED_IN"}	1710814894
61798b33-4729-429d-8e74-cb66c0b393ad	3422392b-730f-4774-a81e-a68e56535bf0	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712572802	1	{"ipAddress":"103.199.33.204","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMDMuMTk5LjMzLjIwNCIsIm9zIjoiTGludXgiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkNocm9tZS8xMjMuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1712572802","authenticators-completed":"{\\"dd154178-3405-4e72-8288-70689c46afa4\\":1712572802}"},"state":"LOGGED_IN"}	1712572803
36a46152-c6d7-483b-b025-d9da78b5ce7b	3422392b-730f-4774-a81e-a68e56535bf0	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712668291	1	{"ipAddress":"116.118.61.137","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTYuMTE4LjYxLjEzNyIsIm9zIjoiTGludXgiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkNocm9tZS8xMjMuMC4wIiwiZGV2aWNlIjoiT3RoZXIiLCJsYXN0QWNjZXNzIjowLCJtb2JpbGUiOmZhbHNlfQ==","AUTH_TIME":"1712668291","authenticators-completed":"{\\"dd154178-3405-4e72-8288-70689c46afa4\\":1712668291}"},"state":"LOGGED_IN"}	1712669522
16f8da5d-779f-45f0-bbc9-ffa25f374c5f	49dc8f5d-20e4-4bdc-a7e6-5b6a0a5c58cd	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712219579	1	{"ipAddress":"171.240.141.198","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjQwLjE0MS4xOTgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTIzLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1712219579"},"state":"LOGGED_IN"}	1712220512
358c4a8c-4fee-436f-b2e8-04d7ff1756b3	3422392b-730f-4774-a81e-a68e56535bf0	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712390602	1	{"ipAddress":"116.118.55.73","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxMTYuMTE4LjU1LjczIiwib3MiOiJMaW51eCIsIm9zVmVyc2lvbiI6IlVua25vd24iLCJicm93c2VyIjoiQ2hyb21lLzEyMy4wLjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1712390602","authenticators-completed":"{\\"dd154178-3405-4e72-8288-70689c46afa4\\":1712390602}"},"state":"LOGGED_IN"}	1712391532
4e425aca-ea8b-4062-ad02-b6c26e62a84b	fa3c22d7-66ff-4ba0-941f-948c28537b8c	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712227084	1	{"brokerUserId":"google.107759226644840364663","ipAddress":"171.240.141.198","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1712230683","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjkzNGE1ODE2NDY4Yjk1NzAzOTUzZDE0ZTlmMTVkZjVkMDlhNDAxZTQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNDI1OTkyNDYyMy1kczV2MGQ3bWkxMTY3ZGNjbnZwYnRiMzlwdWkxbmM5ai5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjE0MjU5OTI0NjIzLWRzNXYwZDdtaTExNjdkY2NudnBidGIzOXB1aTFuYzlqLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA3NzU5MjI2NjQ0ODQwMzY0NjYzIiwiZW1haWwiOiJodXluaHBoYXRzbkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IndHSmtmazhJSEZJZEtUV2Y2Yl9xRWciLCJub25jZSI6IjJISVNpaG5BSmgxbHNZd1hiajQtdnciLCJuYW1lIjoiUGjDoXQgVOG6pW4iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSTBTSEVadjFwY1VtNEdYQjNCTWJSUGdCM1lpeWxSWTJMbDNXbWV1RjZabmtrYWRnSzA9czk2LWMiLCJnaXZlbl9uYW1lIjoiUGjDoXQiLCJmYW1pbHlfbmFtZSI6IlThuqVuIiwiaWF0IjoxNzEyMjI3MDgzLCJleHAiOjE3MTIyMzA2ODN9.SNxzd6zABc2Jg7PzfCVGeuwQ9Wp4vRtlhjxcxJqeI9LuLPNAmbtGHzZOhGeTr6NIBNoPVua8J_8PoQBV9-zfGG5OYJS2-1bffh1Q9_DITR0truLTx16nYdb4RfiRXjzrxF5AKT3j0ntem1sl1f6fCsNzWgwXmnM-Oh6cbuueAM-7GyvT0bmn5MkmtLu6WdBm4vVbHoD86YbAK_hAj223hxhP-ztvUMg7vBLcbCDV2vmMSDGhIqILv3lfRfpuGu0fYI9mdI7__ErnCEB7bgDcS6AUgL63tGvP9IGDKV_MB00yu_F9_2hDdGEAqV_vLrU5h6iBnv7RYEExyU7pYCdl0w","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0Ad52N3_1oMo2bnLub0qtAP16a7Mq8dzNadozrdWD5roW9NgIeM_aom-ICvJs4GPf1_trYabG03qjZ77tCFU7w8pSWQQoWOvDlJK4LNmJh9-FLbcUue88ThOmw31hkdT4T-hR2Mz6Af9cgR5TaS9wbcuQ5CbdKZeRH3DEaCgYKAeASARISFQHGX2MigyQ5u2jhkxaRcuYQJPEvKg0171","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjQwLjE0MS4xOTgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTIzLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1712227084","identity_provider_identity":"huynhphatsn@gmail.com"},"state":"LOGGED_IN"}	1712227652
4b20ab0b-547b-41ad-93ed-42d2c15fb292	fa3c22d7-66ff-4ba0-941f-948c28537b8c	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712228636	1	{"brokerUserId":"google.107759226644840364663","ipAddress":"171.240.141.198","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_TOKEN_EXPIRATION":"1712232235","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjkzNGE1ODE2NDY4Yjk1NzAzOTUzZDE0ZTlmMTVkZjVkMDlhNDAxZTQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNDI1OTkyNDYyMy1kczV2MGQ3bWkxMTY3ZGNjbnZwYnRiMzlwdWkxbmM5ai5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjE0MjU5OTI0NjIzLWRzNXYwZDdtaTExNjdkY2NudnBidGIzOXB1aTFuYzlqLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA3NzU5MjI2NjQ0ODQwMzY0NjYzIiwiZW1haWwiOiJodXluaHBoYXRzbkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IjdtYU4tSTM2UVA4eXBidVNMOFJVMmciLCJub25jZSI6ImJzLWtZOEw4SWxtV0xSSmZfb3VsbmciLCJuYW1lIjoiUGjDoXQgVOG6pW4iLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jSTBTSEVadjFwY1VtNEdYQjNCTWJSUGdCM1lpeWxSWTJMbDNXbWV1RjZabmtrYWRnSzA9czk2LWMiLCJnaXZlbl9uYW1lIjoiUGjDoXQiLCJmYW1pbHlfbmFtZSI6IlThuqVuIiwiaWF0IjoxNzEyMjI4NjM2LCJleHAiOjE3MTIyMzIyMzZ9.kVHEDiFyvE1T2NspJ707BZIfCU5OmmnwaxNHwOk2Oml3WiEkrqwWNncT1t_CiEkkXkpNPHrcN6mcS3hW_VfTTAiUbCbvtFX8qoLeneHeNDuPXov6ELq3FXTcLEpmOWRlFmXIImOwJAGtWyiSV4vJE8VcvTB15cbj3UH-wsnVl6KBsPHGp_Oqt431s3WRVLkmMke_oy2StOK8qcCUVnzQXbA5wWTK6nXd8ZBOI-uybE7_2zSvFDxbZ4xzP8aTDAhoWCXNmCm9_wBuTQYqxICuTfVwkMRC75tYBOrG2Km8rww6CKYEfyeBn_8U4sYHb7DnLAEAScrwIqdSFGggwUqMQA","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0Ad52N3-A4QJqyEGiGEYSJ-eMHWjRU0H85mvYZ4uOughZlvHcsclOXe3_SBiWJ9ZimJuKrgZrU1pp8SDY4BT6M0NT3VIzwY_zr1he1H7fvQFsa7YwbfkeFKeRyI--xayESrS87Pwe4TSyuqySqms10-0nKSLiY4f0RaSJaCgYKAYISARISFQHGX2MiqOBHDAx04N9D37SP-lEbrA0171","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjQwLjE0MS4xOTgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTIzLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1712228636","identity_provider_identity":"huynhphatsn@gmail.com"},"state":"LOGGED_IN"}	1712231072
72bdb3f8-617a-4de5-9ca8-abb3356b7aee	5ea6bcdb-be42-4db4-b42e-f1290319718d	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1712312796	1	{"brokerUserId":"google.118274241136968328507","ipAddress":"171.240.141.198","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"FEDERATED_REFRESH_TOKEN":"1//0ehqbWFhzqcIACgYIARAAGA4SNwF-L9Ir6koU8K__5O9q6aRZxm450k-guGLWA0YWj-nIDeHdRJAE3iQ9T2FyV-75PdTX369LeN8","FEDERATED_TOKEN_EXPIRATION":"1712316395","FEDERATED_ID_TOKEN":"eyJhbGciOiJSUzI1NiIsImtpZCI6IjkzNGE1ODE2NDY4Yjk1NzAzOTUzZDE0ZTlmMTVkZjVkMDlhNDAxZTQiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIxNDI1OTkyNDYyMy1kczV2MGQ3bWkxMTY3ZGNjbnZwYnRiMzlwdWkxbmM5ai5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjE0MjU5OTI0NjIzLWRzNXYwZDdtaTExNjdkY2NudnBidGIzOXB1aTFuYzlqLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTE4Mjc0MjQxMTM2OTY4MzI4NTA3IiwiZW1haWwiOiJsZWJhbzIxMDIwM0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6ImU5dEMwLVRlZFZsTk5oWTRoVG5VcWciLCJub25jZSI6InNGYzdTQW5EU25sTFB1ZG5LU2pPdWciLCJuYW1lIjoiQuG6o28gTMOqIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tGU3VycHY1Y2NiN2xhZVJiMHV6Y2p4QWhRNmxueGZMbDhsMS0wWnBPcXgyZnc0VE09czk2LWMiLCJnaXZlbl9uYW1lIjoiQuG6o28iLCJmYW1pbHlfbmFtZSI6IkzDqiIsImlhdCI6MTcxMjMxMjc5NiwiZXhwIjoxNzEyMzE2Mzk2fQ.bKkCkUBkJZ8nECEvfL0zv6SZI0wy7_5b41al2Aa2suQd0UmXG7aogIPbOvBuwHsvFPb2OPknEyDDW7eL5-Z8Lb_PnR2w6NidbpgSREIBJUVlxiNddVQjesfcMor70k95skejE7twnhKSYgnjAMe2NtdK_l1Pde4vQfpPfzwzDqV2ncttBC6615qvoWQWoulGrvxm5dhaRr6i47-KO2InStE-QkFenJhL1jxqUAqgS6COtxiv7Ux1vRfpGT5x0xlhq8rT0wfkRwZ_49bO903N1HgKPjce8VYY-oS0VefC9C9penTNi08ISu5ArkD4axEdE1INpH5WrGHlPIUxZaDuJQ","identity_provider":"google","FEDERATED_ACCESS_TOKEN":"ya29.a0Ad52N3_pZwkt04kkC9-vqY6EeR1g3CxzZC517i1ttcqonSFyydQ91tvTz5WjSxlX5lsvG3Ztb0FUPL6IWE-IX0Sv6BRxz68rk8lPuxEpsS0vDYvQDCQywh9AbvH2gv1kXs86n48_uMaFqrINmLh46rHlxAcyvcR2N6RfaCgYKAUASARMSFQHGX2Mi2yNwwQkWJLZVxKzFL7AwaA0171","KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzEuMjQwLjE0MS4xOTgiLCJvcyI6IldpbmRvd3MiLCJvc1ZlcnNpb24iOiIxMCIsImJyb3dzZXIiOiJDaHJvbWUvMTIzLjAuMCIsImRldmljZSI6Ik90aGVyIiwibGFzdEFjY2VzcyI6MCwibW9iaWxlIjpmYWxzZX0=","AUTH_TIME":"1712312796","identity_provider_identity":"lebao210203@gmail.com"},"state":"LOGGED_IN"}	1712312796
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
28efea65-0e3a-4204-a743-7c89e5947024	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
cf275b33-579b-40dc-9b25-e647d8b60130	defaultResourceType	urn:kmashopapp:resources:default
ba5c96f2-9954-45ac-b881-0e0394d944ea	clients	["653b5484-afde-49bc-b7ef-30ad0e436b9e"]
43475189-4811-4a7e-b7bb-8dda49db566b	roles	[{"id":"c0436058-fff8-4bf5-8308-31016ca87604","required":true}]
681b7462-7c70-4f50-9c07-901d7733b3f3	defaultResourceType	beatbuddy:playlist
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
c63cf885-8d15-42cd-846d-ca5724814b0a	audience resolve	openid-connect	oidc-audience-resolve-mapper	e42f0f38-dd87-4140-999e-d9af160f6ef0	\N
45d02022-7d9e-4131-b293-219a894d2020	locale	openid-connect	oidc-usermodel-attribute-mapper	0fbdf72f-3d4e-48f7-8a22-d4497600516d	\N
33a3f43f-ca76-4758-8fe9-b5dfa73aa129	role list	saml	saml-role-list-mapper	\N	fed6f2c5-d144-414c-89e3-4a1564d44fb4
ef542b88-ca43-4680-b9f2-4018bb8d2739	full name	openid-connect	oidc-full-name-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
8555aa71-eec3-431c-a767-e51fbbe864ef	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
286cdab9-eaa2-4448-b5d8-fe016650a4c8	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
14dc2c7a-3b10-40d2-b78b-38edf781a532	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
326152ff-4767-4d26-a4f3-6fadd5234d81	username	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
81210e23-2052-457c-8aef-485c82aa713b	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
1150cee3-83a3-4640-8da2-6ffc462eaebc	website	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
c37034f5-c11b-4af2-8c0d-abe4011930ad	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
50435205-4278-4345-9493-9b91112325e9	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
f1af6b03-4f84-474f-bed4-eb8685c9c294	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	dbc56f8d-7bfc-4add-aa73-c6684541fcf4
6cbb0432-5217-441a-b662-81d09d44a762	email	openid-connect	oidc-usermodel-attribute-mapper	\N	33623af0-f6fb-456c-9ac8-fefec09a5975
05ee1d41-053d-4575-a5de-31585bae6627	email verified	openid-connect	oidc-usermodel-property-mapper	\N	33623af0-f6fb-456c-9ac8-fefec09a5975
6759f6af-614b-43ae-a2b5-e586ba8385a7	address	openid-connect	oidc-address-mapper	\N	05007875-b461-4fb4-a857-e98f323ad7db
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	42968e1f-162c-4070-a14e-ab26a2fdca10
840934ab-eb48-4136-a2d7-7eb3a06f7b57	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	42968e1f-162c-4070-a14e-ab26a2fdca10
fc3eab36-6b62-4879-a60e-e43170e81133	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a8cfd613-c92a-4985-92e0-8263b445d3d7
ff3fb04c-3cd9-47bd-b577-c06f8af8f610	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a8cfd613-c92a-4985-92e0-8263b445d3d7
895bfe1a-ecde-444c-865f-336f0cde455e	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a8cfd613-c92a-4985-92e0-8263b445d3d7
94e07110-2d46-4141-bc00-4f283f132fa6	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	776e9199-fc33-436e-b47a-02c26f88c84e
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	d8d2107d-35cc-48ef-95bb-66c9cb49df97
7775e8dd-29ff-4291-be96-1478a6685f35	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	d8d2107d-35cc-48ef-95bb-66c9cb49df97
88a1de12-bf0c-4526-8bff-b47ec39a2932	acr loa level	openid-connect	oidc-acr-mapper	\N	068aeb71-d5ea-452f-8d6a-b4a1aca0b784
7b5d0623-3e0e-40bb-8cc4-6f671fb78f55	audience resolve	openid-connect	oidc-audience-resolve-mapper	43bbaeba-5eab-49be-b8c4-c011637e5b2c	\N
242683ed-c32b-4e4f-828f-d30d9892c424	role list	saml	saml-role-list-mapper	\N	47679dcf-1005-4b40-a1da-8569d08d95dc
19753723-6c0f-4f7d-a509-902d21978547	full name	openid-connect	oidc-full-name-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
18498534-b59a-402e-9fc7-26e5069969b9	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
95951040-7778-4925-a329-95be4af40177	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
33f5729d-3736-4c54-ab98-a9bea7d8306b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
249714f6-bc06-42f5-8689-d3bbe9c74e72	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
78b95ffb-6518-4cf8-bfef-d8976223a624	username	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
38068dcd-93e5-41b5-a5ba-ec9a28da8972	website	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
935af8dd-ce3f-440d-acdf-a69a1ba041fb	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
b471ec71-0b1b-4563-b537-cd21f55a1288	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
38b74370-256b-4e23-a90e-b8e4d0012203	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	1a18fc4e-219a-49b5-aefa-ed1085eb04ea
b6ca96ba-2782-4b4e-addf-a203a108e391	email	openid-connect	oidc-usermodel-attribute-mapper	\N	af365cb4-27ce-492e-8ce7-d78dc7fab611
dd423f3b-95f9-4839-b642-b9a9ee30439d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	af365cb4-27ce-492e-8ce7-d78dc7fab611
6a12b600-5206-4ad1-96de-203f7c9d13e5	address	openid-connect	oidc-address-mapper	\N	d28a310c-1f68-4a35-9669-6a30361b3cf8
152b4ca3-3b85-4627-add7-0140018b132a	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	e2427baf-a533-4c32-8902-fd7fa554bd29
9cd33703-516e-4549-afb8-43c579f60433	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	e2427baf-a533-4c32-8902-fd7fa554bd29
aa8eeaf6-e45d-4eee-9898-b61bb5ee8b3b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda
6ab864f6-b32b-430c-b89d-0aefd2e789ee	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda
72e60f7a-ac2a-414a-b376-4319003030af	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	bbddcb71-5992-47bb-8aac-7b7eb7bfcbda
ddf69f88-aa40-4de8-8f94-80138ada02cc	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	e0648e33-f320-41bc-abaa-1fd40d2c588d
e3838353-2374-4d55-ae08-8aada895e539	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	2375f6b6-ba7e-4dfb-9b2a-f74033043de8
e59baf11-797f-4efb-9a66-3951789e3572	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2375f6b6-ba7e-4dfb-9b2a-f74033043de8
a413f092-c94f-4ab7-97d6-06c078d96175	acr loa level	openid-connect	oidc-acr-mapper	\N	e75ccea0-a73c-4548-ade2-b600d688bd3f
05979d2b-21a8-4983-a533-595bd7df4e18	locale	openid-connect	oidc-usermodel-attribute-mapper	644da31f-f3cb-4452-90d8-07489751327c	\N
9a1ea4cc-dd97-4fe6-ab23-60a69aa38d62	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	d1187be3-8efe-4de2-aa98-be80379464e0	\N
9a58ddc2-d34a-425d-a2dd-2a75cc4bee94	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	d1187be3-8efe-4de2-aa98-be80379464e0	\N
c8e915c5-2877-47cc-90c3-e36b3f01a9ab	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	d1187be3-8efe-4de2-aa98-be80379464e0	\N
76c149ea-5ab0-49ba-85e4-2dc61a80e4ea	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	61752460-3001-450d-b7ee-ff9b6d1aeae5	\N
84d7f2ed-298e-472d-9e96-f2efa977ac3f	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	61752460-3001-450d-b7ee-ff9b6d1aeae5	\N
b5f7d64b-caa3-4ca1-aaca-006a3a06f5e1	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	61752460-3001-450d-b7ee-ff9b6d1aeae5	\N
fef8bb62-3ec1-4229-84e0-d7cf8d1027d0	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
a9ab026f-3392-4e9b-aed0-538810af9a00	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
42f0806c-c88e-4e45-a0b9-79b39560fc28	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
78440cc5-f8ed-48c3-bc4b-30eb5e8590d9	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	653b5484-afde-49bc-b7ef-30ad0e436b9e	\N
b36fe0de-7773-410a-bd4c-a4f5c9f17dd5	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	653b5484-afde-49bc-b7ef-30ad0e436b9e	\N
a804d961-e679-402b-8be3-e315dc52279d	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	653b5484-afde-49bc-b7ef-30ad0e436b9e	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
45d02022-7d9e-4131-b293-219a894d2020	true	introspection.token.claim
45d02022-7d9e-4131-b293-219a894d2020	true	userinfo.token.claim
45d02022-7d9e-4131-b293-219a894d2020	locale	user.attribute
45d02022-7d9e-4131-b293-219a894d2020	true	id.token.claim
45d02022-7d9e-4131-b293-219a894d2020	true	access.token.claim
45d02022-7d9e-4131-b293-219a894d2020	locale	claim.name
45d02022-7d9e-4131-b293-219a894d2020	String	jsonType.label
33a3f43f-ca76-4758-8fe9-b5dfa73aa129	false	single
33a3f43f-ca76-4758-8fe9-b5dfa73aa129	Basic	attribute.nameformat
33a3f43f-ca76-4758-8fe9-b5dfa73aa129	Role	attribute.name
1150cee3-83a3-4640-8da2-6ffc462eaebc	true	introspection.token.claim
1150cee3-83a3-4640-8da2-6ffc462eaebc	true	userinfo.token.claim
1150cee3-83a3-4640-8da2-6ffc462eaebc	website	user.attribute
1150cee3-83a3-4640-8da2-6ffc462eaebc	true	id.token.claim
1150cee3-83a3-4640-8da2-6ffc462eaebc	true	access.token.claim
1150cee3-83a3-4640-8da2-6ffc462eaebc	website	claim.name
1150cee3-83a3-4640-8da2-6ffc462eaebc	String	jsonType.label
14dc2c7a-3b10-40d2-b78b-38edf781a532	true	introspection.token.claim
14dc2c7a-3b10-40d2-b78b-38edf781a532	true	userinfo.token.claim
14dc2c7a-3b10-40d2-b78b-38edf781a532	middleName	user.attribute
14dc2c7a-3b10-40d2-b78b-38edf781a532	true	id.token.claim
14dc2c7a-3b10-40d2-b78b-38edf781a532	true	access.token.claim
14dc2c7a-3b10-40d2-b78b-38edf781a532	middle_name	claim.name
14dc2c7a-3b10-40d2-b78b-38edf781a532	String	jsonType.label
286cdab9-eaa2-4448-b5d8-fe016650a4c8	true	introspection.token.claim
286cdab9-eaa2-4448-b5d8-fe016650a4c8	true	userinfo.token.claim
286cdab9-eaa2-4448-b5d8-fe016650a4c8	firstName	user.attribute
286cdab9-eaa2-4448-b5d8-fe016650a4c8	true	id.token.claim
286cdab9-eaa2-4448-b5d8-fe016650a4c8	true	access.token.claim
286cdab9-eaa2-4448-b5d8-fe016650a4c8	given_name	claim.name
286cdab9-eaa2-4448-b5d8-fe016650a4c8	String	jsonType.label
326152ff-4767-4d26-a4f3-6fadd5234d81	true	introspection.token.claim
326152ff-4767-4d26-a4f3-6fadd5234d81	true	userinfo.token.claim
326152ff-4767-4d26-a4f3-6fadd5234d81	username	user.attribute
326152ff-4767-4d26-a4f3-6fadd5234d81	true	id.token.claim
326152ff-4767-4d26-a4f3-6fadd5234d81	true	access.token.claim
326152ff-4767-4d26-a4f3-6fadd5234d81	preferred_username	claim.name
326152ff-4767-4d26-a4f3-6fadd5234d81	String	jsonType.label
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	true	introspection.token.claim
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	true	userinfo.token.claim
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	birthdate	user.attribute
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	true	id.token.claim
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	true	access.token.claim
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	birthdate	claim.name
4dbd9446-fe8e-4a81-b2eb-d7748c821d6a	String	jsonType.label
50435205-4278-4345-9493-9b91112325e9	true	introspection.token.claim
50435205-4278-4345-9493-9b91112325e9	true	userinfo.token.claim
50435205-4278-4345-9493-9b91112325e9	locale	user.attribute
50435205-4278-4345-9493-9b91112325e9	true	id.token.claim
50435205-4278-4345-9493-9b91112325e9	true	access.token.claim
50435205-4278-4345-9493-9b91112325e9	locale	claim.name
50435205-4278-4345-9493-9b91112325e9	String	jsonType.label
81210e23-2052-457c-8aef-485c82aa713b	true	introspection.token.claim
81210e23-2052-457c-8aef-485c82aa713b	true	userinfo.token.claim
81210e23-2052-457c-8aef-485c82aa713b	profile	user.attribute
81210e23-2052-457c-8aef-485c82aa713b	true	id.token.claim
81210e23-2052-457c-8aef-485c82aa713b	true	access.token.claim
81210e23-2052-457c-8aef-485c82aa713b	profile	claim.name
81210e23-2052-457c-8aef-485c82aa713b	String	jsonType.label
8555aa71-eec3-431c-a767-e51fbbe864ef	true	introspection.token.claim
8555aa71-eec3-431c-a767-e51fbbe864ef	true	userinfo.token.claim
8555aa71-eec3-431c-a767-e51fbbe864ef	lastName	user.attribute
8555aa71-eec3-431c-a767-e51fbbe864ef	true	id.token.claim
8555aa71-eec3-431c-a767-e51fbbe864ef	true	access.token.claim
8555aa71-eec3-431c-a767-e51fbbe864ef	family_name	claim.name
8555aa71-eec3-431c-a767-e51fbbe864ef	String	jsonType.label
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	true	introspection.token.claim
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	true	userinfo.token.claim
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	nickname	user.attribute
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	true	id.token.claim
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	true	access.token.claim
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	nickname	claim.name
a285a0b4-fb27-4e75-b4f6-f0317511c6f7	String	jsonType.label
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	true	introspection.token.claim
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	true	userinfo.token.claim
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	picture	user.attribute
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	true	id.token.claim
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	true	access.token.claim
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	picture	claim.name
b54591ee-8dd1-42a5-8d99-a347cd4c20f8	String	jsonType.label
c37034f5-c11b-4af2-8c0d-abe4011930ad	true	introspection.token.claim
c37034f5-c11b-4af2-8c0d-abe4011930ad	true	userinfo.token.claim
c37034f5-c11b-4af2-8c0d-abe4011930ad	gender	user.attribute
c37034f5-c11b-4af2-8c0d-abe4011930ad	true	id.token.claim
c37034f5-c11b-4af2-8c0d-abe4011930ad	true	access.token.claim
c37034f5-c11b-4af2-8c0d-abe4011930ad	gender	claim.name
c37034f5-c11b-4af2-8c0d-abe4011930ad	String	jsonType.label
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	true	introspection.token.claim
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	true	userinfo.token.claim
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	zoneinfo	user.attribute
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	true	id.token.claim
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	true	access.token.claim
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	zoneinfo	claim.name
ecdfc8ba-f61a-47f3-b677-e31fe7cb0d27	String	jsonType.label
ef542b88-ca43-4680-b9f2-4018bb8d2739	true	introspection.token.claim
ef542b88-ca43-4680-b9f2-4018bb8d2739	true	userinfo.token.claim
ef542b88-ca43-4680-b9f2-4018bb8d2739	true	id.token.claim
ef542b88-ca43-4680-b9f2-4018bb8d2739	true	access.token.claim
f1af6b03-4f84-474f-bed4-eb8685c9c294	true	introspection.token.claim
f1af6b03-4f84-474f-bed4-eb8685c9c294	true	userinfo.token.claim
f1af6b03-4f84-474f-bed4-eb8685c9c294	updatedAt	user.attribute
f1af6b03-4f84-474f-bed4-eb8685c9c294	true	id.token.claim
f1af6b03-4f84-474f-bed4-eb8685c9c294	true	access.token.claim
f1af6b03-4f84-474f-bed4-eb8685c9c294	updated_at	claim.name
f1af6b03-4f84-474f-bed4-eb8685c9c294	long	jsonType.label
05ee1d41-053d-4575-a5de-31585bae6627	true	introspection.token.claim
05ee1d41-053d-4575-a5de-31585bae6627	true	userinfo.token.claim
05ee1d41-053d-4575-a5de-31585bae6627	emailVerified	user.attribute
05ee1d41-053d-4575-a5de-31585bae6627	true	id.token.claim
05ee1d41-053d-4575-a5de-31585bae6627	true	access.token.claim
05ee1d41-053d-4575-a5de-31585bae6627	email_verified	claim.name
05ee1d41-053d-4575-a5de-31585bae6627	boolean	jsonType.label
6cbb0432-5217-441a-b662-81d09d44a762	true	introspection.token.claim
6cbb0432-5217-441a-b662-81d09d44a762	true	userinfo.token.claim
6cbb0432-5217-441a-b662-81d09d44a762	email	user.attribute
6cbb0432-5217-441a-b662-81d09d44a762	true	id.token.claim
6cbb0432-5217-441a-b662-81d09d44a762	true	access.token.claim
6cbb0432-5217-441a-b662-81d09d44a762	email	claim.name
6cbb0432-5217-441a-b662-81d09d44a762	String	jsonType.label
6759f6af-614b-43ae-a2b5-e586ba8385a7	formatted	user.attribute.formatted
6759f6af-614b-43ae-a2b5-e586ba8385a7	country	user.attribute.country
6759f6af-614b-43ae-a2b5-e586ba8385a7	true	introspection.token.claim
6759f6af-614b-43ae-a2b5-e586ba8385a7	postal_code	user.attribute.postal_code
6759f6af-614b-43ae-a2b5-e586ba8385a7	true	userinfo.token.claim
6759f6af-614b-43ae-a2b5-e586ba8385a7	street	user.attribute.street
6759f6af-614b-43ae-a2b5-e586ba8385a7	true	id.token.claim
6759f6af-614b-43ae-a2b5-e586ba8385a7	region	user.attribute.region
6759f6af-614b-43ae-a2b5-e586ba8385a7	true	access.token.claim
6759f6af-614b-43ae-a2b5-e586ba8385a7	locality	user.attribute.locality
840934ab-eb48-4136-a2d7-7eb3a06f7b57	true	introspection.token.claim
840934ab-eb48-4136-a2d7-7eb3a06f7b57	true	userinfo.token.claim
840934ab-eb48-4136-a2d7-7eb3a06f7b57	phoneNumberVerified	user.attribute
840934ab-eb48-4136-a2d7-7eb3a06f7b57	true	id.token.claim
840934ab-eb48-4136-a2d7-7eb3a06f7b57	true	access.token.claim
840934ab-eb48-4136-a2d7-7eb3a06f7b57	phone_number_verified	claim.name
840934ab-eb48-4136-a2d7-7eb3a06f7b57	boolean	jsonType.label
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	true	introspection.token.claim
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	true	userinfo.token.claim
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	phoneNumber	user.attribute
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	true	id.token.claim
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	true	access.token.claim
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	phone_number	claim.name
e6d1a5b0-e5a9-406a-b6d6-fdf94508200a	String	jsonType.label
895bfe1a-ecde-444c-865f-336f0cde455e	true	introspection.token.claim
895bfe1a-ecde-444c-865f-336f0cde455e	true	access.token.claim
fc3eab36-6b62-4879-a60e-e43170e81133	true	introspection.token.claim
fc3eab36-6b62-4879-a60e-e43170e81133	true	multivalued
fc3eab36-6b62-4879-a60e-e43170e81133	foo	user.attribute
fc3eab36-6b62-4879-a60e-e43170e81133	true	access.token.claim
fc3eab36-6b62-4879-a60e-e43170e81133	realm_access.roles	claim.name
fc3eab36-6b62-4879-a60e-e43170e81133	String	jsonType.label
ff3fb04c-3cd9-47bd-b577-c06f8af8f610	true	introspection.token.claim
ff3fb04c-3cd9-47bd-b577-c06f8af8f610	true	multivalued
ff3fb04c-3cd9-47bd-b577-c06f8af8f610	foo	user.attribute
ff3fb04c-3cd9-47bd-b577-c06f8af8f610	true	access.token.claim
ff3fb04c-3cd9-47bd-b577-c06f8af8f610	resource_access.${client_id}.roles	claim.name
ff3fb04c-3cd9-47bd-b577-c06f8af8f610	String	jsonType.label
94e07110-2d46-4141-bc00-4f283f132fa6	true	introspection.token.claim
94e07110-2d46-4141-bc00-4f283f132fa6	true	access.token.claim
7775e8dd-29ff-4291-be96-1478a6685f35	true	introspection.token.claim
7775e8dd-29ff-4291-be96-1478a6685f35	true	multivalued
7775e8dd-29ff-4291-be96-1478a6685f35	foo	user.attribute
7775e8dd-29ff-4291-be96-1478a6685f35	true	id.token.claim
7775e8dd-29ff-4291-be96-1478a6685f35	true	access.token.claim
7775e8dd-29ff-4291-be96-1478a6685f35	groups	claim.name
7775e8dd-29ff-4291-be96-1478a6685f35	String	jsonType.label
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	true	introspection.token.claim
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	true	userinfo.token.claim
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	username	user.attribute
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	true	id.token.claim
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	true	access.token.claim
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	upn	claim.name
a248f8f4-ed83-4fef-aaad-ed814b0a7a83	String	jsonType.label
88a1de12-bf0c-4526-8bff-b47ec39a2932	true	introspection.token.claim
88a1de12-bf0c-4526-8bff-b47ec39a2932	true	id.token.claim
88a1de12-bf0c-4526-8bff-b47ec39a2932	true	access.token.claim
242683ed-c32b-4e4f-828f-d30d9892c424	false	single
242683ed-c32b-4e4f-828f-d30d9892c424	Basic	attribute.nameformat
242683ed-c32b-4e4f-828f-d30d9892c424	Role	attribute.name
18498534-b59a-402e-9fc7-26e5069969b9	true	introspection.token.claim
18498534-b59a-402e-9fc7-26e5069969b9	true	userinfo.token.claim
18498534-b59a-402e-9fc7-26e5069969b9	lastName	user.attribute
18498534-b59a-402e-9fc7-26e5069969b9	true	id.token.claim
18498534-b59a-402e-9fc7-26e5069969b9	true	access.token.claim
18498534-b59a-402e-9fc7-26e5069969b9	family_name	claim.name
18498534-b59a-402e-9fc7-26e5069969b9	String	jsonType.label
19753723-6c0f-4f7d-a509-902d21978547	true	introspection.token.claim
19753723-6c0f-4f7d-a509-902d21978547	true	userinfo.token.claim
19753723-6c0f-4f7d-a509-902d21978547	true	id.token.claim
19753723-6c0f-4f7d-a509-902d21978547	true	access.token.claim
249714f6-bc06-42f5-8689-d3bbe9c74e72	true	introspection.token.claim
249714f6-bc06-42f5-8689-d3bbe9c74e72	true	userinfo.token.claim
249714f6-bc06-42f5-8689-d3bbe9c74e72	nickname	user.attribute
249714f6-bc06-42f5-8689-d3bbe9c74e72	true	id.token.claim
249714f6-bc06-42f5-8689-d3bbe9c74e72	true	access.token.claim
249714f6-bc06-42f5-8689-d3bbe9c74e72	nickname	claim.name
249714f6-bc06-42f5-8689-d3bbe9c74e72	String	jsonType.label
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	true	introspection.token.claim
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	true	userinfo.token.claim
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	profile	user.attribute
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	true	id.token.claim
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	true	access.token.claim
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	profile	claim.name
2b1ba0f6-f5da-4e56-b37d-8f92064a6be9	String	jsonType.label
33f5729d-3736-4c54-ab98-a9bea7d8306b	true	introspection.token.claim
33f5729d-3736-4c54-ab98-a9bea7d8306b	true	userinfo.token.claim
33f5729d-3736-4c54-ab98-a9bea7d8306b	middleName	user.attribute
33f5729d-3736-4c54-ab98-a9bea7d8306b	true	id.token.claim
33f5729d-3736-4c54-ab98-a9bea7d8306b	true	access.token.claim
33f5729d-3736-4c54-ab98-a9bea7d8306b	middle_name	claim.name
33f5729d-3736-4c54-ab98-a9bea7d8306b	String	jsonType.label
38068dcd-93e5-41b5-a5ba-ec9a28da8972	true	introspection.token.claim
38068dcd-93e5-41b5-a5ba-ec9a28da8972	true	userinfo.token.claim
38068dcd-93e5-41b5-a5ba-ec9a28da8972	website	user.attribute
38068dcd-93e5-41b5-a5ba-ec9a28da8972	true	id.token.claim
38068dcd-93e5-41b5-a5ba-ec9a28da8972	true	access.token.claim
38068dcd-93e5-41b5-a5ba-ec9a28da8972	website	claim.name
38068dcd-93e5-41b5-a5ba-ec9a28da8972	String	jsonType.label
38b74370-256b-4e23-a90e-b8e4d0012203	true	introspection.token.claim
38b74370-256b-4e23-a90e-b8e4d0012203	true	userinfo.token.claim
38b74370-256b-4e23-a90e-b8e4d0012203	updatedAt	user.attribute
38b74370-256b-4e23-a90e-b8e4d0012203	true	id.token.claim
38b74370-256b-4e23-a90e-b8e4d0012203	true	access.token.claim
38b74370-256b-4e23-a90e-b8e4d0012203	updated_at	claim.name
38b74370-256b-4e23-a90e-b8e4d0012203	long	jsonType.label
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	true	introspection.token.claim
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	true	userinfo.token.claim
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	locale	user.attribute
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	true	id.token.claim
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	true	access.token.claim
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	locale	claim.name
482c3cde-1e2e-4bc1-ab08-d5caf5bf4300	String	jsonType.label
78b95ffb-6518-4cf8-bfef-d8976223a624	true	introspection.token.claim
78b95ffb-6518-4cf8-bfef-d8976223a624	true	userinfo.token.claim
78b95ffb-6518-4cf8-bfef-d8976223a624	username	user.attribute
78b95ffb-6518-4cf8-bfef-d8976223a624	true	id.token.claim
78b95ffb-6518-4cf8-bfef-d8976223a624	true	access.token.claim
78b95ffb-6518-4cf8-bfef-d8976223a624	preferred_username	claim.name
78b95ffb-6518-4cf8-bfef-d8976223a624	String	jsonType.label
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	true	introspection.token.claim
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	true	userinfo.token.claim
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	picture	user.attribute
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	true	id.token.claim
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	true	access.token.claim
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	picture	claim.name
7be9ad40-781a-49be-ae8b-bce3bd5e2e32	String	jsonType.label
935af8dd-ce3f-440d-acdf-a69a1ba041fb	true	introspection.token.claim
935af8dd-ce3f-440d-acdf-a69a1ba041fb	true	userinfo.token.claim
935af8dd-ce3f-440d-acdf-a69a1ba041fb	gender	user.attribute
935af8dd-ce3f-440d-acdf-a69a1ba041fb	true	id.token.claim
935af8dd-ce3f-440d-acdf-a69a1ba041fb	true	access.token.claim
935af8dd-ce3f-440d-acdf-a69a1ba041fb	gender	claim.name
935af8dd-ce3f-440d-acdf-a69a1ba041fb	String	jsonType.label
95951040-7778-4925-a329-95be4af40177	true	introspection.token.claim
95951040-7778-4925-a329-95be4af40177	true	userinfo.token.claim
95951040-7778-4925-a329-95be4af40177	firstName	user.attribute
95951040-7778-4925-a329-95be4af40177	true	id.token.claim
95951040-7778-4925-a329-95be4af40177	true	access.token.claim
95951040-7778-4925-a329-95be4af40177	given_name	claim.name
95951040-7778-4925-a329-95be4af40177	String	jsonType.label
b471ec71-0b1b-4563-b537-cd21f55a1288	true	introspection.token.claim
b471ec71-0b1b-4563-b537-cd21f55a1288	true	userinfo.token.claim
b471ec71-0b1b-4563-b537-cd21f55a1288	birthdate	user.attribute
b471ec71-0b1b-4563-b537-cd21f55a1288	true	id.token.claim
b471ec71-0b1b-4563-b537-cd21f55a1288	true	access.token.claim
b471ec71-0b1b-4563-b537-cd21f55a1288	birthdate	claim.name
b471ec71-0b1b-4563-b537-cd21f55a1288	String	jsonType.label
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	true	introspection.token.claim
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	true	userinfo.token.claim
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	zoneinfo	user.attribute
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	true	id.token.claim
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	true	access.token.claim
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	zoneinfo	claim.name
c8b98437-0ce9-4c9e-84de-3aa5efcc1745	String	jsonType.label
b6ca96ba-2782-4b4e-addf-a203a108e391	true	introspection.token.claim
b6ca96ba-2782-4b4e-addf-a203a108e391	true	userinfo.token.claim
b6ca96ba-2782-4b4e-addf-a203a108e391	email	user.attribute
b6ca96ba-2782-4b4e-addf-a203a108e391	true	id.token.claim
b6ca96ba-2782-4b4e-addf-a203a108e391	true	access.token.claim
b6ca96ba-2782-4b4e-addf-a203a108e391	email	claim.name
b6ca96ba-2782-4b4e-addf-a203a108e391	String	jsonType.label
dd423f3b-95f9-4839-b642-b9a9ee30439d	true	introspection.token.claim
dd423f3b-95f9-4839-b642-b9a9ee30439d	true	userinfo.token.claim
dd423f3b-95f9-4839-b642-b9a9ee30439d	emailVerified	user.attribute
dd423f3b-95f9-4839-b642-b9a9ee30439d	true	id.token.claim
dd423f3b-95f9-4839-b642-b9a9ee30439d	true	access.token.claim
dd423f3b-95f9-4839-b642-b9a9ee30439d	email_verified	claim.name
dd423f3b-95f9-4839-b642-b9a9ee30439d	boolean	jsonType.label
6a12b600-5206-4ad1-96de-203f7c9d13e5	formatted	user.attribute.formatted
6a12b600-5206-4ad1-96de-203f7c9d13e5	country	user.attribute.country
6a12b600-5206-4ad1-96de-203f7c9d13e5	true	introspection.token.claim
6a12b600-5206-4ad1-96de-203f7c9d13e5	postal_code	user.attribute.postal_code
6a12b600-5206-4ad1-96de-203f7c9d13e5	true	userinfo.token.claim
6a12b600-5206-4ad1-96de-203f7c9d13e5	street	user.attribute.street
6a12b600-5206-4ad1-96de-203f7c9d13e5	true	id.token.claim
6a12b600-5206-4ad1-96de-203f7c9d13e5	region	user.attribute.region
6a12b600-5206-4ad1-96de-203f7c9d13e5	true	access.token.claim
6a12b600-5206-4ad1-96de-203f7c9d13e5	locality	user.attribute.locality
152b4ca3-3b85-4627-add7-0140018b132a	true	introspection.token.claim
152b4ca3-3b85-4627-add7-0140018b132a	true	userinfo.token.claim
152b4ca3-3b85-4627-add7-0140018b132a	phoneNumber	user.attribute
152b4ca3-3b85-4627-add7-0140018b132a	true	id.token.claim
152b4ca3-3b85-4627-add7-0140018b132a	true	access.token.claim
152b4ca3-3b85-4627-add7-0140018b132a	phone_number	claim.name
152b4ca3-3b85-4627-add7-0140018b132a	String	jsonType.label
9cd33703-516e-4549-afb8-43c579f60433	true	introspection.token.claim
9cd33703-516e-4549-afb8-43c579f60433	true	userinfo.token.claim
9cd33703-516e-4549-afb8-43c579f60433	phoneNumberVerified	user.attribute
9cd33703-516e-4549-afb8-43c579f60433	true	id.token.claim
9cd33703-516e-4549-afb8-43c579f60433	true	access.token.claim
9cd33703-516e-4549-afb8-43c579f60433	phone_number_verified	claim.name
9cd33703-516e-4549-afb8-43c579f60433	boolean	jsonType.label
6ab864f6-b32b-430c-b89d-0aefd2e789ee	true	introspection.token.claim
6ab864f6-b32b-430c-b89d-0aefd2e789ee	true	multivalued
6ab864f6-b32b-430c-b89d-0aefd2e789ee	foo	user.attribute
6ab864f6-b32b-430c-b89d-0aefd2e789ee	true	access.token.claim
6ab864f6-b32b-430c-b89d-0aefd2e789ee	resource_access.${client_id}.roles	claim.name
6ab864f6-b32b-430c-b89d-0aefd2e789ee	String	jsonType.label
72e60f7a-ac2a-414a-b376-4319003030af	true	introspection.token.claim
72e60f7a-ac2a-414a-b376-4319003030af	true	access.token.claim
aa8eeaf6-e45d-4eee-9898-b61bb5ee8b3b	true	introspection.token.claim
aa8eeaf6-e45d-4eee-9898-b61bb5ee8b3b	true	multivalued
aa8eeaf6-e45d-4eee-9898-b61bb5ee8b3b	foo	user.attribute
aa8eeaf6-e45d-4eee-9898-b61bb5ee8b3b	true	access.token.claim
aa8eeaf6-e45d-4eee-9898-b61bb5ee8b3b	realm_access.roles	claim.name
aa8eeaf6-e45d-4eee-9898-b61bb5ee8b3b	String	jsonType.label
ddf69f88-aa40-4de8-8f94-80138ada02cc	true	introspection.token.claim
ddf69f88-aa40-4de8-8f94-80138ada02cc	true	access.token.claim
e3838353-2374-4d55-ae08-8aada895e539	true	introspection.token.claim
e3838353-2374-4d55-ae08-8aada895e539	true	userinfo.token.claim
e3838353-2374-4d55-ae08-8aada895e539	username	user.attribute
e3838353-2374-4d55-ae08-8aada895e539	true	id.token.claim
e3838353-2374-4d55-ae08-8aada895e539	true	access.token.claim
e3838353-2374-4d55-ae08-8aada895e539	upn	claim.name
e3838353-2374-4d55-ae08-8aada895e539	String	jsonType.label
e59baf11-797f-4efb-9a66-3951789e3572	true	introspection.token.claim
e59baf11-797f-4efb-9a66-3951789e3572	true	multivalued
e59baf11-797f-4efb-9a66-3951789e3572	foo	user.attribute
e59baf11-797f-4efb-9a66-3951789e3572	true	id.token.claim
e59baf11-797f-4efb-9a66-3951789e3572	true	access.token.claim
e59baf11-797f-4efb-9a66-3951789e3572	groups	claim.name
e59baf11-797f-4efb-9a66-3951789e3572	String	jsonType.label
a413f092-c94f-4ab7-97d6-06c078d96175	true	introspection.token.claim
a413f092-c94f-4ab7-97d6-06c078d96175	true	id.token.claim
a413f092-c94f-4ab7-97d6-06c078d96175	true	access.token.claim
05979d2b-21a8-4983-a533-595bd7df4e18	true	introspection.token.claim
05979d2b-21a8-4983-a533-595bd7df4e18	true	userinfo.token.claim
05979d2b-21a8-4983-a533-595bd7df4e18	locale	user.attribute
05979d2b-21a8-4983-a533-595bd7df4e18	true	id.token.claim
05979d2b-21a8-4983-a533-595bd7df4e18	true	access.token.claim
05979d2b-21a8-4983-a533-595bd7df4e18	locale	claim.name
05979d2b-21a8-4983-a533-595bd7df4e18	String	jsonType.label
9a1ea4cc-dd97-4fe6-ab23-60a69aa38d62	client_id	user.session.note
9a1ea4cc-dd97-4fe6-ab23-60a69aa38d62	true	introspection.token.claim
9a1ea4cc-dd97-4fe6-ab23-60a69aa38d62	true	id.token.claim
9a1ea4cc-dd97-4fe6-ab23-60a69aa38d62	true	access.token.claim
9a1ea4cc-dd97-4fe6-ab23-60a69aa38d62	client_id	claim.name
9a1ea4cc-dd97-4fe6-ab23-60a69aa38d62	String	jsonType.label
9a58ddc2-d34a-425d-a2dd-2a75cc4bee94	clientHost	user.session.note
9a58ddc2-d34a-425d-a2dd-2a75cc4bee94	true	introspection.token.claim
9a58ddc2-d34a-425d-a2dd-2a75cc4bee94	true	id.token.claim
9a58ddc2-d34a-425d-a2dd-2a75cc4bee94	true	access.token.claim
9a58ddc2-d34a-425d-a2dd-2a75cc4bee94	clientHost	claim.name
9a58ddc2-d34a-425d-a2dd-2a75cc4bee94	String	jsonType.label
c8e915c5-2877-47cc-90c3-e36b3f01a9ab	clientAddress	user.session.note
c8e915c5-2877-47cc-90c3-e36b3f01a9ab	true	introspection.token.claim
c8e915c5-2877-47cc-90c3-e36b3f01a9ab	true	id.token.claim
c8e915c5-2877-47cc-90c3-e36b3f01a9ab	true	access.token.claim
c8e915c5-2877-47cc-90c3-e36b3f01a9ab	clientAddress	claim.name
c8e915c5-2877-47cc-90c3-e36b3f01a9ab	String	jsonType.label
76c149ea-5ab0-49ba-85e4-2dc61a80e4ea	client_id	user.session.note
76c149ea-5ab0-49ba-85e4-2dc61a80e4ea	true	introspection.token.claim
76c149ea-5ab0-49ba-85e4-2dc61a80e4ea	true	id.token.claim
76c149ea-5ab0-49ba-85e4-2dc61a80e4ea	true	access.token.claim
76c149ea-5ab0-49ba-85e4-2dc61a80e4ea	client_id	claim.name
76c149ea-5ab0-49ba-85e4-2dc61a80e4ea	String	jsonType.label
84d7f2ed-298e-472d-9e96-f2efa977ac3f	clientHost	user.session.note
84d7f2ed-298e-472d-9e96-f2efa977ac3f	true	introspection.token.claim
84d7f2ed-298e-472d-9e96-f2efa977ac3f	true	id.token.claim
84d7f2ed-298e-472d-9e96-f2efa977ac3f	true	access.token.claim
84d7f2ed-298e-472d-9e96-f2efa977ac3f	clientHost	claim.name
84d7f2ed-298e-472d-9e96-f2efa977ac3f	String	jsonType.label
b5f7d64b-caa3-4ca1-aaca-006a3a06f5e1	clientAddress	user.session.note
b5f7d64b-caa3-4ca1-aaca-006a3a06f5e1	true	introspection.token.claim
b5f7d64b-caa3-4ca1-aaca-006a3a06f5e1	true	id.token.claim
b5f7d64b-caa3-4ca1-aaca-006a3a06f5e1	true	access.token.claim
b5f7d64b-caa3-4ca1-aaca-006a3a06f5e1	clientAddress	claim.name
b5f7d64b-caa3-4ca1-aaca-006a3a06f5e1	String	jsonType.label
42f0806c-c88e-4e45-a0b9-79b39560fc28	clientAddress	user.session.note
42f0806c-c88e-4e45-a0b9-79b39560fc28	true	introspection.token.claim
42f0806c-c88e-4e45-a0b9-79b39560fc28	true	id.token.claim
42f0806c-c88e-4e45-a0b9-79b39560fc28	true	access.token.claim
42f0806c-c88e-4e45-a0b9-79b39560fc28	clientAddress	claim.name
42f0806c-c88e-4e45-a0b9-79b39560fc28	String	jsonType.label
a9ab026f-3392-4e9b-aed0-538810af9a00	clientHost	user.session.note
a9ab026f-3392-4e9b-aed0-538810af9a00	true	introspection.token.claim
a9ab026f-3392-4e9b-aed0-538810af9a00	true	id.token.claim
a9ab026f-3392-4e9b-aed0-538810af9a00	true	access.token.claim
a9ab026f-3392-4e9b-aed0-538810af9a00	clientHost	claim.name
a9ab026f-3392-4e9b-aed0-538810af9a00	String	jsonType.label
fef8bb62-3ec1-4229-84e0-d7cf8d1027d0	client_id	user.session.note
fef8bb62-3ec1-4229-84e0-d7cf8d1027d0	true	introspection.token.claim
fef8bb62-3ec1-4229-84e0-d7cf8d1027d0	true	id.token.claim
fef8bb62-3ec1-4229-84e0-d7cf8d1027d0	true	access.token.claim
fef8bb62-3ec1-4229-84e0-d7cf8d1027d0	client_id	claim.name
fef8bb62-3ec1-4229-84e0-d7cf8d1027d0	String	jsonType.label
78440cc5-f8ed-48c3-bc4b-30eb5e8590d9	client_id	user.session.note
78440cc5-f8ed-48c3-bc4b-30eb5e8590d9	true	introspection.token.claim
78440cc5-f8ed-48c3-bc4b-30eb5e8590d9	true	id.token.claim
78440cc5-f8ed-48c3-bc4b-30eb5e8590d9	true	access.token.claim
78440cc5-f8ed-48c3-bc4b-30eb5e8590d9	client_id	claim.name
78440cc5-f8ed-48c3-bc4b-30eb5e8590d9	String	jsonType.label
a804d961-e679-402b-8be3-e315dc52279d	clientAddress	user.session.note
a804d961-e679-402b-8be3-e315dc52279d	true	introspection.token.claim
a804d961-e679-402b-8be3-e315dc52279d	true	id.token.claim
a804d961-e679-402b-8be3-e315dc52279d	true	access.token.claim
a804d961-e679-402b-8be3-e315dc52279d	clientAddress	claim.name
a804d961-e679-402b-8be3-e315dc52279d	String	jsonType.label
b36fe0de-7773-410a-bd4c-a4f5c9f17dd5	clientHost	user.session.note
b36fe0de-7773-410a-bd4c-a4f5c9f17dd5	true	introspection.token.claim
b36fe0de-7773-410a-bd4c-a4f5c9f17dd5	true	id.token.claim
b36fe0de-7773-410a-bd4c-a4f5c9f17dd5	true	access.token.claim
b36fe0de-7773-410a-bd4c-a4f5c9f17dd5	clientHost	claim.name
b36fe0de-7773-410a-bd4c-a4f5c9f17dd5	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
2a297db7-66c5-448b-80fc-9d7d0ffecd68	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	fa100695-6a07-4106-8855-8672a32a12ef	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	9a6cdc73-dcf9-4ba6-bf2f-9643649d55cb	a1d75a60-e129-404f-81d4-63f7b24aa0cd	d28818a2-1403-4d16-91e7-7704f01c8cff	4b0718dd-1b4b-4f03-9f47-e795e5f769c4	7529fd0d-9be7-4270-ad81-ad2bd256f674	2592000	f	900	t	f	30091d9e-dd78-4b57-a21b-eaac0f392572	0	f	0	0	0cdd42b3-92f0-4462-933e-193096de1054
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	60	300	300	keycloak.v3	keycloak.v2	keycloak	t	f	0	keycloak	beatbuddy	0	\N	t	t	t	f	ALL	1800	36000	f	t	cc97d42e-a486-4687-8259-8121218c6a01	1800	f	\N	f	f	f	t	0	1	30	6	HmacSHA1	totp	d3bf310a-9714-4f38-aca5-b09da074d1a3	7544016c-d236-4a70-911d-059b4d0cf38e	119e1b7a-cbc2-40c2-8394-d3223318f660	4982259e-b78a-4924-86a2-6ba4518f443c	2ce1f5ef-1f59-4aa0-ac31-86e0b66b0636	2592000	f	900	t	f	fbc60ac4-b250-48c9-b2ac-e4cba5407e70	0	t	0	0	5eb9be7a-4c63-41c8-8720-af3203a01554
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	2a297db7-66c5-448b-80fc-9d7d0ffecd68	
_browser_header.xContentTypeOptions	2a297db7-66c5-448b-80fc-9d7d0ffecd68	nosniff
_browser_header.referrerPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	no-referrer
_browser_header.xRobotsTag	2a297db7-66c5-448b-80fc-9d7d0ffecd68	none
_browser_header.xFrameOptions	2a297db7-66c5-448b-80fc-9d7d0ffecd68	SAMEORIGIN
_browser_header.contentSecurityPolicy	2a297db7-66c5-448b-80fc-9d7d0ffecd68	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	2a297db7-66c5-448b-80fc-9d7d0ffecd68	1; mode=block
_browser_header.strictTransportSecurity	2a297db7-66c5-448b-80fc-9d7d0ffecd68	max-age=31536000; includeSubDomains
bruteForceProtected	2a297db7-66c5-448b-80fc-9d7d0ffecd68	false
permanentLockout	2a297db7-66c5-448b-80fc-9d7d0ffecd68	false
maxFailureWaitSeconds	2a297db7-66c5-448b-80fc-9d7d0ffecd68	900
minimumQuickLoginWaitSeconds	2a297db7-66c5-448b-80fc-9d7d0ffecd68	60
waitIncrementSeconds	2a297db7-66c5-448b-80fc-9d7d0ffecd68	60
quickLoginCheckMilliSeconds	2a297db7-66c5-448b-80fc-9d7d0ffecd68	1000
maxDeltaTimeSeconds	2a297db7-66c5-448b-80fc-9d7d0ffecd68	43200
failureFactor	2a297db7-66c5-448b-80fc-9d7d0ffecd68	30
realmReusableOtpCode	2a297db7-66c5-448b-80fc-9d7d0ffecd68	false
displayName	2a297db7-66c5-448b-80fc-9d7d0ffecd68	Keycloak
displayNameHtml	2a297db7-66c5-448b-80fc-9d7d0ffecd68	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	2a297db7-66c5-448b-80fc-9d7d0ffecd68	RS256
offlineSessionMaxLifespanEnabled	2a297db7-66c5-448b-80fc-9d7d0ffecd68	false
offlineSessionMaxLifespan	2a297db7-66c5-448b-80fc-9d7d0ffecd68	5184000
realmReusableOtpCode	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	false
oauth2DeviceCodeLifespan	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	600
oauth2DevicePollingInterval	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	5
cibaBackchannelTokenDeliveryMode	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	poll
cibaExpiresIn	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	120
cibaInterval	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	5
cibaAuthRequestedUserHint	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	login_hint
parRequestUriLifespan	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	60
frontendUrl	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	
acr.loa.map	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	{}
clientSessionIdleTimeout	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	0
clientSessionMaxLifespan	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	0
clientOfflineSessionIdleTimeout	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	0
clientOfflineSessionMaxLifespan	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	0
displayName	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	Beat Buddy
displayNameHtml	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	Beat Buddy
bruteForceProtected	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	false
permanentLockout	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	false
maxFailureWaitSeconds	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	900
minimumQuickLoginWaitSeconds	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	60
waitIncrementSeconds	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	60
quickLoginCheckMilliSeconds	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1000
maxDeltaTimeSeconds	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	43200
failureFactor	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	30
actionTokenGeneratedByAdminLifespan	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	43200
actionTokenGeneratedByUserLifespan	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	300
defaultSignatureAlgorithm	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	RS256
offlineSessionMaxLifespanEnabled	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	false
offlineSessionMaxLifespan	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	5184000
webAuthnPolicyRpEntityName	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	keycloak
webAuthnPolicySignatureAlgorithms	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	ES256
webAuthnPolicyRpId	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	
webAuthnPolicyAttestationConveyancePreference	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyAuthenticatorAttachment	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyRequireResidentKey	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyUserVerificationRequirement	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyCreateTimeout	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	0
webAuthnPolicyAvoidSameAuthenticatorRegister	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	false
webAuthnPolicyRpEntityNamePasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	ES256
webAuthnPolicyRpIdPasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	
webAuthnPolicyAttestationConveyancePreferencePasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyRequireResidentKeyPasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	not specified
webAuthnPolicyCreateTimeoutPasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	false
client-policies.profiles	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	{"profiles":[]}
client-policies.policies	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	{"policies":[]}
firstBrokerLoginFlowId	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f3627af4-2b64-4a60-be1d-c93f7cf99814
firstBrokerLoginFlowId	2a297db7-66c5-448b-80fc-9d7d0ffecd68	71186211-de78-44c6-a937-42cd061ea396
maxTemporaryLockouts	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	0
_browser_header.contentSecurityPolicyReportOnly	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	
_browser_header.xContentTypeOptions	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	nosniff
_browser_header.referrerPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	no-referrer
_browser_header.xRobotsTag	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	none
_browser_header.xFrameOptions	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	SAMEORIGIN
_browser_header.contentSecurityPolicy	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	1; mode=block
_browser_header.strictTransportSecurity	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
2a297db7-66c5-448b-80fc-9d7d0ffecd68	jboss-logging
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	2a297db7-66c5-448b-80fc-9d7d0ffecd68
password	password	t	t	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	Beat Buddy	replyToDisplayName
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	true	starttls
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	true	auth
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c		envelopeFrom
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	true	ssl
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	vzbg gxea ktzd xycc	password
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	465	port
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	smtp.gmail.com	host
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	vutien.dat.3601+beatbuddy@gmail.com	replyTo
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	vutien.dat.3601+beatbuddy@gmail.com	from
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	Beat Buddy	fromDisplayName
e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	vutien.dat.3601@gmail.com	user
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.redirect_uris (client_id, value) FROM stdin;
fa6f3d7b-2e80-4fce-bbc0-faacd37bd141	/realms/master/account/*
e42f0f38-dd87-4140-999e-d9af160f6ef0	/realms/master/account/*
0fbdf72f-3d4e-48f7-8a22-d4497600516d	/admin/master/console/*
959a6f97-3f51-459e-928a-1f8d01ffb9ea	/realms/beatbuddy/account/*
43bbaeba-5eab-49be-b8c4-c011637e5b2c	/realms/beatbuddy/account/*
644da31f-f3cb-4452-90d8-07489751327c	/admin/beatbuddy/console/*
d1187be3-8efe-4de2-aa98-be80379464e0	/*
7c0a850a-6743-4cee-ac92-a5159f7da291	http://localhost:3000/*
7c0a850a-6743-4cee-ac92-a5159f7da291	http://bb.datvu.tech/*
7c0a850a-6743-4cee-ac92-a5159f7da291	/*
61752460-3001-450d-b7ee-ff9b6d1aeae5	/*
50bed23d-759e-487d-b1ea-6ac18dc59811	/*
091f5e08-80d8-4221-a8e0-e401d5fffca1	/*
091f5e08-80d8-4221-a8e0-e401d5fffca1	https://oauth.pstmn.io/v1/callback
653b5484-afde-49bc-b7ef-30ad0e436b9e	/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
6aecd832-3628-47c9-95c2-1a5820ed6e9b	VERIFY_EMAIL	Verify Email	2a297db7-66c5-448b-80fc-9d7d0ffecd68	t	f	VERIFY_EMAIL	50
f7e37584-74d8-4503-9b2e-228120dc8a26	UPDATE_PROFILE	Update Profile	2a297db7-66c5-448b-80fc-9d7d0ffecd68	t	f	UPDATE_PROFILE	40
fa45819e-afae-4601-8371-0fd9bcddc3d6	CONFIGURE_TOTP	Configure OTP	2a297db7-66c5-448b-80fc-9d7d0ffecd68	t	f	CONFIGURE_TOTP	10
4b8cb66b-4e5d-4150-af72-4e59eb705dc2	UPDATE_PASSWORD	Update Password	2a297db7-66c5-448b-80fc-9d7d0ffecd68	t	f	UPDATE_PASSWORD	30
a4432217-53dd-4e4a-a91a-3ea2b3a334a9	TERMS_AND_CONDITIONS	Terms and Conditions	2a297db7-66c5-448b-80fc-9d7d0ffecd68	f	f	TERMS_AND_CONDITIONS	20
ae4d8f5a-8057-44c4-a4e6-e90a60315756	delete_account	Delete Account	2a297db7-66c5-448b-80fc-9d7d0ffecd68	f	f	delete_account	60
4d116f34-65ad-41cc-8baf-693cce8ac719	update_user_locale	Update User Locale	2a297db7-66c5-448b-80fc-9d7d0ffecd68	t	f	update_user_locale	1000
7d8ca5f9-b1e7-4c8e-8f37-53a922ea820a	webauthn-register	Webauthn Register	2a297db7-66c5-448b-80fc-9d7d0ffecd68	t	f	webauthn-register	70
c7c548e4-9e99-42fc-a90f-2adac4165452	webauthn-register-passwordless	Webauthn Register Passwordless	2a297db7-66c5-448b-80fc-9d7d0ffecd68	t	f	webauthn-register-passwordless	80
1af0ca2a-23ec-4f65-9131-5db5bd04f3d4	VERIFY_EMAIL	Verify Email	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	t	f	VERIFY_EMAIL	50
96d61bdc-cb06-49e2-8d9d-7eec32a38c0f	UPDATE_PROFILE	Update Profile	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	t	f	UPDATE_PROFILE	40
ded229bd-e815-47e6-aaf9-f37c1ba729d2	CONFIGURE_TOTP	Configure OTP	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	t	f	CONFIGURE_TOTP	10
3a3d1288-91ea-44e7-ab3f-45691cd92c32	UPDATE_PASSWORD	Update Password	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	t	f	UPDATE_PASSWORD	30
c576bf03-5618-41dc-b517-d5064c41ffe4	TERMS_AND_CONDITIONS	Terms and Conditions	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f	f	TERMS_AND_CONDITIONS	20
6957ef95-d579-48e2-989d-08860e79ad46	delete_account	Delete Account	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	f	f	delete_account	60
dabce70b-cb76-42fb-88a7-6eafe2d13e10	update_user_locale	Update User Locale	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	t	f	update_user_locale	1000
0b241e9a-e985-4b2c-be98-78a029aeab05	webauthn-register	Webauthn Register	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	t	f	webauthn-register	70
91ad28aa-d46d-4da7-bd20-382d57cf3262	webauthn-register-passwordless	Webauthn Register Passwordless	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
d33ac927-3b03-4268-bf5d-d6d7ce45809d	0558d5cb-11ae-4a13-9dd8-4bf3653aa4bf
67c1e16c-a43b-45bc-be94-f83714e6d90c	0558d5cb-11ae-4a13-9dd8-4bf3653aa4bf
3a7c6a5d-5bc3-4057-be78-3de796ad5868	0558d5cb-11ae-4a13-9dd8-4bf3653aa4bf
a5813724-cce1-4ead-8e89-c00e63223959	4cfe78ff-f37e-4dd2-bd4f-66b1ad21a9e0
06f0db98-fa65-4fc6-a423-e075773865cf	4cfe78ff-f37e-4dd2-bd4f-66b1ad21a9e0
87063560-6ff8-43b5-bd29-90ba82ef625a	66d65e48-19ef-42eb-aca6-40e6e494df1d
87063560-6ff8-43b5-bd29-90ba82ef625a	4cfe78ff-f37e-4dd2-bd4f-66b1ad21a9e0
8c6b2811-cae1-40a4-83c2-d018095dece4	b854898c-a432-4c6a-b8a5-66395675a825
8c6b2811-cae1-40a4-83c2-d018095dece4	cf8f11cb-8148-41e1-b902-e404591dc9d1
8c6b2811-cae1-40a4-83c2-d018095dece4	255e6fe4-ed39-48c2-8c5e-a374867e49eb
e512bb1d-2779-455c-b2d8-298a8b9844bf	05d09961-7751-458d-baa8-f3d2aa392934
e512bb1d-2779-455c-b2d8-298a8b9844bf	b854898c-a432-4c6a-b8a5-66395675a825
e512bb1d-2779-455c-b2d8-298a8b9844bf	cf8f11cb-8148-41e1-b902-e404591dc9d1
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
d1187be3-8efe-4de2-aa98-be80379464e0	t	0	1
61752460-3001-450d-b7ee-ff9b6d1aeae5	t	0	1
50bed23d-759e-487d-b1ea-6ac18dc59811	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
28efea65-0e3a-4204-a743-7c89e5947024	Default Policy	A policy that grants access only for users within this realm	js	0	0	61752460-3001-450d-b7ee-ff9b6d1aeae5	\N
cf275b33-579b-40dc-9b25-e647d8b60130	Default Permission	A permission that applies to the default resource type	resource	1	0	61752460-3001-450d-b7ee-ff9b6d1aeae5	\N
ba5c96f2-9954-45ac-b881-0e0394d944ea	Web Confidential Client Policy		client	1	0	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
43475189-4811-4a7e-b7bb-8dda49db566b	Catalog Role Policy		role	1	0	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
681b7462-7c70-4f50-9c07-901d7733b3f3	View Public Playist Permission		scope	1	0	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
a5813724-cce1-4ead-8e89-c00e63223959	/v1/me/playlists Endpoint	\N		d1187be3-8efe-4de2-aa98-be80379464e0	d1187be3-8efe-4de2-aa98-be80379464e0	f	/v1/me/playlists Endpoint
67c1e16c-a43b-45bc-be94-f83714e6d90c	/v1/artists Endpoint	\N		d1187be3-8efe-4de2-aa98-be80379464e0	d1187be3-8efe-4de2-aa98-be80379464e0	f	/v1/artists Endpoint
3a7c6a5d-5bc3-4057-be78-3de796ad5868	/v1/playlists Endpoint	\N		d1187be3-8efe-4de2-aa98-be80379464e0	d1187be3-8efe-4de2-aa98-be80379464e0	f	/v1/playlists Endpoint
d33ac927-3b03-4268-bf5d-d6d7ce45809d	/v1/track-suggestions Endpoint	\N		d1187be3-8efe-4de2-aa98-be80379464e0	d1187be3-8efe-4de2-aa98-be80379464e0	f	/v1/track-suggestions Endpoint
06f0db98-fa65-4fc6-a423-e075773865cf	/v1/tracks/{trackId}/stream Endpoint	\N		d1187be3-8efe-4de2-aa98-be80379464e0	d1187be3-8efe-4de2-aa98-be80379464e0	f	/v1/tracks/{trackId}/stream Endpoint
87063560-6ff8-43b5-bd29-90ba82ef625a	/v1/me/playback Endpoint	\N		d1187be3-8efe-4de2-aa98-be80379464e0	d1187be3-8efe-4de2-aa98-be80379464e0	f	
005f04aa-b47c-4020-9fed-62b0c789aa4d	Default Resource	urn:kmashopapp:resources:default	\N	61752460-3001-450d-b7ee-ff9b6d1aeae5	61752460-3001-450d-b7ee-ff9b6d1aeae5	f	\N
e512bb1d-2779-455c-b2d8-298a8b9844bf	beatbuddy:playlist:tU8lzFQBDDd4inJ1	beatbuddy:playlist		3422392b-730f-4774-a81e-a68e56535bf0	50bed23d-759e-487d-b1ea-6ac18dc59811	t	Những bài hát hay nhất của Hoàng Thùy Linh
8c6b2811-cae1-40a4-83c2-d018095dece4	beatbuddy:playlist:NSjGuoJHdZcskkFL	beatbuddy:playlist	\N	3422392b-730f-4774-a81e-a68e56535bf0	50bed23d-759e-487d-b1ea-6ac18dc59811	t	Những bài hát hay nhất của Sơn Tùng M-TP
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
4cfe78ff-f37e-4dd2-bd4f-66b1ad21a9e0	GET		d1187be3-8efe-4de2-aa98-be80379464e0	View
0558d5cb-11ae-4a13-9dd8-4bf3653aa4bf	POST		d1187be3-8efe-4de2-aa98-be80379464e0	Create
66d65e48-19ef-42eb-aca6-40e6e494df1d	PUT		d1187be3-8efe-4de2-aa98-be80379464e0	Edit
b19b2e9a-237c-4b5f-a4f2-6db858551272	DELETE		d1187be3-8efe-4de2-aa98-be80379464e0	Delete
05d09961-7751-458d-baa8-f3d2aa392934	playlist:view		50bed23d-759e-487d-b1ea-6ac18dc59811	\N
255e6fe4-ed39-48c2-8c5e-a374867e49eb	playlist:view-public		50bed23d-759e-487d-b1ea-6ac18dc59811	\N
cf8f11cb-8148-41e1-b902-e404591dc9d1	playlist:edit	\N	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
b854898c-a432-4c6a-b8a5-66395675a825	playlist:delete	\N	50bed23d-759e-487d-b1ea-6ac18dc59811	\N
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.resource_uris (resource_id, value) FROM stdin;
a5813724-cce1-4ead-8e89-c00e63223959	/v1/me/playlists
67c1e16c-a43b-45bc-be94-f83714e6d90c	/v1/artists
3a7c6a5d-5bc3-4057-be78-3de796ad5868	/v1/playlists
d33ac927-3b03-4268-bf5d-d6d7ce45809d	/v1/track-suggestions
06f0db98-fa65-4fc6-a423-e075773865cf	/v1/tracks/{trackId}/stream
87063560-6ff8-43b5-bd29-90ba82ef625a	/v1/me/playback
005f04aa-b47c-4020-9fed-62b0c789aa4d	/*
e512bb1d-2779-455c-b2d8-298a8b9844bf	/v1/catalog/playlists/tU8lzFQBDDd4inJ1/*
e512bb1d-2779-455c-b2d8-298a8b9844bf	/v1/catalog/playlists/tU8lzFQBDDd4inJ1
8c6b2811-cae1-40a4-83c2-d018095dece4	/v1/catalog/playlists/NSjGuoJHdZcskkFL/*
8c6b2811-cae1-40a4-83c2-d018095dece4	/v1/catalog/playlists/NSjGuoJHdZcskkFL
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
e42f0f38-dd87-4140-999e-d9af160f6ef0	5028226d-1974-4fec-a42f-31c31f96701b
e42f0f38-dd87-4140-999e-d9af160f6ef0	01b14307-4880-4e12-b9a8-1abc11a05482
43bbaeba-5eab-49be-b8c4-c011637e5b2c	abb5ff64-44a4-4def-88ae-78678f40d8c8
43bbaeba-5eab-49be-b8c4-c011637e5b2c	56f92204-23dd-4985-98f0-7ab36a1d574b
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
255e6fe4-ed39-48c2-8c5e-a374867e49eb	681b7462-7c70-4f50-9c07-901d7733b3f3
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
picture	https://lh3.googleusercontent.com/a/ACg8ocKWQu5-013kdZUqGTulEOOqOvFoFZmkJ8_ZT-Ws-iLR7il0=s96-c	3422392b-730f-4774-a81e-a68e56535bf0	29477fda-5aee-4363-9177-810e60e85a6f	\N	\N	\N
locale	en	3422392b-730f-4774-a81e-a68e56535bf0	b96afd7b-56bd-44e3-b8da-ed82f96d2088	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocIKy9eOgXLbIT3T3Z3STWsEHC6xsueq9dwQ3H7ZXhnP=s96-c	5e1ad023-6821-4a3e-88c2-7e426c3a7256	525758b0-8327-4163-bd83-2646bc829d48	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocLvFAlBkuogrBH2Xor_HxcHNbEmInPFU4lLKlBRioX8sK8=s96-c	5d9ae386-bdf1-4376-bac7-908a83b36383	180fa321-b759-4560-a029-27d7a6d41cdb	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocJHZgcJSN86a2rUNoU08AMc7ZdeuffvWqlPLgwdV2SuyA=s96-c	2d455703-6b41-47ea-a01e-cfaf72361d0b	5a22e8b2-21b0-492d-ac49-86e6906a8524	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocIa-xTogzH_pRhU6oqDEwVzw7pbu16P33Tvtfh9ub-l=s96-c	3049d4e1-dd32-4e9c-957d-66a1693f5ae5	e6ae92bf-8c9b-4e80-88cb-01d20ce2a531	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocIG3yyxjbKcnlg42qg5n_Lu3iuukUdFfZhym99d2cVv=s96-c	0608edd4-ef17-4c1b-9b17-95adbdf727cf	391e12b7-9c23-4c05-9a91-d7d3653f08a2	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocKUq2T_xoWRwvybFKzbp55-NWVpthaI6quJZNEt7MjqEvA=s96-c	fa3c22d7-66ff-4ba0-941f-948c28537b8c	a160816b-cf92-4f26-8cc2-caee9aef951c	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocJY8wthouPpavVgI5F_eedtfade0AKJ7Yxo62GF4qT_gA=s96-c	4407d91f-4cf5-4e5e-9795-e2aa82132956	09652a80-7048-4af5-a030-fbcc84edbd34	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocJZAkmw1Kq5RAxqBqWVTBTtKdYcT1oWoCO5eD24IAMH=s96-c	2d4767f0-5f64-4ecd-bf5c-48e272f524ef	7133c6b6-82ca-42d3-839c-6b7a0fc2b564	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocK8LV2OkDe2YwhuBtbhw_u-1cXoV950r91H5bUWMZt9kA=s96-c	eb53e6d4-047e-446b-b813-40cba456ffd3	bbddd4bf-8cc4-41ea-a99f-c85ad32b14ce	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocJ255C5xhtqPynG8JDizIZ77g630g_o4d5U3G2waxNlag=s96-c	219249e3-eaf0-48c8-9fa4-88448140bead	4eb1ad1d-27d6-46e3-9801-2c14b0346bbb	\N	\N	\N
picture	https://lh3.googleusercontent.com/a/ACg8ocKFSurpv5ccb7laeRb0uzcjxAhQ6lnxfLl8l1-0ZpOqx2fw4TM=s96-c	5ea6bcdb-be42-4db4-b42e-f1290319718d	975000de-d674-484f-a797-8ee49c3ac59d	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
57ea0847-70d8-4e5c-9eae-64846dc5e650	phamnguyenhoang.quan.1412@gmail.com	phamnguyenhoang.quan.1412@gmail.com	t	t	\N	kiwin	phạm	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	phamnguyenhoang.quan.1412@gmail.com	1709398107750	\N	0
234f0d42-9390-4bcc-9303-da4a5dec1e42	luongvu.work@gmail.com	luongvu.work@gmail.com	t	t	\N	LUONG	THANH VU	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	luongvu.work@gmail.com	1709438500859	\N	0
7c5787ae-3ded-4397-8677-af6b26be94a2	duyduydz13@gmail.com	duyduydz13@gmail.com	t	t	\N	Duy	D	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	duyduydz13@gmail.com	1709445145839	\N	0
106206fa-4e0c-4899-b9f1-8cb10dd2050e	ct06n0130@actvn.edu.vn	ct06n0130@actvn.edu.vn	t	t	\N	LÃM	TRẦN NGUYỄN ĐẮC	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	ct06n0130@actvn.edu.vn	1709475357033	\N	0
49dc8f5d-20e4-4bdc-a7e6-5b6a0a5c58cd	\N	5446b9bc-7fe3-4422-a9c0-1b0aa44b9103	t	t	\N	Admin	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	beatbuddy	1709230393908	\N	0
b42e4aeb-7841-4f9a-95ca-70201dc5f1ef	\N	6b282756-dd2c-4154-8228-ab724c9c9652	t	t	\N	Moderator	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	moderator	1709230451220	\N	0
7a7e1939-00d1-4665-836c-d375564021d1	ct06n0116@actvn.edu.vn	ct06n0116@actvn.edu.vn	t	t	\N	DUY	PHẠM KHÁNH	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	ct06n0116@actvn.edu.vn	1709445206398	\N	0
931c7385-5590-437e-bd57-3e703c5ce395	richardvu.work@gmail.com	richardvu.work@gmail.com	t	t	\N	Richard	Vu	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	richardvu.work@gmail.com	1709438583984	\N	0
b65d0c61-b60c-4f3a-bcc1-1d3d6173087b	\N	aaa85f16-1dce-4202-bb21-dd822147468a	f	t	\N	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	service-account-bbapi	1709230739464	d1187be3-8efe-4de2-aa98-be80379464e0	0
eb3891ad-af4e-404e-acdc-8a6e6645d00e	thanhthu10102006@gmail.com	thanhthu10102006@gmail.com	t	t	\N	Nhan	Huynh	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	thanhthu10102006@gmail.com	1709348121136	\N	0
90363e29-158c-4ab3-b917-313d3df0d5f7	ct06n0110@actvn.edu.vn	ct06n0110@actvn.edu.vn	t	t	\N	ĐẠT	VŨ TIẾN	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	ct06n0110@actvn.edu.vn	1709532811717	\N	0
4407d91f-4cf5-4e5e-9795-e2aa82132956	thuhuynh10206@gmail.com	thuhuynh10206@gmail.com	t	t	\N	Thư	Thanh	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	thuhuynh10206@gmail.com	1709742557926	\N	0
5e1ad023-6821-4a3e-88c2-7e426c3a7256	andinhtran123@gmail.com	andinhtran123@gmail.com	t	t	\N	An	Tran	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	andinhtran123@gmail.com	1709538660936	\N	0
5d9ae386-bdf1-4376-bac7-908a83b36383	hungtaithe12@gmail.com	hungtaithe12@gmail.com	t	t	\N	Hùng	Lê Xuân	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	hungtaithe12@gmail.com	1709539309084	\N	0
015d41a6-c043-4d5f-bac0-e98b0b883cb6	ct06n0122@actvn.edu.vn	ct06n0122@actvn.edu.vn	t	t	\N	HÙNG	LÊ XUÂN	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	ct06n0122@actvn.edu.vn	1709539373061	\N	0
2d455703-6b41-47ea-a01e-cfaf72361d0b	accdetest01@gmail.com	accdetest01@gmail.com	t	t	\N	Để	Test	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	accdetest01@gmail.com	1709539959557	\N	0
3049d4e1-dd32-4e9c-957d-66a1693f5ae5	khuongdavid111@gmail.com	khuongdavid111@gmail.com	t	t	\N	Khuong	Nguyen Vu	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	khuongdavid111@gmail.com	1709540459920	\N	0
0608edd4-ef17-4c1b-9b17-95adbdf727cf	kjnwjnpham@gmail.com	kjnwjnpham@gmail.com	t	t	\N	Kjnwjn	Pham	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	kjnwjnpham@gmail.com	1709549962266	\N	0
3422392b-730f-4774-a81e-a68e56535bf0	vutien.dat.3601@gmail.com	vutien.dat.3601@gmail.com	t	t	\N	Dat	Vu	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	vutien.dat.3601	1709532893012	\N	0
fa3c22d7-66ff-4ba0-941f-948c28537b8c	huynhphatsn@gmail.com	huynhphatsn@gmail.com	t	t	\N	Phát	Tấn	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	huynhphatsn@gmail.com	1709605516731	\N	0
2d4767f0-5f64-4ecd-bf5c-48e272f524ef	nguyennam080800@gmail.com	nguyennam080800@gmail.com	t	t	\N	nam	nguyễn`	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	nguyennam080800@gmail.com	1709808237476	\N	0
912061cc-34e7-4433-b9fc-ce64757dd35a	vutien.dat.work@gmail.com	vutien.dat.work@gmail.com	t	t	\N	\N	\N	2a297db7-66c5-448b-80fc-9d7d0ffecd68	admin	1709230085171	\N	0
b03895ae-38ba-4f7c-9b43-79d262aa24e6	nguyenvominhhieu182@gmail.com	nguyenvominhhieu182@gmail.com	t	t	\N	Hiếu	Minh	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	nguyenvominhhieu182@gmail.com	1709383029582	\N	0
4cd7f002-398b-4fad-bc3e-f7b6fec12717	withlovemootita@gmail.com	withlovemootita@gmail.com	t	t	\N	Yong	Yong	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	withlovemootita@gmail.com	1709354808738	\N	0
eb53e6d4-047e-446b-b813-40cba456ffd3	ipquylinh@gmail.com	ipquylinh@gmail.com	t	t	\N	Quý Linh	quylinh	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	ipquylinh@gmail.com	1710667728698	\N	0
219249e3-eaf0-48c8-9fa4-88448140bead	nguyenducquyen2603@gmail.com	nguyenducquyen2603@gmail.com	t	t	\N	Quyền	Nguyễn	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	nguyenducquyen2603@gmail.com	1710814168040	\N	0
66d64712-a9eb-45c3-b7d6-afd40841b62a	\N	9b4ac7c3-83a1-4da8-9ca7-76d3c394231f	f	t	\N	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	service-account-kmashopapp	1712215717259	61752460-3001-450d-b7ee-ff9b6d1aeae5	0
5ea6bcdb-be42-4db4-b42e-f1290319718d	lebao210203@gmail.com	lebao210203@gmail.com	t	t	\N	Bảo	Lê	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	lebao210203@gmail.com	1712312796581	\N	0
c6423db2-7b1a-47d1-a25a-71bba15d016a	\N	3fe8b54b-47cd-4c21-8a13-01caf9ab2501	f	t	\N	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	service-account-beatbuddy	1712606102104	50bed23d-759e-487d-b1ea-6ac18dc59811	0
f5b763a5-0aa6-488b-adda-b0950bf4b9e8	anonymous@beatbuddy.io.vn	anonymous@beatbuddy.io.vn	t	t	\N	anonymous	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	anonymous	1712655165888	\N	0
83058d2b-2754-4c81-b371-340392551e82	\N	535decf2-5414-42bc-b444-2e8ada0689b3	f	t	\N	\N	\N	e85f69f7-de22-42cf-b1f8-9f8f5ad3a52c	service-account-webconfidential	1712735619597	653b5484-afde-49bc-b7ef-30ad0e436b9e	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
0cdd42b3-92f0-4462-933e-193096de1054	912061cc-34e7-4433-b9fc-ce64757dd35a
53b669be-79f4-458c-af64-e3907ddea213	912061cc-34e7-4433-b9fc-ce64757dd35a
1d708059-fea2-4da3-867a-00b687b95149	912061cc-34e7-4433-b9fc-ce64757dd35a
87c40bcb-42ba-4bcd-8e4e-80a97f07d9a0	912061cc-34e7-4433-b9fc-ce64757dd35a
9aa35a10-047d-4e1c-b401-f3f384adf0d3	912061cc-34e7-4433-b9fc-ce64757dd35a
16ea30dd-aef8-4c25-971a-65249777a09d	912061cc-34e7-4433-b9fc-ce64757dd35a
7e146706-628e-4d02-a3b0-84398d480672	912061cc-34e7-4433-b9fc-ce64757dd35a
3b15e2c7-377b-4aaa-a4fa-2479f30ba60e	912061cc-34e7-4433-b9fc-ce64757dd35a
f8d22d5c-b5ab-419e-9676-16f12d9cce65	912061cc-34e7-4433-b9fc-ce64757dd35a
f3009026-8ab1-4638-9d4b-e0a7a9299618	912061cc-34e7-4433-b9fc-ce64757dd35a
b1f8ddc7-12de-46fe-8c7c-3bd5f80e4dc4	912061cc-34e7-4433-b9fc-ce64757dd35a
840db824-c087-42dd-9f87-43b6c4670c4e	912061cc-34e7-4433-b9fc-ce64757dd35a
a694c843-577e-4344-a074-f733e1600197	912061cc-34e7-4433-b9fc-ce64757dd35a
3fb51f28-683a-4631-b649-521ce4e1d9c7	912061cc-34e7-4433-b9fc-ce64757dd35a
ee6e08b3-4e31-4401-b12a-236b0c09d277	912061cc-34e7-4433-b9fc-ce64757dd35a
b961753f-e7d4-4daa-8e21-b7b121ecb7c9	912061cc-34e7-4433-b9fc-ce64757dd35a
25b521f9-d8b9-4a9a-8176-99f04c8f1f40	912061cc-34e7-4433-b9fc-ce64757dd35a
7c9bcb90-b7d8-4c01-b934-998d7f29a8ef	912061cc-34e7-4433-b9fc-ce64757dd35a
a16bbe7e-8167-488c-8ac5-56ff9c3fa647	912061cc-34e7-4433-b9fc-ce64757dd35a
5eb9be7a-4c63-41c8-8720-af3203a01554	49dc8f5d-20e4-4bdc-a7e6-5b6a0a5c58cd
5eb9be7a-4c63-41c8-8720-af3203a01554	b42e4aeb-7841-4f9a-95ca-70201dc5f1ef
5eb9be7a-4c63-41c8-8720-af3203a01554	b65d0c61-b60c-4f3a-bcc1-1d3d6173087b
69dde0b4-e6fd-477e-bc95-5d19b57eeefe	b65d0c61-b60c-4f3a-bcc1-1d3d6173087b
5eb9be7a-4c63-41c8-8720-af3203a01554	eb3891ad-af4e-404e-acdc-8a6e6645d00e
5eb9be7a-4c63-41c8-8720-af3203a01554	4cd7f002-398b-4fad-bc3e-f7b6fec12717
5eb9be7a-4c63-41c8-8720-af3203a01554	b03895ae-38ba-4f7c-9b43-79d262aa24e6
5eb9be7a-4c63-41c8-8720-af3203a01554	57ea0847-70d8-4e5c-9eae-64846dc5e650
5eb9be7a-4c63-41c8-8720-af3203a01554	234f0d42-9390-4bcc-9303-da4a5dec1e42
5eb9be7a-4c63-41c8-8720-af3203a01554	931c7385-5590-437e-bd57-3e703c5ce395
5eb9be7a-4c63-41c8-8720-af3203a01554	7c5787ae-3ded-4397-8677-af6b26be94a2
5eb9be7a-4c63-41c8-8720-af3203a01554	7a7e1939-00d1-4665-836c-d375564021d1
5eb9be7a-4c63-41c8-8720-af3203a01554	106206fa-4e0c-4899-b9f1-8cb10dd2050e
5eb9be7a-4c63-41c8-8720-af3203a01554	90363e29-158c-4ab3-b917-313d3df0d5f7
5eb9be7a-4c63-41c8-8720-af3203a01554	3422392b-730f-4774-a81e-a68e56535bf0
5eb9be7a-4c63-41c8-8720-af3203a01554	5e1ad023-6821-4a3e-88c2-7e426c3a7256
5eb9be7a-4c63-41c8-8720-af3203a01554	5d9ae386-bdf1-4376-bac7-908a83b36383
5eb9be7a-4c63-41c8-8720-af3203a01554	015d41a6-c043-4d5f-bac0-e98b0b883cb6
5eb9be7a-4c63-41c8-8720-af3203a01554	2d455703-6b41-47ea-a01e-cfaf72361d0b
5eb9be7a-4c63-41c8-8720-af3203a01554	3049d4e1-dd32-4e9c-957d-66a1693f5ae5
5eb9be7a-4c63-41c8-8720-af3203a01554	0608edd4-ef17-4c1b-9b17-95adbdf727cf
5eb9be7a-4c63-41c8-8720-af3203a01554	fa3c22d7-66ff-4ba0-941f-948c28537b8c
5eb9be7a-4c63-41c8-8720-af3203a01554	4407d91f-4cf5-4e5e-9795-e2aa82132956
5eb9be7a-4c63-41c8-8720-af3203a01554	2d4767f0-5f64-4ecd-bf5c-48e272f524ef
5eb9be7a-4c63-41c8-8720-af3203a01554	eb53e6d4-047e-446b-b813-40cba456ffd3
5eb9be7a-4c63-41c8-8720-af3203a01554	219249e3-eaf0-48c8-9fa4-88448140bead
c0436058-fff8-4bf5-8308-31016ca87604	3422392b-730f-4774-a81e-a68e56535bf0
5eb9be7a-4c63-41c8-8720-af3203a01554	66d64712-a9eb-45c3-b7d6-afd40841b62a
3e1b9ebc-203b-42fb-ad2c-d8a9c4f8684a	66d64712-a9eb-45c3-b7d6-afd40841b62a
5eb9be7a-4c63-41c8-8720-af3203a01554	5ea6bcdb-be42-4db4-b42e-f1290319718d
5eb9be7a-4c63-41c8-8720-af3203a01554	c6423db2-7b1a-47d1-a25a-71bba15d016a
dfb10299-089e-4d20-8f34-3f151e59c4c4	c6423db2-7b1a-47d1-a25a-71bba15d016a
5eb9be7a-4c63-41c8-8720-af3203a01554	f5b763a5-0aa6-488b-adda-b0950bf4b9e8
5eb9be7a-4c63-41c8-8720-af3203a01554	83058d2b-2754-4c81-b371-340392551e82
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: beatbuddy
--

COPY public.web_origins (client_id, value) FROM stdin;
0fbdf72f-3d4e-48f7-8a22-d4497600516d	+
644da31f-f3cb-4452-90d8-07489751327c	+
d1187be3-8efe-4de2-aa98-be80379464e0	/*
7c0a850a-6743-4cee-ac92-a5159f7da291	+
61752460-3001-450d-b7ee-ff9b6d1aeae5	/*
50bed23d-759e-487d-b1ea-6ac18dc59811	/*
091f5e08-80d8-4221-a8e0-e401d5fffca1	*
653b5484-afde-49bc-b7ef-30ad0e436b9e	/*
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: beatbuddy
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: beatbuddy
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

