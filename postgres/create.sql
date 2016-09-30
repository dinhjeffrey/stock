-- Company
CREATE TABLE IF NOT EXISTS company
(
	company_id integer PRIMARY KEY NOT NULL,
	name character varying(100) NOT NULL,
	image character varying(250) NOT NULL,
	year_found numeric(4,0) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Stocks
CREATE TABLE IF NOT EXISTS stock
(
	symbol character varying(20) NOT NULL PRIMARY KEY,
	company_id integer not null,
	price numeric NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	foreign key (company_id) references company (company_id)
);

-- Address
CREATE TABLE IF NOT EXISTS address
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

CREATE TABLE IF NOT EXISTS company_address
(
	company_id integer NOT NULL,
	address_id integer NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	PRIMARY KEY (company_id, address_id),
	foreign key (company_id) references company (company_id),
	foreign key (address_id) references address (address_id)
);

-- News
CREATE TABLE IF NOT EXISTS news
(
	news_id integer not null PRIMARY KEY,
	article_url character varying(250) NOT NULL,
	description character varying(500) NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now()
);

-- Company_News - create composite key on postgresql Primary Key (company_id, news_id) at the bottom
CREATE TABLE IF NOT EXISTS company_news
(
	company_id integer NOT NULL, -- fk company(company_id)
	news_id integer NOT NULL, -- fk news(news_id)
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	PRIMARY KEY (company_id, news_id),
	foreign key (company_id) references company (company_id),
	foreign key (news_id) references news (news_id)
);



