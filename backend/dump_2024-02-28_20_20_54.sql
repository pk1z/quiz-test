--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE app;




--
-- Drop roles
--

DROP ROLE app;


--
-- Roles
--

CREATE ROLE app;
ALTER ROLE app WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:EQ72f1a/XvrZlUb4Zom/EQ==$BbgHzQNpxJ3M2tGU78t2kOewuHPHtzImkJiEYSotFSw=:LlhkNcgitXzckgWEeOXvJ6ETkhe6YkF8c1JmppFWJs8=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: app
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO app;

\connect template1

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

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: app
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: app
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: app
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "app" dump
--

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

--
-- Name: app; Type: DATABASE; Schema: -; Owner: app
--

CREATE DATABASE app WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE app OWNER TO app;

\connect app

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

--
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: app
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO app;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answer; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.answer (
    id integer NOT NULL,
    question_id integer,
    answer_text character varying(255) NOT NULL,
    is_correct boolean NOT NULL
);


ALTER TABLE public.answer OWNER TO app;

--
-- Name: answer_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.answer_id_seq OWNER TO app;

--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO app;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messenger_messages_id_seq OWNER TO app;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: question; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.question (
    id integer NOT NULL,
    question_text character varying(255) NOT NULL
);


ALTER TABLE public.question OWNER TO app;

--
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.question_id_seq OWNER TO app;

--
-- Name: test_result; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.test_result (
    id integer NOT NULL
);


ALTER TABLE public.test_result OWNER TO app;

--
-- Name: test_result_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.test_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_result_id_seq OWNER TO app;

--
-- Name: user; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    uuid uuid NOT NULL
);


ALTER TABLE public."user" OWNER TO app;

--
-- Name: COLUMN "user".uuid; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public."user".uuid IS '(DC2Type:uuid)';


--
-- Name: user_answer; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.user_answer (
    id integer NOT NULL,
    question_id integer,
    user_id integer,
    answer_id integer
);


ALTER TABLE public.user_answer OWNER TO app;

--
-- Name: user_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.user_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_answer_id_seq OWNER TO app;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO app;

--
-- Name: user_questions; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.user_questions (
    id integer NOT NULL,
    question_id integer,
    answer_id integer,
    user_id integer,
    step_number integer NOT NULL,
    is_correct boolean
);


ALTER TABLE public.user_questions OWNER TO app;

--
-- Name: user_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.user_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_questions_id_seq OWNER TO app;

--
-- Name: user_test_session; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.user_test_session (
    id integer NOT NULL,
    uuid uuid NOT NULL,
    test_result character varying(255) NOT NULL
);


ALTER TABLE public.user_test_session OWNER TO app;

--
-- Name: user_test_session_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.user_test_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_test_session_id_seq OWNER TO app;

--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: answer; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.answer (id, question_id, answer_text, is_correct) FROM stdin;
1	1	3	f
2	1	2	t
3	1	0	f
4	2	4	t
5	2	3 + 1	t
6	2	10	f
7	3	1 + 5	t
8	3	1	f
9	3	6	t
10	3	2 + 4	t
11	4	8	t
12	4	4	f
13	4	0	f
14	4	0 + 8	t
15	5	6	f
16	5	18	f
17	5	10	t
18	5	9	f
19	5	0	f
20	6	3	f
21	6	9	f
22	6	0	f
23	6	12	t
24	6	5 + 7	t
25	7	5	f
26	7	14	t
27	8	16	t
28	8	12	f
29	8	9	f
31	8	5	f
32	9	18	t
33	9	9	f
34	9	17 + 1	t
35	9	2 + 16	t
36	10	0	f
37	10	2	f
38	10	8	f
39	10	20	t
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.question (id, question_text) FROM stdin;
1	1 + 1 =
2	2 + 2 =
3	3 + 3 =
4	4 + 4 =
5	5 + 5 =
6	6 + 6 =
7	7 + 7 =
8	8 + 8 =
9	9 + 9 =
10	10 + 10 =
\.


