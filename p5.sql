create or replace function p5() returns void as $$
	declare
		trans_total decimal;
		v_bal decimal := 0;
		v_info RECORD;
		vendor_name char(50);
	begin
		for v_info IN (select * from Vendor) LOOP
			for trans_total IN (select SUM(Amount) from Transaction where v_info.Vno = Vno) LOOP
			END LOOP;
			IF NOT EXISTS (select * from Transaction where v_info.Vno = Vno)
			THEN
				trans_total := 0;
			END IF;
			v_bal := v_info.Vbalance + trans_total;
			raise notice 'Vendor number: %', v_info.Vno;
			raise notice 'Vendor name: %', v_info.vname;
			raise notice 'Total amount: %', v_bal;
			raise notice '-----';

			UPDATE Vendor SET Vbalance=v_bal WHERE Vno=v_info.Vno;
		END LOOP;
	end;
$$ language plpgsql;
