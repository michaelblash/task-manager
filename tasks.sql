--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: task; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE task (
    task_id integer NOT NULL,
    task_priority_id integer,
    task_status_id integer,
    user_id integer,
    task_name character varying(50),
    task_description character varying(5000)
);


--
-- Name: task_priority; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE task_priority (
    task_priority_id integer NOT NULL,
    task_priority_name character varying(20),
    task_priority_value smallint NOT NULL,
    CONSTRAINT task_priority_task_priority_value_check CHECK ((task_priority_value > 0))
);


--
-- Name: task_priority_task_priority_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE task_priority_task_priority_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_priority_task_priority_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE task_priority_task_priority_id_seq OWNED BY task_priority.task_priority_id;


--
-- Name: task_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE task_status (
    task_status_id integer NOT NULL,
    task_status_name character varying(20)
);


--
-- Name: task_status_task_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE task_status_task_status_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_status_task_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE task_status_task_status_id_seq OWNED BY task_status.task_status_id;


--
-- Name: task_task_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE task_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: task_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE task_task_id_seq OWNED BY task.task_id;


--
-- Name: user_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_data (
    user_id integer NOT NULL,
    user_role_id integer,
    user_name character varying(30),
    user_password character varying(65)
);


--
-- Name: user_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_role (
    user_role_id integer NOT NULL,
    user_role_name character varying(20)
);


--
-- Name: user_role_user_role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_role_user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_role_user_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_role_user_role_id_seq OWNED BY user_role.user_role_id;


--
-- Name: username_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE username_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: username_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE username_user_id_seq OWNED BY user_data.user_id;


--
-- Name: task_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY task ALTER COLUMN task_id SET DEFAULT nextval('task_task_id_seq'::regclass);


--
-- Name: task_priority_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_priority ALTER COLUMN task_priority_id SET DEFAULT nextval('task_priority_task_priority_id_seq'::regclass);


--
-- Name: task_status_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_status ALTER COLUMN task_status_id SET DEFAULT nextval('task_status_task_status_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_data ALTER COLUMN user_id SET DEFAULT nextval('username_user_id_seq'::regclass);


--
-- Name: user_role_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role ALTER COLUMN user_role_id SET DEFAULT nextval('user_role_user_role_id_seq'::regclass);


--
-- Data for Name: task; Type: TABLE DATA; Schema: public; Owner: -
--

COPY task (task_id, task_priority_id, task_status_id, user_id, task_name, task_description) FROM stdin;
\.


--
-- Data for Name: task_priority; Type: TABLE DATA; Schema: public; Owner: -
--

COPY task_priority (task_priority_id, task_priority_name, task_priority_value) FROM stdin;
1	High	1
2	Medium	2
3	Low	3
\.


--
-- Name: task_priority_task_priority_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('task_priority_task_priority_id_seq', 3, true);


--
-- Data for Name: task_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY task_status (task_status_id, task_status_name) FROM stdin;
1	done
2	pending
\.


--
-- Name: task_status_task_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('task_status_task_status_id_seq', 2, true);


--
-- Name: task_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('task_task_id_seq', 20, true);


--
-- Data for Name: user_data; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_data (user_id, user_role_id, user_name, user_password) FROM stdin;
1	1	MainAdm	123
8	2	User1	qwerty
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY user_role (user_role_id, user_role_name) FROM stdin;
1	admin
2	user
\.


--
-- Name: user_role_user_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('user_role_user_role_id_seq', 2, true);


--
-- Name: username_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('username_user_id_seq', 8, true);


--
-- Name: task_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_pkey PRIMARY KEY (task_id);


--
-- Name: task_priority_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_priority
    ADD CONSTRAINT task_priority_pkey PRIMARY KEY (task_priority_id);


--
-- Name: task_priority_task_priority_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_priority
    ADD CONSTRAINT task_priority_task_priority_name_key UNIQUE (task_priority_name);


--
-- Name: task_priority_task_priority_value_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_priority
    ADD CONSTRAINT task_priority_task_priority_value_key UNIQUE (task_priority_value);


--
-- Name: task_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_status
    ADD CONSTRAINT task_status_pkey PRIMARY KEY (task_status_id);


--
-- Name: task_status_task_status_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task_status
    ADD CONSTRAINT task_status_task_status_name_key UNIQUE (task_status_name);


--
-- Name: user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (user_role_id);


--
-- Name: user_role_user_role_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_role
    ADD CONSTRAINT user_role_user_role_name_key UNIQUE (user_role_name);


--
-- Name: username_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_data
    ADD CONSTRAINT username_pkey PRIMARY KEY (user_id);


--
-- Name: username_user_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_data
    ADD CONSTRAINT username_user_name_key UNIQUE (user_name);


--
-- Name: task_task_priority_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_task_priority_id_fkey FOREIGN KEY (task_priority_id) REFERENCES task_priority(task_priority_id) ON DELETE RESTRICT;


--
-- Name: task_task_status_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_task_status_id_fkey FOREIGN KEY (task_status_id) REFERENCES task_status(task_status_id) ON DELETE RESTRICT;


--
-- Name: task_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_user_id_fkey FOREIGN KEY (user_id) REFERENCES user_data(user_id) ON DELETE CASCADE;


--
-- Name: username_user_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_data
    ADD CONSTRAINT username_user_role_id_fkey FOREIGN KEY (user_role_id) REFERENCES user_role(user_role_id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

