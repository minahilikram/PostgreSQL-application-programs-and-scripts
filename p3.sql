create or replace function p3(c_name char, prov char, lim decimal) returns void as $$
	declare
		number_of_customers int;
		acct_num char(10);
		c_info RECORD;
	begin
		select count(distinct Account) into number_of_customers from Customer;
		acct_num := 'A' || CAST((number_of_customers+1) as varchar(10));
		INSERT INTO Customer (Account, CNAME, Province, Cbalance, Crlimit) VALUES
			(acct_num, c_name, prov, 0, lim);

		for c_info IN (select * from Customer) LOOP
			raise notice 'Customer number: %', c_info.Account;
			raise notice 'Customer name: %', c_info.Cname;
			raise notice 'Province: %', c_info.Province;
			raise notice 'Customer balance: %', c_info.Cbalance;
			raise notice 'Customer limit: %', c_info.Crlimit;
			raise notice '-----';
		END LOOP;
	end;
$$ language plpgsql;
