create or replace function p2(vendor_name char) returns void as $$
	declare
		vendor_num char(10);
		c_info RECORD;
		account_num char(10);
	begin
		for vendor_num IN (select Vno from Vendor where Vname = vendor_name) LOOP
			for account_num IN (select Account from Transaction where vendor_num = Vno) LOOP
				for c_info IN (select * from Customer where Account = account_num) LOOP
					raise notice 'Customer number: %', c_info.Account;
					raise notice 'Customer name: %', c_info.Cname;
					raise notice 'Province: %', c_info.Province;
					raise notice '-----';
				END LOOP;
			END LOOP;
		END LOOP;
	end;
$$ language plpgsql;
