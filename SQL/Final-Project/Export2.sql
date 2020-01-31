--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
-- Dumped by pg_dump version 12.1

-- Started on 2020-01-31 22:12:34

\c postgres
DROP DATABASE db_final_project;
CREATE DATABASE db_final_project;
\c db_final_project
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
-- TOC entry 227 (class 1255 OID 16632)
-- Name: check_exist(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_exist() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
	if new.item_name not in (select item_name from menu) then 
	RAISE EXCEPTION 'IntegrityError';
	else
	return new;
	end if;
end$$;


ALTER FUNCTION public.check_exist() OWNER TO postgres;

--
-- TOC entry 228 (class 1255 OID 24820)
-- Name: logger(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.logger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$begin
	if (TG_TABLE_NAME = 'address') Then
		delete from address_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into address_log values(TG_OP, CURRENT_TIMESTAMP(0), old.address_id);
		else 
			insert into address_log values(TG_OP, CURRENT_TIMESTAMP(0), new.address_id);
		end if;
	elseif (TG_TABLE_NAME = 'bought_stuffs') Then
		delete from bought_stuffs_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into bought_stuffs_log values(TG_OP, CURRENT_TIMESTAMP(0), old.buy_factor_id, old.stuff_name);
		else 
			insert into bought_stuffs_log values(TG_OP, CURRENT_TIMESTAMP(0), new.buy_factor_id, new.stuff_name );
		end if;
	elseif (TG_TABLE_NAME = 'buy_factor') Then
		delete from buy_factor_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into buy_factor_log values(TG_OP, CURRENT_TIMESTAMP(0), old.buy_factor_id);
		else 
			insert into buy_factor_log values(TG_OP, CURRENT_TIMESTAMP(0), new.buy_factor_id );
		end if;
	elseif (TG_TABLE_NAME = 'customers') Then
		delete from customers_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into customers_log values(TG_OP, CURRENT_TIMESTAMP(0), old.personal_id);
		else 
			insert into customers_log values(TG_OP, CURRENT_TIMESTAMP(0), new.personal_id );
		end if;
	elseif (TG_TABLE_NAME = 'delivery') Then
		delete from delivery_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into delivery_log values(TG_OP, CURRENT_TIMESTAMP(0), old.delivery_id);
		else 
			insert into delivery_log values(TG_OP, CURRENT_TIMESTAMP(0), new.delivery_id );
		end if;
	elseif (TG_TABLE_NAME = 'menu') Then
		delete from menu_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into menu_log values(TG_OP, CURRENT_TIMESTAMP(0), old.item_name);
		else 
			insert into menu_log values(TG_OP, CURRENT_TIMESTAMP(0), new.item_name );
		end if;
	elseif (TG_TABLE_NAME = 'requested_items') Then
		delete from requested_items_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into requested_items_log values(TG_OP, CURRENT_TIMESTAMP(0), old.factor_id, old.item_name);
		else 
			insert into requested_items_log values(TG_OP, CURRENT_TIMESTAMP(0), new.factor_id, old.item_name );
		end if;
	elseif (TG_TABLE_NAME = 'sale_factor') Then
		delete from sale_factor_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into sale_factor_log values(TG_OP, CURRENT_TIMESTAMP(0), old.factor_id);
		else 
			insert into sale_factor_log values(TG_OP, CURRENT_TIMESTAMP(0), new.factor_id);
		end if;
	elseif (TG_TABLE_NAME = 'stores') Then
		delete from stores_log where date < current_timestamp - interval '1 day';
		if (TG_OP = 'DELETE') then
			insert into stores_log values(TG_OP, CURRENT_TIMESTAMP(0), old.store_id);
		else 
			insert into stores_log values(TG_OP, CURRENT_TIMESTAMP(0), new.store_id);
		end if;
	end if;
	return null;
end
$$;


ALTER FUNCTION public.logger() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 16425)
-- Name: address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address (
    address_id integer NOT NULL,
    landline character varying(8) NOT NULL,
    address_name character varying(20) NOT NULL,
    address character varying(100) NOT NULL,
    personal_id character varying(20) NOT NULL
);


ALTER TABLE public.address OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16423)
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.address_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.address_address_id_seq OWNER TO postgres;