--
-- Data for Name: test_result; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.test_result (id) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public."user" (id, uuid) FROM stdin;
3	bf72f608-d4aa-11ee-a9c5-1947856c1d98
5	ade6771c-d4b3-11ee-837a-a559f32bc01e
6	7bffcfea-d4b9-11ee-92a8-8f5cd27b925c
7	df923312-d4c4-11ee-bf18-9181a67c522d
8	f3b05856-d4c4-11ee-8026-53ecc7ee5be1
9	5434eb2e-d4c5-11ee-9847-1d3dd8b1f7ac
10	87da0edc-d4c5-11ee-9720-5345200a25de
11	ec231028-d4c5-11ee-b6ca-c1a94ac19adb
12	14a2cdc6-d4c7-11ee-a53b-e1d9239b0b4d
13	a148a958-d4c7-11ee-9844-95402918bdf6
14	aa58890a-d4c7-11ee-9b63-ef79f743e9d1
15	b02084b4-d4c7-11ee-8b83-b177a9afe345
16	83862336-d4cd-11ee-8384-8f6f8c780418
17	a69f0ffa-d4db-11ee-8143-014bbb712421
18	b84aaf5c-d4db-11ee-9a59-6feca0b65cb0
19	079098d8-d4dc-11ee-ab4b-a33b8862d604
20	58c3c07c-d4dc-11ee-b5a5-293252aa3846
21	ad0a1406-d4dc-11ee-85e2-3910130b1265
22	bb8f6526-d4dc-11ee-981a-b1fc3b36851a
23	e25980c4-d4dc-11ee-99ec-21acc65cf91e
24	87febe36-d4dd-11ee-bcbd-5dd82baf187d
25	83f2cb40-d544-11ee-b0e1-636eb91a5f4f
26	4282bace-d555-11ee-8eaa-5d9253e1a25c
27	a46f7a24-d555-11ee-90aa-a5897f2a6e2d
28	c5879a16-d555-11ee-8d82-ed249a176b46
29	000d1dc0-d559-11ee-a8f1-1594e0af3974
30	8dc27ffc-d559-11ee-86fe-8fb0085cf0dd
31	939092fc-d559-11ee-a98e-1b00d9f1ed4c
32	dde6c09c-d559-11ee-8e85-0126b8db1558
33	f7b6382c-d559-11ee-9906-61acd303d4d4
34	045921ac-d55a-11ee-8c17-c30acb67ad2c
35	06045616-d55a-11ee-9fb0-117150d914c6
36	10f310c6-d55a-11ee-9b86-e3e15609162c
37	864352fa-d55a-11ee-b774-c5a40a3c9d78
38	b453f01e-d55a-11ee-ae71-cfeb53cdace5
39	bb2c6150-d55a-11ee-b070-7b08b7d4d911
40	c02d2216-d55a-11ee-b130-45253bd4df0e
41	e633d39c-d55a-11ee-b3bc-c70a46cc7d2f
42	09d54254-d55b-11ee-b30e-fba3a7f5e03c
43	0c62de50-d55b-11ee-a64a-811c776226d4
44	15c12b50-d55b-11ee-be68-a7db98dbd057
45	1ad06502-d55b-11ee-8313-e71456e0e459
46	22e11250-d55b-11ee-a9fe-75b75740fc79
47	298b4bde-d55b-11ee-a964-0f7f5195c283
48	30a7057a-d55b-11ee-8d93-8dbf525cd3af
49	806f83a2-d565-11ee-aa85-b716c4d1ff10
50	c89ca34c-d567-11ee-9ed6-3fbeac7ee91e
51	d4a88970-d568-11ee-b31f-733653aaa4f1
52	bf4a5808-d56b-11ee-875d-8fa9013932f7
53	e55468d6-d57f-11ee-b610-ebcde201406b
54	f184b98a-d57f-11ee-b7e4-556076f8d7c2
55	067a8ac2-d580-11ee-b03f-79f83ac91761
56	0c74d806-d580-11ee-b4cf-112ecc44db07
57	1b6c9d92-d582-11ee-9460-256a248ec1fb
58	212a7772-d582-11ee-aa6e-91b5caee8384
59	5a465f66-d583-11ee-9490-332280e834d4
60	c638a992-d612-11ee-b083-3d6ff543ed6b
\.


