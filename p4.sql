create or replace function p4() returns void as $$
	declare
		t_info RECORD;
		c_info RECORD;
		vendor_name char(50);
	begin
		for c_info IN (select * from Customer) LOOP
			for t_info IN (select * from Transaction where c_info.Account = Account and T_Date = (select max(T_Date) from Transaction where c_info.Account = Account)) LOOP
				select vname into vendor_name from Vendor where t_info.Vno = Vno;
				raise notice 'Account number: %', c_info.Account;
				raise notice 'Customer name: %', c_info.Cname;
				raise notice 'Amount: %', t_info.Amount;
				raise notice 'Vendor Name: %', vendor_name;
				raise notice '-----';

			END LOOP;
			IF NOT EXISTS (select * from Transaction where c_info.Account = Account and T_Date = (select max(T_Date) from Transaction where c_info.Account = Account))
			THEN
				select vname into vendor_name from Vendor where t_info.Vno = Vno;
				raise notice 'Account number: %', c_info.Account;
				raise notice 'Customer name: %', c_info.Cname;
				raise notice 'No Transaction';
				raise notice '-----';
			END IF;
		END LOOP;
	end;
$$ language plpgsql;
