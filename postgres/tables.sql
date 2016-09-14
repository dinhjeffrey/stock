-- Stocks 
CREATE TABLE stock
(
	symbol character varying(20) NOT NULL PRIMARY KEY,
	price numeric NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Company
-- one company can have multiple stock symbols, not 1:1?
CREATE TABLE company 
(
	company_id serial PRIMARY KEY,
	symbol character varying(20) NOT NULL, -- fk stock(symbol)
	name character varying(50) NOT NULL,
	image character varying(100) NOT NULL,
	year_found numeric(4,0) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Address
CREATE TABLE address
(
	address_id serial PRIMARY KEY,
	city_id integer NOT NULL, -- fk city(city_id)
	country_id integer NOT NULL, -- fk country(country_id)
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Company Address
CREATE TABLE company_address
(
	company_address_id serial,
	company_id integer NOT NULL, -- fk company(company_id)
	address_id integer NOT NULL, -- fk address(address_id)
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- City
CREATE TABLE city
(
	city_id serial PRIMARY KEY,
	country_id integer NOT NULL, -- fk country(country_id)
	city character varying(100) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Country
CREATE TABLE country
(
	country_id serial PRIMARY KEY,
	country character varying(100) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Company_News
CREATE TABLE company_news
(
	company_news_id serial,
	company_id integer NOT NULL, -- fk company(company_id)
	news_id integer NOT NULL, -- fk news(news_id)
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- News
CREATE TABLE news
(
	news_id serial PRIMARY KEY,
	article character varying(50) NOT NULL,
	description character varying(200) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Alter tables to add Foreign Keys

-- company alter
ALTER TABLE company
ADD FOREIGN KEY (symbol) REFERENCES stock(symbol);

-- address alter
ALTER TABLE address
ADD FOREIGN KEY (city_id) REFERENCES city(city_id),
ADD FOREIGN KEY (country_id) REFERENCES country (country_id);

-- Company Address alter
ALTER TABLE company_address
ADD CONSTRAINT company_address_pkey PRIMARY KEY (company_address_id, company_id, address_id), -- composite key
ADD FOREIGN KEY (company_id) REFERENCES company (company_id),
ADD FOREIGN KEY (address_id) REFERENCES address (address_id);

-- city alter
ALTER TABLE city
ADD FOREIGN KEY (country_id) REFERENCES country (country_id);

-- Company News alter
ALTER TABLE company_news
ADD CONSTRAINT company_news_pkey PRIMARY KEY (company_news_id, company_id, news_id), -- composite key
ADD FOREIGN KEY (company_id) REFERENCES company (company_id),
ADD FOREIGN KEY (news_id) REFERENCES news (news_id);

-- INSERTS
INSERT INTO stock (symbol, price)
	VALUES ('ORCL', '41.06');





















	