--
-- Data for Name: user_answer; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.user_answer (id, question_id, user_id, answer_id) FROM stdin;
1	\N	5	\N
2	\N	5	\N
3	\N	5	\N
4	\N	6	\N
5	1	6	\N
6	1	6	\N
7	1	6	2
8	2	11	4
9	2	11	5
10	2	12	4
11	2	12	5
12	1	13	4
13	1	13	5
14	2	13	4
15	2	13	5
16	1	14	4
17	1	15	4
18	1	15	5
19	1	16	4
20	1	17	4
21	1	17	5
22	1	18	4
23	1	18	5
24	1	19	4
25	1	19	5
26	2	19	4
27	2	19	5
28	1	20	4
29	1	20	5
30	2	20	4
31	2	20	5
32	3	20	7
33	3	20	9
34	3	20	10
35	4	20	11
36	4	20	14
37	1	23	2
38	2	23	4
39	2	23	5
40	3	23	7
41	3	23	9
42	3	23	10
43	4	23	11
44	4	23	14
45	1	24	1
46	1	24	2
47	2	24	6
48	2	24	5
49	3	24	9
50	4	24	11
51	4	24	14
52	5	24	11
53	5	24	14
54	5	24	12
55	1	25	1
56	2	25	6
57	3	25	7
58	3	25	9
59	2	26	6
60	2	26	5
61	3	26	7
62	3	26	9
63	3	26	10
64	4	26	11
65	4	26	14
66	2	27	4
67	3	27	7
68	4	27	11
69	2	29	4
70	3	29	7
71	4	29	11
72	7	31	26
73	5	31	17
74	4	31	13
75	4	31	14
76	5	33	15
77	5	33	16
78	3	33	9
79	7	33	26
80	1	33	2
81	9	33	32
82	9	33	35
83	7	37	26
84	10	37	39
85	4	37	14
86	4	37	11
87	2	37	5
88	5	37	17
89	9	37	32
90	3	37	9
91	1	37	2
92	8	37	27
93	6	37	23
94	7	38	25
95	5	38	19
96	1	38	1
97	8	38	28
98	10	38	39
99	9	44	35
100	2	44	5
101	1	44	3
102	8	44	29
103	10	44	39
104	5	45	16
105	2	45	5
106	3	45	9
107	6	45	21
108	8	45	27
109	4	47	14
110	3	47	7
111	7	47	25
112	9	47	34
113	2	47	6
114	10	47	37
115	5	49	17
116	3	49	7
117	4	49	13
118	8	50	31
119	6	50	22
120	1	52	3
121	1	52	2
122	6	53	24
123	6	53	22
124	8	53	31
125	8	53	29
126	6	55	21
127	6	55	23
128	3	55	7
129	3	55	8
130	3	57	9
131	3	57	7
132	9	57	35
133	9	57	34
134	2	57	4
135	9	60	34
136	2	60	5
\.