--
-- TOC entry 2993 (class 0 OID 0)
-- Dependencies: 202
-- Name: address_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.address_address_id_seq OWNED BY public.address.address_id;


--
-- TOC entry 216 (class 1259 OID 24760)
-- Name: log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.log (
    op_type character varying NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE public.log OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24766)
-- Name: address_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.address_log (
    address_id integer
)
INHERITS (public.log);


ALTER TABLE public.address_log OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16511)
-- Name: bought_stuffs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bought_stuffs (
    buy_factor_id integer NOT NULL,
    stuff_name character varying(20) NOT NULL,
    price bigint NOT NULL
);


ALTER TABLE public.bought_stuffs OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24772)
-- Name: bought_stuffs_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bought_stuffs_log (
    buy_factor_id integer,
    stuff_name character varying(20)
)
INHERITS (public.log);


ALTER TABLE public.bought_stuffs_log OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16488)
-- Name: buy_factor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_factor (
    buy_factor_id integer NOT NULL,
    date date NOT NULL,
    store_id integer
);


ALTER TABLE public.buy_factor OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16486)
-- Name: buy_factor_buy_factor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.buy_factor_buy_factor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.buy_factor_buy_factor_id_seq OWNER TO postgres;

--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 211
-- Name: buy_factor_buy_factor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.buy_factor_buy_factor_id_seq OWNED BY public.buy_factor.buy_factor_id;


--
-- TOC entry 219 (class 1259 OID 24778)
-- Name: buy_factor_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.buy_factor_log (
    buy_factor_id integer
)
INHERITS (public.log);


ALTER TABLE public.buy_factor_log OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16575)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    personal_id character varying(20) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    phone_number character varying(11) NOT NULL,
    age smallint NOT NULL
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24784)
-- Name: customers_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers_log (
    personal_id character varying(20)
)
INHERITS (public.log);


ALTER TABLE public.customers_log OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16521)
-- Name: delivery; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery (
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    phone_number character varying(11) NOT NULL,
    delivery_id character varying(20) NOT NULL
);


ALTER TABLE public.delivery OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24790)
-- Name: delivery_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.delivery_log (
    delivery_id character varying(20)
)
INHERITS (public.log);


ALTER TABLE public.delivery_log OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16468)
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    current_price bigint NOT NULL,
    item_name character varying(20) NOT NULL
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24796)
-- Name: menu_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu_log (
    item_name character varying(20)
)
INHERITS (public.log);


ALTER TABLE public.menu_log OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16457)
-- Name: requested_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requested_items (
    factor_id integer NOT NULL,
    item_name character varying(20) NOT NULL,
    number smallint NOT NULL,
    price bigint NOT NULL
);


ALTER TABLE public.requested_items OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24802)
-- Name: requested_items_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.requested_items_log (
    factor_id integer,
    item_name character varying(20)
)
INHERITS (public.log);


ALTER TABLE public.requested_items_log OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16455)
-- Name: requested_items_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.requested_items_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.requested_items_request_id_seq OWNER TO postgres;

--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 206
-- Name: requested_items_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.requested_items_request_id_seq OWNED BY public.requested_items.factor_id;


--
-- TOC entry 226 (class 1259 OID 32957)
-- Name: restore; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.restore (
    table_name character varying(20) NOT NULL,
    query text NOT NULL
);


ALTER TABLE public.restore OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16441)
-- Name: sale_factor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale_factor (
    factor_id integer NOT NULL,
    date date NOT NULL,
    personal_id character varying(20),
    address_id integer,
    delivery_id character varying(20)
);


ALTER TABLE public.sale_factor OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16439)
-- Name: sale_factor_factor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sale_factor_factor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sale_factor_factor_id_seq OWNER TO postgres;

--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 204
-- Name: sale_factor_factor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sale_factor_factor_id_seq OWNED BY public.sale_factor.factor_id;


--
-- TOC entry 224 (class 1259 OID 24808)
-- Name: sale_factor_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale_factor_log (
    factor_id integer
)
INHERITS (public.log);


ALTER TABLE public.sale_factor_log OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16480)
-- Name: stores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores (
    store_id integer NOT NULL,
    store_name character varying(20) NOT NULL,
    active boolean NOT NULL
);


ALTER TABLE public.stores OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24814)
-- Name: stores_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stores_log (
    store_id integer
)
INHERITS (public.log);


