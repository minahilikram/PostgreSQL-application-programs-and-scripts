create or replace function p7() returns void as $$
	declare
		c_bal decimal := 0;
		c_info RECORD;
	begin
		for c_info IN (select * from Customer where Cbalance > Crlimit) LOOP
			c_bal := c_info.Cbalance + ((c_info.Cbalance - c_info.Crlimit) * 0.1);
			raise notice 'Vendor name: %', c_info.cname;
			raise notice 'New Customer Balance: %', c_bal;
			raise notice '-----';

			UPDATE Customer SET Cbalance=c_bal WHERE Account=c_info.Account;
		END LOOP;
	end;
$$ language plpgsql;