--
-- Data for Name: user_questions; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.user_questions (id, question_id, answer_id, user_id, step_number, is_correct) FROM stdin;
1	1	\N	5	0	\N
2	2	\N	5	1	\N
3	3	\N	5	2	\N
4	4	\N	5	3	\N
5	5	\N	5	4	\N
6	6	\N	5	5	\N
7	7	\N	5	6	\N
8	8	\N	5	7	\N
9	9	\N	5	8	\N
10	10	\N	5	9	\N
11	1	\N	6	0	\N
12	2	\N	6	1	\N
13	3	\N	6	2	\N
14	4	\N	6	3	\N
15	5	\N	6	4	\N
16	6	\N	6	5	\N
17	7	\N	6	6	\N
18	8	\N	6	7	\N
19	9	\N	6	8	\N
20	10	\N	6	9	\N
21	1	\N	7	0	\N
22	2	\N	7	1	\N
23	3	\N	7	2	\N
24	4	\N	7	3	\N
25	5	\N	7	4	\N
26	6	\N	7	5	\N
27	7	\N	7	6	\N
28	8	\N	7	7	\N
29	9	\N	7	8	\N
30	10	\N	7	9	\N
31	1	\N	8	0	\N
32	2	\N	8	1	\N
33	3	\N	8	2	\N
34	4	\N	8	3	\N
35	5	\N	8	4	\N
36	6	\N	8	5	\N
37	7	\N	8	6	\N
38	8	\N	8	7	\N
39	9	\N	8	8	\N
40	10	\N	8	9	\N
41	1	\N	9	0	\N
42	2	\N	9	1	\N
43	3	\N	9	2	\N
44	4	\N	9	3	\N
45	5	\N	9	4	\N
46	6	\N	9	5	\N
47	7	\N	9	6	\N
48	8	\N	9	7	\N
49	9	\N	9	8	\N
50	10	\N	9	9	\N
51	1	\N	10	0	\N
52	2	\N	10	1	\N
53	3	\N	10	2	\N
54	4	\N	10	3	\N
55	5	\N	10	4	\N
56	6	\N	10	5	\N
57	7	\N	10	6	\N
58	8	\N	10	7	\N
59	9	\N	10	8	\N
60	10	\N	10	9	\N
61	1	\N	11	0	\N
63	3	\N	11	2	\N
64	4	\N	11	3	\N
65	5	\N	11	4	\N
66	6	\N	11	5	\N
67	7	\N	11	6	\N
68	8	\N	11	7	\N
69	9	\N	11	8	\N
70	10	\N	11	9	\N
62	2	\N	11	1	t
71	1	\N	12	0	\N
73	3	\N	12	2	\N
74	4	\N	12	3	\N
75	5	\N	12	4	\N
76	6	\N	12	5	\N
77	7	\N	12	6	\N
78	8	\N	12	7	\N
79	9	\N	12	8	\N
80	10	\N	12	9	\N
72	2	\N	12	1	t
83	3	\N	13	2	\N
84	4	\N	13	3	\N
85	5	\N	13	4	\N
86	6	\N	13	5	\N
87	7	\N	13	6	\N
88	8	\N	13	7	\N
89	9	\N	13	8	\N
90	10	\N	13	9	\N
81	1	\N	13	0	t
82	2	\N	13	1	t
92	2	\N	14	1	\N
93	3	\N	14	2	\N
94	4	\N	14	3	\N
95	5	\N	14	4	\N
96	6	\N	14	5	\N
97	7	\N	14	6	\N
98	8	\N	14	7	\N
99	9	\N	14	8	\N
100	10	\N	14	9	\N
91	1	\N	14	0	t
102	2	\N	15	1	\N
103	3	\N	15	2	\N
104	4	\N	15	3	\N
105	5	\N	15	4	\N
106	6	\N	15	5	\N
107	7	\N	15	6	\N
108	8	\N	15	7	\N
109	9	\N	15	8	\N
110	10	\N	15	9	\N
101	1	\N	15	0	t
112	2	\N	16	1	\N
113	3	\N	16	2	\N
114	4	\N	16	3	\N
115	5	\N	16	4	\N
116	6	\N	16	5	\N
117	7	\N	16	6	\N
118	8	\N	16	7	\N
119	9	\N	16	8	\N
120	10	\N	16	9	\N
111	1	\N	16	0	t
122	2	\N	17	1	\N
123	3	\N	17	2	\N
124	4	\N	17	3	\N
125	5	\N	17	4	\N
126	6	\N	17	5	\N
127	7	\N	17	6	\N
128	8	\N	17	7	\N
129	9	\N	17	8	\N
130	10	\N	17	9	\N
121	1	\N	17	0	t
135	5	\N	18	4	\N
136	6	\N	18	5	\N
137	7	\N	18	6	\N
138	8	\N	18	7	\N
139	9	\N	18	8	\N
140	10	\N	18	9	\N
131	1	\N	18	0	t
132	2	\N	18	1	t
133	3	\N	18	2	t
134	4	\N	18	3	t
143	3	\N	19	2	\N
144	4	\N	19	3	\N
145	5	\N	19	4	\N
146	6	\N	19	5	\N
147	7	\N	19	6	\N
148	8	\N	19	7	\N
149	9	\N	19	8	\N
150	10	\N	19	9	\N
141	1	\N	19	0	t
142	2	\N	19	1	t
155	5	\N	20	4	\N
156	6	\N	20	5	\N
157	7	\N	20	6	\N
158	8	\N	20	7	\N
159	9	\N	20	8	\N
160	10	\N	20	9	\N
151	1	\N	20	0	t
152	2	\N	20	1	t
153	3	\N	20	2	t
154	4	\N	20	3	t
161	1	\N	21	0	\N
162	2	\N	21	1	\N
163	3	\N	21	2	\N
164	4	\N	21	3	\N
165	5	\N	21	4	\N
166	6	\N	21	5	\N
167	7	\N	21	6	\N
168	8	\N	21	7	\N
169	9	\N	21	8	\N
170	10	\N	21	9	\N
171	1	\N	22	0	\N
172	2	\N	22	1	\N
173	3	\N	22	2	\N
174	4	\N	22	3	\N
175	5	\N	22	4	\N
176	6	\N	22	5	\N
177	7	\N	22	6	\N
178	8	\N	22	7	\N
179	9	\N	22	8	\N
180	10	\N	22	9	\N
185	5	\N	23	4	\N
186	6	\N	23	5	\N
187	7	\N	23	6	\N
188	8	\N	23	7	\N
189	9	\N	23	8	\N
190	10	\N	23	9	\N
181	1	\N	23	0	t
182	2	\N	23	1	t
183	3	\N	23	2	t
184	4	\N	23	3	t
196	6	\N	24	5	\N
197	7	\N	24	6	\N
198	8	\N	24	7	\N
199	9	\N	24	8	\N
200	10	\N	24	9	\N
191	1	\N	24	0	f
192	2	\N	24	1	f
193	3	\N	24	2	t
194	4	\N	24	3	t
195	5	\N	24	4	f
205	5	\N	25	4	\N
206	6	\N	25	5	\N
207	7	\N	25	6	\N
208	8	\N	25	7	\N
209	9	\N	25	8	\N
210	10	\N	25	9	\N
201	1	\N	25	0	f
202	2	\N	25	1	f
203	3	\N	25	2	t
204	4	\N	25	3	t
211	1	\N	26	0	\N
215	5	\N	26	4	\N
216	6	\N	26	5	\N
217	7	\N	26	6	\N
218	8	\N	26	7	\N
219	9	\N	26	8	\N
220	10	\N	26	9	\N
212	2	\N	26	1	f
213	3	\N	26	2	t
214	4	\N	26	3	t
221	1	\N	27	0	\N
225	5	\N	27	4	\N
226	6	\N	27	5	\N
227	7	\N	27	6	\N
228	8	\N	27	7	\N
229	9	\N	27	8	\N
230	10	\N	27	9	\N
222	2	\N	27	1	t
223	3	\N	27	2	t
224	4	\N	27	3	t
231	1	\N	28	0	\N
232	2	\N	28	1	\N
233	3	\N	28	2	\N
234	4	\N	28	3	\N
235	5	\N	28	4	\N
236	6	\N	28	5	\N
237	7	\N	28	6	\N
238	8	\N	28	7	\N
239	9	\N	28	8	\N
240	10	\N	28	9	\N
241	1	\N	29	0	\N
245	5	\N	29	4	\N
246	6	\N	29	5	\N
247	7	\N	29	6	\N
248	8	\N	29	7	\N
249	9	\N	29	8	\N
250	10	\N	29	9	\N
242	2	\N	29	1	t
243	3	\N	29	2	t
244	4	\N	29	3	t
251	3	\N	30	0	\N
252	2	\N	30	1	\N
253	5	\N	30	2	\N
254	6	\N	30	3	\N
255	8	\N	30	4	\N
256	4	\N	30	5	\N
257	7	\N	30	6	\N
258	1	\N	30	7	\N
259	10	\N	30	8	\N
260	9	\N	30	9	\N
261	9	\N	31	0	\N
265	2	\N	31	4	\N
266	6	\N	31	5	\N
267	10	\N	31	6	\N
268	8	\N	31	7	\N
269	1	\N	31	8	\N
270	3	\N	31	9	\N
262	7	\N	31	1	t
263	5	\N	31	2	t
264	4	\N	31	3	f
271	9	\N	32	0	\N
272	3	\N	32	1	\N
273	5	\N	32	2	\N
274	7	\N	32	3	\N
275	2	\N	32	4	\N
276	1	\N	32	5	\N
277	4	\N	32	6	\N
278	6	\N	32	7	\N
279	10	\N	32	8	\N
280	8	\N	32	9	\N
281	6	\N	33	0	\N
287	2	\N	33	6	\N
288	8	\N	33	7	\N
289	4	\N	33	8	\N
290	10	\N	33	9	\N
282	5	\N	33	1	f
283	3	\N	33	2	t
284	7	\N	33	3	t
285	1	\N	33	4	t
286	9	\N	33	5	t
291	1	\N	34	0	\N
292	7	\N	34	1	\N
293	5	\N	34	2	\N
294	9	\N	34	3	\N
295	2	\N	34	4	\N
296	4	\N	34	5	\N
297	6	\N	34	6	\N
298	10	\N	34	7	\N
299	3	\N	34	8	\N
300	8	\N	34	9	\N
301	2	\N	35	0	\N
302	4	\N	35	1	\N
303	9	\N	35	2	\N
304	8	\N	35	3	\N
305	7	\N	35	4	\N
306	5	\N	35	5	\N
307	6	\N	35	6	\N
308	1	\N	35	7	\N
309	3	\N	35	8	\N
310	10	\N	35	9	\N
311	7	\N	36	0	\N
312	2	\N	36	1	\N
313	3	\N	36	2	\N
314	1	\N	36	3	\N
315	4	\N	36	4	\N
316	5	\N	36	5	\N
317	9	\N	36	6	\N
318	8	\N	36	7	\N
319	10	\N	36	8	\N
320	6	\N	36	9	\N
321	7	\N	37	0	t
322	10	\N	37	1	t
323	4	\N	37	2	t
324	2	\N	37	3	t
325	5	\N	37	4	t
326	9	\N	37	5	t
327	3	\N	37	6	t
328	1	\N	37	7	t
329	8	\N	37	8	t
330	6	\N	37	9	t
337	4	\N	38	6	\N
338	3	\N	38	7	\N
339	2	\N	38	8	\N
340	6	\N	38	9	\N
331	9	\N	38	0	t
332	7	\N	38	1	f
333	5	\N	38	2	f
334	1	\N	38	3	f
335	8	\N	38	4	f
336	10	\N	38	5	t
341	2	\N	39	0	\N
342	3	\N	39	1	\N
343	1	\N	39	2	\N
344	8	\N	39	3	\N
345	9	\N	39	4	\N
346	6	\N	39	5	\N
347	10	\N	39	6	\N
348	7	\N	39	7	\N
349	5	\N	39	8	\N
350	4	\N	39	9	\N
351	6	\N	40	0	\N
352	8	\N	40	1	\N
353	7	\N	40	2	\N
354	3	\N	40	3	\N
355	9	\N	40	4	\N
356	5	\N	40	5	\N
357	10	\N	40	6	\N
358	1	\N	40	7	\N
359	4	\N	40	8	\N
360	2	\N	40	9	\N
361	6	\N	41	0	\N
362	2	\N	41	1	\N
363	8	\N	41	2	\N
364	3	\N	41	3	\N
365	9	\N	41	4	\N
366	10	\N	41	5	\N
367	1	\N	41	6	\N
368	7	\N	41	7	\N
369	5	\N	41	8	\N
370	4	\N	41	9	\N
371	7	\N	42	0	\N
372	9	\N	42	1	\N
373	3	\N	42	2	\N
374	10	\N	42	3	\N
375	2	\N	42	4	\N
376	4	\N	42	5	\N
377	5	\N	42	6	\N
378	6	\N	42	7	\N
379	8	\N	42	8	\N
380	1	\N	42	9	\N
381	8	\N	43	0	\N
382	9	\N	43	1	\N
383	1	\N	43	2	\N
384	10	\N	43	3	\N
385	6	\N	43	4	\N
386	5	\N	43	5	\N
387	7	\N	43	6	\N
388	3	\N	43	7	\N
389	2	\N	43	8	\N
390	4	\N	43	9	\N
396	7	\N	44	5	\N
397	3	\N	44	6	\N
398	4	\N	44	7	\N
399	5	\N	44	8	\N
400	6	\N	44	9	\N
391	9	\N	44	0	t
392	2	\N	44	1	t
393	1	\N	44	2	f
394	8	\N	44	3	f
395	10	\N	44	4	t
406	9	\N	45	5	\N
407	1	\N	45	6	\N
408	4	\N	45	7	\N
409	10	\N	45	8	\N
410	7	\N	45	9	\N
401	5	\N	45	0	f
402	2	\N	45	1	t
403	3	\N	45	2	t
404	6	\N	45	3	f
405	8	\N	45	4	t
411	8	\N	46	0	\N
412	4	\N	46	1	\N
413	9	\N	46	2	\N
414	1	\N	46	3	\N
415	6	\N	46	4	\N
416	3	\N	46	5	\N
417	10	\N	46	6	\N
418	2	\N	46	7	\N
419	5	\N	46	8	\N
420	7	\N	46	9	\N
427	5	\N	47	6	\N
428	6	\N	47	7	\N
429	1	\N	47	8	\N
430	8	\N	47	9	\N
421	4	\N	47	0	t
422	3	\N	47	1	t
423	7	\N	47	2	f
424	9	\N	47	3	t
425	2	\N	47	4	f
426	10	\N	47	5	f
431	10	\N	48	0	\N
432	1	\N	48	1	\N
433	4	\N	48	2	\N
434	2	\N	48	3	\N
435	7	\N	48	4	\N
436	5	\N	48	5	\N
437	3	\N	48	6	\N
438	8	\N	48	7	\N
439	6	\N	48	8	\N
440	9	\N	48	9	\N
444	6	\N	49	3	\N
445	9	\N	49	4	\N
446	7	\N	49	5	\N
447	2	\N	49	6	\N
448	10	\N	49	7	\N
449	8	\N	49	8	\N
450	1	\N	49	9	\N
441	5	\N	49	0	t
442	3	\N	49	1	t
443	4	\N	49	2	f
453	2	\N	50	2	\N
454	4	\N	50	3	\N
455	7	\N	50	4	\N
456	9	\N	50	5	\N
457	5	\N	50	6	\N
458	10	\N	50	7	\N
459	1	\N	50	8	\N
460	3	\N	50	9	\N
451	8	\N	50	0	f
452	6	\N	50	1	f
461	6	\N	51	0	\N
462	2	\N	51	1	\N
463	7	\N	51	2	\N
464	1	\N	51	3	\N
465	9	\N	51	4	\N
466	4	\N	51	5	\N
467	8	\N	51	6	\N
468	3	\N	51	7	\N
469	5	\N	51	8	\N
470	10	\N	51	9	\N
472	2	\N	52	1	\N
473	6	\N	52	2	\N
474	10	\N	52	3	\N
475	3	\N	52	4	\N
476	9	\N	52	5	\N
477	5	\N	52	6	\N
478	4	\N	52	7	\N
479	8	\N	52	8	\N
480	7	\N	52	9	\N
471	1	\N	52	0	f
483	1	\N	53	2	\N
484	7	\N	53	3	\N
485	9	\N	53	4	\N
486	4	\N	53	5	\N
487	3	\N	53	6	\N
488	10	\N	53	7	\N
489	2	\N	53	8	\N
490	5	\N	53	9	\N
481	6	\N	53	0	f
482	8	\N	53	1	f
491	8	\N	54	0	\N
492	6	\N	54	1	\N
493	2	\N	54	2	\N
494	1	\N	54	3	\N
495	5	\N	54	4	\N
496	3	\N	54	5	\N
497	10	\N	54	6	\N
498	4	\N	54	7	\N
499	9	\N	54	8	\N
500	7	\N	54	9	\N
503	4	\N	55	2	\N
504	10	\N	55	3	\N
505	1	\N	55	4	\N
506	9	\N	55	5	\N
507	2	\N	55	6	\N
508	5	\N	55	7	\N
509	8	\N	55	8	\N
510	7	\N	55	9	\N
501	6	\N	55	0	f
502	3	\N	55	1	f
511	4	\N	56	0	\N
512	5	\N	56	1	\N
513	3	\N	56	2	\N
514	9	\N	56	3	\N
515	6	\N	56	4	\N
516	2	\N	56	5	\N
517	1	\N	56	6	\N
518	10	\N	56	7	\N
519	7	\N	56	8	\N
520	8	\N	56	9	\N
524	7	\N	57	3	\N
525	4	\N	57	4	\N
526	6	\N	57	5	\N
527	5	\N	57	6	\N
528	8	\N	57	7	\N
529	10	\N	57	8	\N
530	1	\N	57	9	\N
521	3	\N	57	0	t
522	9	\N	57	1	t
523	2	\N	57	2	t
531	10	\N	58	0	\N
532	4	\N	58	1	\N
533	5	\N	58	2	\N
534	1	\N	58	3	\N
535	3	\N	58	4	\N
536	2	\N	58	5	\N
537	6	\N	58	6	\N
538	9	\N	58	7	\N
539	8	\N	58	8	\N
540	7	\N	58	9	\N
541	5	\N	59	0	\N
542	2	\N	59	1	\N
543	1	\N	59	2	\N
544	9	\N	59	3	\N
545	8	\N	59	4	\N
546	3	\N	59	5	\N
547	4	\N	59	6	\N
548	7	\N	59	7	\N
549	10	\N	59	8	\N
550	6	\N	59	9	\N
553	1	\N	60	2	\N
554	4	\N	60	3	\N
555	6	\N	60	4	\N
556	3	\N	60	5	\N
557	7	\N	60	6	\N
558	8	\N	60	7	\N
559	5	\N	60	8	\N
560	10	\N	60	9	\N
551	9	\N	60	0	t
552	2	\N	60	1	t
\.


