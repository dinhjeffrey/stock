-- Stocks 
CREATE TABLE stocks
(
	stock_id character varying(20) NOT NULL,
	price numeric NOT NULL,
	last_update timestamp with time zone NOT NULL DEFAULT now(),
	CONSTRAINT stocks_pkey PRIMARY KEY (stock_id)
);

INSERT INTO stocks (stock_id, price)
	VALUES ('ORCL', '41.06');
