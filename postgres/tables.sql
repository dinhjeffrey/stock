-- c: let me know if you can also create triggers for timestamps
-- c: http://www.the-art-of-web.com/sql/trigger-update-timestamp/
-- j: added triggers, let me know what you think
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

select * from company;

-- INSERTS
-- Company
INSERT INTO company (company_id, name, image, year_found)
	VALUES (1, 'Tesla', 'goo.gl/JH8FT4', 2003);

update company set year_found = 2000 where year_found = 2003;

update company set year_found = 2020 where year_found = 2000;


-- Stock
-- INSERT INTO stock (symbol, price)
-- 	VALUES ('TSLA', '196.05');

-- Country
-- INSERT INTO country (country)
--     VALUES ('USA');

-- City
-- INSERT INTO city (country_id, city)
--     VALUES (1, 'San Carlos');

-- Address
-- INSERT INTO address (city_id, country_id)
--     VALUES (1, 1);

-- Company_Address
-- INSERT INTO company_address (company_id,  address_id)
--     VALUES (1, 1);

-- News
-- INSERT INTO news (article, description)
--     VALUES ('https://goo.gl/PxV6Wd', 'Hedge Fund Manager Who Spotted Fraud at Enron Calls Tesla "The Anti-Amazon"');

-- Company_News
-- INSERT INTO company_news (company_id, news_id)
--     VALUES (1, 1);

-- TRIGGERS
-- grabs all tables from current schema
select p.tablename
from pg_tables p
where p.schemaname='public';

-- trigger function
create function update_time() returns TRIGGER
	language plpgsql
	as $$
begin
	new.last_update := current_timestamp;
	return new;
	end;
	$$;

-- create the trigger on tables:
-- stock
-- address
-- company
-- company_address
-- news
-- company_news

create trigger trigger_last_update
	before update on company -- rotate each table
	for each row execute procedure update_time();


