--
-- Data for Name: user_test_session; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.user_test_session (id, uuid, test_result) FROM stdin;
\.


--
-- Name: answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.answer_id_seq', 39, true);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.question_id_seq', 10, true);


--
-- Name: test_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.test_result_id_seq', 1, false);


--
-- Name: user_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.user_answer_id_seq', 136, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.user_id_seq', 60, true);


--
-- Name: user_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.user_questions_id_seq', 560, true);


--
-- Name: user_test_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.user_test_session_id_seq', 1, false);


--
-- Name: answer answer_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT answer_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (id);


--
-- Name: test_result test_result_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.test_result
    ADD CONSTRAINT test_result_pkey PRIMARY KEY (id);


--
-- Name: user_answer user_answer_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_answer
    ADD CONSTRAINT user_answer_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_questions user_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_questions
    ADD CONSTRAINT user_questions_pkey PRIMARY KEY (id);


--
-- Name: user_test_session user_test_session_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_test_session
    ADD CONSTRAINT user_test_session_pkey PRIMARY KEY (id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_8a3cd9311e27f6bf; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_8a3cd9311e27f6bf ON public.user_questions USING btree (question_id);


--
-- Name: idx_8a3cd931a76ed395; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_8a3cd931a76ed395 ON public.user_questions USING btree (user_id);


--
-- Name: idx_8a3cd931aa334807; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_8a3cd931aa334807 ON public.user_questions USING btree (answer_id);


--
-- Name: idx_bf8f51181e27f6bf; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_bf8f51181e27f6bf ON public.user_answer USING btree (question_id);


--
-- Name: idx_bf8f5118a76ed395; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_bf8f5118a76ed395 ON public.user_answer USING btree (user_id);


--
-- Name: idx_bf8f5118aa334807; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_bf8f5118aa334807 ON public.user_answer USING btree (answer_id);


--
-- Name: idx_dadd4a251e27f6bf; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_dadd4a251e27f6bf ON public.answer USING btree (question_id);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: app
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: user_questions fk_8a3cd9311e27f6bf; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_questions
    ADD CONSTRAINT fk_8a3cd9311e27f6bf FOREIGN KEY (question_id) REFERENCES public.question(id);


--
-- Name: user_questions fk_8a3cd931a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_questions
    ADD CONSTRAINT fk_8a3cd931a76ed395 FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user_questions fk_8a3cd931aa334807; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_questions
    ADD CONSTRAINT fk_8a3cd931aa334807 FOREIGN KEY (answer_id) REFERENCES public.answer(id);


--
-- Name: user_answer fk_bf8f51181e27f6bf; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_answer
    ADD CONSTRAINT fk_bf8f51181e27f6bf FOREIGN KEY (question_id) REFERENCES public.question(id);


--
-- Name: user_answer fk_bf8f5118a76ed395; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_answer
    ADD CONSTRAINT fk_bf8f5118a76ed395 FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user_answer fk_bf8f5118aa334807; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.user_answer
    ADD CONSTRAINT fk_bf8f5118aa334807 FOREIGN KEY (answer_id) REFERENCES public.answer(id);


--
-- Name: answer fk_dadd4a251e27f6bf; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.answer
    ADD CONSTRAINT fk_dadd4a251e27f6bf FOREIGN KEY (question_id) REFERENCES public.question(id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: app
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO app;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: app
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

