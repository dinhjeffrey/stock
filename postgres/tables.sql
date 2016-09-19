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

-- c: we can just have city & country as character in the address table - so the tradeoff here is
-- every time you query address you have to do a join in order to get city and country, don't you think it's
-- a little too much work to grab address? 
-- However, if you really want to do this please use lookup table instead
-- The reason behind lookup table is so that you can ensure spelling is consistent for countries & stuff are consistent
-- preload all the countries with codes and stuff
-- btw, you can't avoid duplicate countries cities even if you add a link haha :) - companies can be located in the same
-- city and country etc. -> in the end you will be having duplicate city ids XD - think about it a little more
-- let me know if I am right or wrong
-- j: From what I searched online, a lookup table replaces a column in the main table into it's own table right?
-- When I linked the country and city table via country_id, city_id, wouldn't it be a lookup table?  
-- but yeah I agree it is more work using multiple joins to just get the address
-- I have changed the address table, lemme know what you think. I also added phone number because I notice addresses included phone number too

-- Address
CREATE TABLE address
(
	address_id integer not null PRIMARY KEY,
	street character varying(500) not null,
	city character varying(250) not null,
	state character varying(250) not null,
	zip integer not null,
	country character varying(250) not null,
	phone_number integer not null,
	last_update timestamp with time zone NOT NULL DEFAULT now()
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

-- Microsoft
/*
Address:
3 Park Plaza, Suite 1600 
Irvine, CA 92614 
Phone:(949) 263-3000 
Fax:(949) 252-8618

Address:
13031 West Jefferson Boulevard, Suite 200 
Los Angeles, CA 90094 
Phone:(213) 806-7300

Address:
9255 Towne Centre Dr., Suite 400 
San Diego, CA 92121 
Phone:(858) 909-3800 
Fax:(858) 909-3838

*/

-- Google
/*
Google Inc.
1600 Amphitheatre Parkway
Mountain View, CA 94043
Phone: +1 650-253-0000

Google Orange County
19510 Jamboree Road
Suite 300
Irvine, CA 92612
Phone: +1 949-794-1600

Google Los Angeles
340 Main Street
Los Angeles, CA 90291
Phone: +1 310-310-6000

Google San Francisco
345 Spear Street
San Francisco, CA 94105
Phone: +1 415-736-0000
*/

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























