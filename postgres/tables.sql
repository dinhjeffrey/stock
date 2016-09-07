-- Stocks 
CREATE TABLE stock
(
	symbol character varying(20) NOT NULL,
	price numeric NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	CONSTRAINT stocks_pkey PRIMARY KEY (symbol)
);

INSERT INTO stock (symbol, price)
	VALUES ('ORCL', '41.06');

-- Company
-- one company can have multiple stock symbols, not 1:1?
CREATE TABLE company 
(
	company_id integer NOT NULL DEFAULT nextval('company_company_id_seq'::regclass),
	name character varying(50) NOT NULL,
	image character varying(100) NOT NULL,
	year_founded numeric(4,0) NOT NULL,
	CONSTRAINT company_pkey PRIMARY KEY (company_id),
)

-- Company Address
CREATE TABLE company_address
(
	company_address_id integer NOT NULL DEFAULT nextval('company_company_id_seq'::regclass),
	company_id integer NOT NULL DEFAULT,
	address_id integer NOT NULL DEFAULT,
	CONSTRAINT company_address_pkey PRIMARY KEY (company_address_id, company_id, address_id),
	CONSTRAINT fk_company_address FOREIGN KEY (company_id)
		REFERENCES public.company (company_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
	CONSTRAINT fk_company_address FOREIGN KEY (address_id)
		REFERENCES public.address (company_id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)

-- Address