ALTER TABLE public.stores_log OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16478)
-- Name: stores_store_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stores_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stores_store_id_seq OWNER TO postgres;

--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 209
-- Name: stores_store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stores_store_id_seq OWNED BY public.stores.store_id;


--
-- TOC entry 2786 (class 2604 OID 16428)
-- Name: address address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address ALTER COLUMN address_id SET DEFAULT nextval('public.address_address_id_seq'::regclass);


--
-- TOC entry 2791 (class 2604 OID 16491)
-- Name: buy_factor buy_factor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_factor ALTER COLUMN buy_factor_id SET DEFAULT nextval('public.buy_factor_buy_factor_id_seq'::regclass);


--
-- TOC entry 2789 (class 2604 OID 16460)
-- Name: requested_items factor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requested_items ALTER COLUMN factor_id SET DEFAULT nextval('public.requested_items_request_id_seq'::regclass);


--
-- TOC entry 2788 (class 2604 OID 16444)
-- Name: sale_factor factor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_factor ALTER COLUMN factor_id SET DEFAULT nextval('public.sale_factor_factor_id_seq'::regclass);


--
-- TOC entry 2790 (class 2604 OID 16483)
-- Name: stores store_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores ALTER COLUMN store_id SET DEFAULT nextval('public.stores_store_id_seq'::regclass);


--
-- TOC entry 2964 (class 0 OID 16425)
-- Dependencies: 203
-- Data for Name: address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address (address_id, landline, address_name, address, personal_id) FROM stdin;
3	44335854	shahraan	meydan valiasr nareside be onja	0022122877
13	44216587	aassdh55f	fasdsd	0022122877
16	44216587	aasdsdh55f	fasdsd	0022122877
18	55564182	fsadf	fas	0022122877
22	5555	asdfa	fasd	0022122877
30	115487	asdfa	fasd	554
36	12342678	fsdafasf	fasdfasasd	0022122877
37	12345678	fadsfadsfasdf	fadsfasfasfas	0022122877
\.


--
-- TOC entry 2978 (class 0 OID 24766)
-- Dependencies: 217
-- Data for Name: address_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.address_log (op_type, date, address_id) FROM stdin;
INSERT	2020-01-30 22:05:02	22
INSERT	2020-01-30 22:05:40	30
INSERT	2020-01-30 22:08:06	33
INSERT	2020-01-30 22:08:24	35
DELETE	2020-01-31 01:39:36	33
DELETE	2020-01-31 01:39:36	35
INSERT	2020-01-30 23:02:46	36
INSERT	2020-01-31 13:08:51	37
\.


--
-- TOC entry 2974 (class 0 OID 16511)
-- Dependencies: 213
-- Data for Name: bought_stuffs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bought_stuffs (buy_factor_id, stuff_name, price) FROM stdin;
5	pickle	15000
5	onion	10000
6	pickle	15000
6	tomato	5000
6	meat	45000
7	fdasf	1500
8	fdasf	1500
9	fdasf	1500
9	;plo	150000
\.


--
-- TOC entry 2979 (class 0 OID 24772)
-- Dependencies: 218
-- Data for Name: bought_stuffs_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bought_stuffs_log (op_type, date, buy_factor_id, stuff_name) FROM stdin;
INSERT	2020-01-29 14:21:13	6	meat
INSERT	2020-01-30 20:11:58	7	fdasf
INSERT	2020-01-30 20:12:26	8	fdasf
INSERT	2020-01-30 20:12:48	9	fdasf
INSERT	2020-01-30 20:12:48	9	;plo
\.


--
-- TOC entry 2973 (class 0 OID 16488)
-- Dependencies: 212
-- Data for Name: buy_factor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_factor (buy_factor_id, date, store_id) FROM stdin;
5	2020-01-29	6
6	2020-01-29	7
7	2020-01-30	6
8	2020-01-30	11
9	2020-01-30	12
\.


--
-- TOC entry 2980 (class 0 OID 24778)
-- Dependencies: 219
-- Data for Name: buy_factor_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.buy_factor_log (op_type, date, buy_factor_id) FROM stdin;
INSERT	2020-01-30 20:11:58	7
INSERT	2020-01-30 20:12:26	8
INSERT	2020-01-30 20:12:48	9
\.


