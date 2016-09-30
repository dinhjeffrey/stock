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























