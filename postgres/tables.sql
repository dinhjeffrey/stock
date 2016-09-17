CREATE TABLE company
(
	company_id integer PRIMARY KEY NOT NULL,
	name character varying(100) NOT NULL,
	image character varying(250) NOT NULL,
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

-- Country
CREATE TABLE country
(
	country_id integer not null PRIMARY KEY,
	country character varying(250) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- City
-- why are we splitting up city country etc again? why can't we include them in address
-- j: There may be duplicate countries and cities, which we can move to their own table right?
-- j: nvm, i deleted city_id from address table. does it make sense the way it is now?
-- c: we can just have city & country as character in the address table - so the tradeoff here is
-- every time you query address you have to do a join in order to get city and country, don't you think it's
-- a little too much work to grab address? 
-- However, if you really want to do this please use lookup table instead
-- The reason behind lookup table is so that you can ensure spelling is consistent for countries & stuff are consistent
-- preload all the countries with codes and stuff
-- btw, you can't avoid duplicate countries cities even if you add a link haha :) - companies can be located in the same
-- city and country etc. -> in the end you will be having duplicate city ids XD - think about it a little more
-- let me know if I am right or wrong

CREATE TABLE city
(
	city_id integer not null PRIMARY KEY,
	country_id integer NOT NULL,
	city character varying(250) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	foreign key (country_id) references country (country_id)
);

-- Address
CREATE TABLE address
(
	address_id integer not null PRIMARY KEY,
	city_id integer not null,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	FOREIGN KEY (city_id) REFERENCES city (city_id)
);

CREATE TABLE company_address
(
	company_id integer NOT NULL,
	address_id integer NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	PRIMARY KEY (company_id, address_id),
	foreign key (company_id) references company (company_id),
	foreign key (address_id) references address (address_id)
);

-- News
CREATE TABLE news
(
	news_id integer not null PRIMARY KEY,
	article_url character varying(250) NOT NULL,
	description character varying(500) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Company_News - create composite key on postgresql Primary Key (company_id, news_id) at the bottom
CREATE TABLE company_news
(
	company_id integer NOT NULL, -- fk company(company_id)
	news_id integer NOT NULL, -- fk news(news_id)
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	PRIMARY KEY (company_id, news_id),
	foreign key (company_id) references company (company_id),
	foreign key (news_id) references news (news_id)
);



-- After you insert some test data try to do a address loook up of company grouped by
-- generate more test data for practice -> get all microsoft, amazon, google offices in california and insert into table
-- query the database and group by company





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