--
-- TOC entry 2976 (class 0 OID 16575)
-- Dependencies: 215
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (personal_id, first_name, last_name, phone_number, age) FROM stdin;
0022122877	shafagh	shayani	9631041	19
554	saf	fasdf	45484	45
\.


--
-- TOC entry 2981 (class 0 OID 24784)
-- Dependencies: 220
-- Data for Name: customers_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers_log (op_type, date, personal_id) FROM stdin;
UPDATE	2020-01-30 20:24:21	1
DELETE	2020-01-30 20:33:45	1
INSERT	2020-01-30 22:12:50	021
DELETE	2020-01-31 13:11:11	021
\.


--
-- TOC entry 2975 (class 0 OID 16521)
-- Dependencies: 214
-- Data for Name: delivery; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery (first_name, last_name, phone_number, delivery_id) FROM stdin;
mammad	mammadian	09196891252	0
ahamad	abbasi	0915438214	1
gfsd	fsad	09154786325	151
\.


--
-- TOC entry 2982 (class 0 OID 24790)
-- Dependencies: 221
-- Data for Name: delivery_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.delivery_log (op_type, date, delivery_id) FROM stdin;
INSERT	2020-01-30 18:44:50	1
INSERT	2020-01-30 20:49:35	2
UPDATE	2020-01-30 20:49:45	2
DELETE	2020-01-30 20:49:51	2
INSERT	2020-01-30 22:13:49	151
\.


--
-- TOC entry 2977 (class 0 OID 24760)
-- Dependencies: 216
-- Data for Name: log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.log (op_type, date) FROM stdin;
\.


--
-- TOC entry 2969 (class 0 OID 16468)
-- Dependencies: 208
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (current_price, item_name) FROM stdin;
19000	hotdog
15000	ice cream
50000	stake
35000	pizza
16000	kebaba
20000	salad
65000	beef
\.


--
-- TOC entry 2983 (class 0 OID 24796)
-- Dependencies: 222
-- Data for Name: menu_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu_log (op_type, date, item_name) FROM stdin;
INSERT	2020-01-29 14:56:16	kebaba
UPDATE	2020-01-29 14:57:09	kebaba
INSERT	2020-01-30 00:10:14	salad
INSERT	2020-01-30 00:11:11	beef
DELETE	2020-01-30 20:42:25	humber
\.


--
-- TOC entry 2968 (class 0 OID 16457)
-- Dependencies: 207
-- Data for Name: requested_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requested_items (factor_id, item_name, number, price) FROM stdin;
60	stake	1	50000
60	hotdog	1	19000
61	humber	1	25000
62	humber	1	25000
62	stake	1	50000
63	humber	1	25000
63	stake	1	50000
59	stake	1	50000
59	humber	2	25000
\.


--
-- TOC entry 2984 (class 0 OID 24802)
-- Dependencies: 223
-- Data for Name: requested_items_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.requested_items_log (op_type, date, factor_id, item_name) FROM stdin;
INSERT	2020-01-29 21:44:59	61	\N
INSERT	2020-01-29 21:49:17	62	\N
INSERT	2020-01-29 21:49:17	62	\N
INSERT	2020-01-29 21:49:54	63	\N
INSERT	2020-01-29 21:49:54	63	\N
\.


--
-- TOC entry 2987 (class 0 OID 32957)
-- Dependencies: 226
-- Data for Name: restore; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.restore (table_name, query) FROM stdin;
account	CREATE TABLE account (\n   user_id serial PRIMARY KEY,\n   username VARCHAR (50) UNIQUE NOT NULL,\n   password VARCHAR (50) NOT NULL,\n   email VARCHAR (355) UNIQUE NOT NULL,\n   created_on TIMESTAMP NOT NULL,\n   last_login TIMESTAMP\n);
\.


--
-- TOC entry 2966 (class 0 OID 16441)
-- Dependencies: 205
-- Data for Name: sale_factor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale_factor (factor_id, date, personal_id, address_id, delivery_id) FROM stdin;
59	2020-01-29	0022122877	3	\N
60	2020-01-29	0022122877	3	\N
61	2020-01-30	0022122877	3	\N
62	2020-01-30	0022122877	3	0
63	2020-01-30	0022122877	3	0
\.


