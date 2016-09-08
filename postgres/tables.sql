-- Stocks 
CREATE TABLE stock
(
	symbol character varying(20) NOT NULL PRIMARY KEY,
	price numeric NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

--INSERT INTO stock (symbol, price)
	--VALUES ('ORCL', '41.06');

-- Company
-- one company can have multiple stock symbols, not 1:1?
CREATE TABLE company 
(
	company_id serial PRIMARY KEY,
	symbol character varying(20) REFERENCES stock (symbol),
	name character varying(50) NOT NULL,
	image character varying(100) NOT NULL,
	year_founded numeric(4,0) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Address
CREATE TABLE address
(
	address_id integer PRIMARY KEY,
	city character varying(100) NOT NULL,
	country character varying(100) NOT NULL, -- we can make this country_id and make a country table?
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Company Address
CREATE TABLE company_address
(
	company_address_id serial,
	company_id integer NOT NULL REFERENCES company (company_id),
	address_id integer NOT NULL REFERENCES address (address_id),
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	CONSTRAINT company_address_pkey PRIMARY KEY (company_address_id, company_id, address_id)
);
