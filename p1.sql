create or replace function p1(customer_name char) returns void as $$
	declare
		account_num char(10);
		t_info RECORD;
		vendor_name char(10);
	begin
		for account_num IN (select account from Customer where cname = customer_name) LOOP
			for t_info IN (select * from Transaction where account_num = Account) LOOP
				select vname into vendor_name from Vendor where t_info.Vno = Vno;
				raise notice 'Vendor name: %', vendor_name;
				raise notice 'Date: %', t_info.T_Date;
				raise notice 'Amount: %', t_info.Amount;
				raise notice '-----';
			END LOOP;
		END LOOP;
	end;
$$ language plpgsql;
