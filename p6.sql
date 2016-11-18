create or replace function p6() returns void as $$
	declare
		v_bal decimal := 0;
		v_info RECORD;
	begin
		for v_info IN (select * from Vendor) LOOP
			v_bal := v_info.Vbalance * 0.96;
			raise notice 'Vendor name: %', v_info.vname;
			raise notice 'Fee Charged: %', v_info.Vbalance * 0.04;
			raise notice 'New Vendor Balance: %', v_bal;
			raise notice '-----';

			UPDATE Vendor SET Vbalance=v_bal WHERE Vno=v_info.Vno;
		END LOOP;
	end;
$$ language plpgsql;