--
-- TOC entry 2985 (class 0 OID 24808)
-- Dependencies: 224
-- Data for Name: sale_factor_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale_factor_log (op_type, date, factor_id) FROM stdin;
INSERT	2020-01-29 21:44:59	61
INSERT	2020-01-29 21:49:17	62
INSERT	2020-01-29 21:49:54	63
\.


--
-- TOC entry 2971 (class 0 OID 16480)
-- Dependencies: 210
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stores (store_id, store_name, active) FROM stdin;
6	majid	t
7	bahman	t
11	yaran darya	t
12	xyz	t
13	fadsf	t
\.


--
-- TOC entry 2986 (class 0 OID 24814)
-- Dependencies: 225
-- Data for Name: stores_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stores_log (op_type, date, store_id) FROM stdin;
INSERT	2020-01-29 14:47:00	8
INSERT	2020-01-29 14:48:25	9
INSERT	2020-01-29 14:49:54	10
INSERT	2020-01-29 14:51:41	11
UPDATE	2020-01-29 14:52:06	11
INSERT	2020-01-30 18:54:50	12
INSERT	2020-01-30 21:23:39	13
INSERT	2020-01-30 21:23:52	14
INSERT	2020-01-30 21:24:41	15
UPDATE	2020-01-30 21:26:07	15
DELETE	2020-01-30 21:26:12	15
DELETE	2020-01-30 21:26:18	14
\.


--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 202
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.address_address_id_seq', 37, true);


--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 211
-- Name: buy_factor_buy_factor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.buy_factor_buy_factor_id_seq', 9, true);


--
-- TOC entry 3000 (class 0 OID 0)
-- Dependencies: 206
-- Name: requested_items_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.requested_items_request_id_seq', 1, false);


--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 204
-- Name: sale_factor_factor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sale_factor_factor_id_seq', 63, true);


--
-- TOC entry 3002 (class 0 OID 0)
-- Dependencies: 209
-- Name: stores_store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stores_store_id_seq', 15, true);


--
-- TOC entry 2787 (class 2606 OID 32954)
-- Name: address address_landline_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.address
    ADD CONSTRAINT address_landline_check CHECK (((landline)::text ~ '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'::text)) NOT VALID;


--
-- TOC entry 2795 (class 2606 OID 16595)
-- Name: address address_personal_id_address_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_personal_id_address_name_key UNIQUE (personal_id, address_name);


--
-- TOC entry 2797 (class 2606 OID 16433)
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- TOC entry 2809 (class 2606 OID 16515)
-- Name: bought_stuffs bought_stuffs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bought_stuffs
    ADD CONSTRAINT bought_stuffs_pkey PRIMARY KEY (buy_factor_id, stuff_name);


--
-- TOC entry 2807 (class 2606 OID 16493)
-- Name: buy_factor buy_factor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_factor
    ADD CONSTRAINT buy_factor_pkey PRIMARY KEY (buy_factor_id);


--
-- TOC entry 2793 (class 2606 OID 32955)
-- Name: customers customers_phone_number_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.customers
    ADD CONSTRAINT customers_phone_number_check CHECK (((phone_number)::text ~ '[0-9]{11}'::text)) NOT VALID;


--
-- TOC entry 2815 (class 2606 OID 16579)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (personal_id);


--
-- TOC entry 2792 (class 2606 OID 32956)
-- Name: delivery delivery_phone_number_check; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.delivery
    ADD CONSTRAINT delivery_phone_number_check CHECK (((phone_number)::text ~ '[0-9]{11}'::text)) NOT VALID;


--
-- TOC entry 2811 (class 2606 OID 16527)
-- Name: delivery delivery_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_phone_number_key UNIQUE (phone_number);


--
-- TOC entry 2813 (class 2606 OID 16525)
-- Name: delivery delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.delivery
    ADD CONSTRAINT delivery_pkey PRIMARY KEY (delivery_id);


--
-- TOC entry 2803 (class 2606 OID 16472)
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (item_name);


--
-- TOC entry 2817 (class 2606 OID 16581)
-- Name: customers phone_number; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT phone_number UNIQUE (phone_number);


--
-- TOC entry 2801 (class 2606 OID 16505)
-- Name: requested_items requested_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requested_items
    ADD CONSTRAINT requested_items_pkey PRIMARY KEY (factor_id, item_name);


