-- Overall Pretty Good
-- Please try to use foreign keys inside create table instead of using alter when possible
-- reorder your table creation such that you can add foreign keys/ primary keys into your table directly
-- you mainly only start altering table when there are schema/requirement changes segmented by version releases
-- after multiple releases of a piece of sofware you want to keep a specific alteration
-- For example version 1.0 we didn't have a linke between stock and company table
-- but in versino 2.0 we wanted the relationship between stock and company table to be present
-- after you do all the fixes please delete my comments - there are more comments below

-- Company
-- make sure all your primary keys are not null too
-- one company can have multiple stock symbols, not 1:1? great, because of googl goog
-- however, for many to one, you generally want the many refer to the one 
-- I guess it may be easier to think that multiple stocks belong to 1 company
-- please think about this carefully and let me know if you have any questions
-- j: but goog(alphabet) is a separate company from google(googl) right? they have have different company name, image, year found, etc
-- j: but perhaps we should just keep it simple and make it as one company

-- Many stocks One Company
-- If you have 1 company referencing multiple stocks, wuoldn't this create duplicate rows?
-- Let me know why?
-- If you have multiple stocks referencing 1 company, wouldn't this work better
-- Let me know why?
-- let me know what you think
-- j: yeah I agree it would be better for multiple stocks to reference 1 company. Therefore we wouldn't need 'symbol' in the company table right? We don't want 'symbol' because it depends on the stock table

CREATE TABLE company 
(
	company_id integer PRIMARY KEY NOT NULL,
	name character varying(50) NOT NULL,
	image character varying(100) NOT NULL,
	year_found numeric(4,0) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Stocks 
CREATE TABLE stock
(
	symbol character varying(20) NOT NULL PRIMARY KEY,
	company_id integer not null,
	price numeric NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	foreign key (company_id) references company (company_id)
);

-- Address
CREATE TABLE address
(
	address_id serial PRIMARY KEY,
	city_id integer NOT NULL, -- fk city(city_id)
	country_id integer NOT NULL, -- fk country(country_id)
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Company Address - create composite key on postgresql Primary Key (company_id, address_id) at the bottom - don't use
-- alter table
-- After you insert some test data try to do a address loook up of company grouped by
-- generate more test data for practice -> get all microsoft, amazon, google offices in california and insert into table
-- query the database and group by company
CREATE TABLE company_address
(
	company_address_id serial,
	company_id integer NOT NULL, -- fk company(company_id)
	address_id integer NOT NULL, -- fk address(address_id)
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- City
-- why are we splitting up city country etc again? why can't we include them in address
-- j: There may be repeated countries and cities, which we can move to their own table right? 
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

-- Company_News - create composite key on postgresql Primary Key (company_id, news_id) at the bottom
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
-- please don't alter table foreign key - please try to do it on table creation
-- this lets my know the constraints clearly but it would be much more concise to put it into your table creations
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
-- Stock
INSERT INTO stock (symbol, price)
	VALUES ('TSLA', '196.05');

-- Company
INSERT INTO company (symbol, name, image, year_found)
	VALUES ('TSLA', 'Tesla', 'goo.gl/JH8FT4', 2003);

-- Country
INSERT INTO country (country)
    VALUES ('USA');

-- City
INSERT INTO city (country_id, city)
    VALUES (1, 'San Carlos');

-- Address
INSERT INTO address (city_id, country_id)
    VALUES (1, 1);

-- Company_Address
INSERT INTO company_address (company_id,  address_id)
    VALUES (1, 1);

-- News
INSERT INTO news (article, description)
    VALUES ('https://goo.gl/PxV6Wd', 'Hedge Fund Manager Who Spotted Fraud at Enron Calls Tesla "The Anti-Amazon"');

-- Company_News
INSERT INTO company_news (company_id, news_id)
    VALUES (1, 1);























