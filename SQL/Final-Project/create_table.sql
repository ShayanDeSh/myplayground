CREATE TABLE public."customers"
(
    personal_id character varying(20) NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    phone_number character varying(11) NOT NULL,
    age smallint NOT NULL,
    PRIMARY KEY (personal_id),
    CONSTRAINT phone_number UNIQUE (phone_number)
);

ALTER TABLE public."customers"
    OWNER to postgres;
	
	
CREATE TABLE public.address
(
    address_id integer NOT NULL DEFAULT nextval('address_address_id_seq'::regclass),
    landline character varying(8) COLLATE pg_catalog."default" NOT NULL,
    address_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    address character varying(100) COLLATE pg_catalog."default" NOT NULL,
    personal_id character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT address_pkey PRIMARY KEY (address_id),
    CONSTRAINT address_personal_id_address_name_key UNIQUE (personal_id, address_name),
    CONSTRAINT address_personal_id_fkey FOREIGN KEY (personal_id)
        REFERENCES public.customers (personal_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

ALTER TABLE public.address
    OWNER to postgres;

CREATE TABLE public.sale_factor
(
    factor_id integer NOT NULL DEFAULT nextval('sale_factor_factor_id_seq'::regclass),
    total_price bigint NOT NULL,
    date date NOT NULL,
    personal_id character varying(20) COLLATE pg_catalog."default",
    address_id integer,
    CONSTRAINT sale_factor_pkey PRIMARY KEY (factor_id),
    CONSTRAINT sale_factor_address_id_fkey FOREIGN KEY (address_id)
        REFERENCES public.address (address_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT sale_factor_personal_id_fkey FOREIGN KEY (personal_id)
        REFERENCES public.customers (personal_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

ALTER TABLE public.sale_factor
    OWNER to postgres;
	
CREATE TABLE public.requested_items
(
    factor_id integer NOT NULL DEFAULT nextval('requested_items_request_id_seq'::regclass),
    item_name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    "number" smallint NOT NULL,
    price bigint NOT NULL,
    CONSTRAINT requested_items_pkey PRIMARY KEY (factor_id, item_name),
    CONSTRAINT requested_items_factor_id_fkey FOREIGN KEY (factor_id)
        REFERENCES public.sale_factor (factor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT requested_items_item_name_fkey FOREIGN KEY (item_name)
        REFERENCES public.menu (item_name) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

ALTER TABLE public.requested_items
    OWNER to postgres;
	
CREATE TABLE public.menu
(
    current_price bigint NOT NULL,
    item_name character varying(20) NOT NULL,
    PRIMARY KEY (item_name)
);

ALTER TABLE public.menu
    OWNER to postgres;
	
CREATE TABLE public.stores
(
    store_id serial NOT NULL,
    store_name character varying(20) NOT NULL,
    PRIMARY KEY (store_id)
);

ALTER TABLE public.stores
    OWNER to postgres;
	CREATE TABLE public.buy_factor
(
    buy_factor_id integer NOT NULL DEFAULT nextval('buy_factor_buy_factor_id_seq'::regclass),
    date date NOT NULL,
    total_price bigint NOT NULL,
    store_id integer,
    CONSTRAINT buy_factor_pkey PRIMARY KEY (buy_factor_id),
    CONSTRAINT buy_factor_store_id_fkey FOREIGN KEY (store_id)
        REFERENCES public.stores (store_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

ALTER TABLE public.buy_factor
    OWNER to postgres;

CREATE TABLE public.bought_stuffs
(
    buy_factor_id integer,
    stuff_name character varying(20),
    price bigint NOT NULL,
    "number" smallint NOT NULL,
    PRIMARY KEY (buy_factor_id, stuff_name),
    FOREIGN KEY (buy_factor_id)
        REFERENCES public.buy_factor (buy_factor_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

ALTER TABLE public.bought_stuffs
    OWNER to postgres;
	