--
-- TOC entry 2819 (class 2606 OID 32964)
-- Name: restore restore_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.restore
    ADD CONSTRAINT restore_pkey PRIMARY KEY (table_name);


--
-- TOC entry 2799 (class 2606 OID 16449)
-- Name: sale_factor sale_factor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_factor
    ADD CONSTRAINT sale_factor_pkey PRIMARY KEY (factor_id);


--
-- TOC entry 2805 (class 2606 OID 16485)
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY (store_id);


--
-- TOC entry 2827 (class 2620 OID 24821)
-- Name: address address_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER address_logger AFTER INSERT OR DELETE OR UPDATE ON public.address FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2834 (class 2620 OID 24822)
-- Name: bought_stuffs bougth_stuff_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER bougth_stuff_logger AFTER INSERT OR DELETE OR UPDATE ON public.bought_stuffs FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2833 (class 2620 OID 24836)
-- Name: buy_factor buy_factor_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER buy_factor_logger AFTER INSERT OR DELETE OR UPDATE ON public.buy_factor FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2829 (class 2620 OID 16633)
-- Name: requested_items check_it; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_it BEFORE INSERT ON public.requested_items FOR EACH ROW EXECUTE FUNCTION public.check_exist();


--
-- TOC entry 2836 (class 2620 OID 24835)
-- Name: customers customers_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER customers_logger AFTER INSERT OR DELETE OR UPDATE ON public.customers FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2835 (class 2620 OID 24834)
-- Name: delivery delivery_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER delivery_logger AFTER INSERT OR DELETE OR UPDATE ON public.delivery FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2831 (class 2620 OID 24833)
-- Name: menu menu_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER menu_logger AFTER INSERT OR DELETE OR UPDATE ON public.menu FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2830 (class 2620 OID 24832)
-- Name: requested_items requested_items_looger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER requested_items_looger AFTER INSERT OR DELETE OR UPDATE ON public.requested_items FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2828 (class 2620 OID 24831)
-- Name: sale_factor sale_factor_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER sale_factor_logger AFTER INSERT OR DELETE OR UPDATE ON public.sale_factor FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2832 (class 2620 OID 24830)
-- Name: stores stores_logger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER stores_logger AFTER INSERT OR DELETE OR UPDATE ON public.stores FOR EACH ROW EXECUTE FUNCTION public.logger();


--
-- TOC entry 2820 (class 2606 OID 16587)
-- Name: address address_personal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_personal_id_fkey FOREIGN KEY (personal_id) REFERENCES public.customers(personal_id) NOT VALID;


--
-- TOC entry 2826 (class 2606 OID 16516)
-- Name: bought_stuffs bought_stuffs_buy_factor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bought_stuffs
    ADD CONSTRAINT bought_stuffs_buy_factor_id_fkey FOREIGN KEY (buy_factor_id) REFERENCES public.buy_factor(buy_factor_id);


--
-- TOC entry 2825 (class 2606 OID 16611)
-- Name: buy_factor buy_factor_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.buy_factor
    ADD CONSTRAINT buy_factor_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.stores(store_id) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;


--
-- TOC entry 2824 (class 2606 OID 16506)
-- Name: requested_items requested_items_factor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.requested_items
    ADD CONSTRAINT requested_items_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES public.sale_factor(factor_id) NOT VALID;


--
-- TOC entry 2821 (class 2606 OID 16601)
-- Name: sale_factor sale_factor_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_factor
    ADD CONSTRAINT sale_factor_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) NOT VALID;


--
-- TOC entry 2822 (class 2606 OID 16616)
-- Name: sale_factor sale_factor_delivery_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_factor
    ADD CONSTRAINT sale_factor_delivery_id_fkey FOREIGN KEY (delivery_id) REFERENCES public.delivery(delivery_id) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;


--
-- TOC entry 2823 (class 2606 OID 16621)
-- Name: sale_factor sale_factor_personal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_factor
    ADD CONSTRAINT sale_factor_personal_id_fkey FOREIGN KEY (personal_id) REFERENCES public.customers(personal_id) ON UPDATE SET NULL ON DELETE SET NULL NOT VALID;


-- Completed on 2020-01-31 22:12:34

--
-- PostgreSQL database dump complete
--

