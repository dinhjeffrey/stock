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




