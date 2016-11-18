create or replace function p8(t_num char, v_num char, acct_num char, amt decimal) returns void as $$
	declare
		v_bal_curr decimal := 0;
		c_bal_curr decimal := 0;
		c_bal decimal := 0;
		v_bal decimal := 0;
		c_info RECORD;
		v_info RECORD;
		t_info RECORD;
	begin
		INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount) VALUES
			(t_num, v_num, acct_num, CURRENT_DATE, amt);

		select vbalance into v_bal_curr from Vendor where Vno=v_num;
		v_bal := v_bal_curr + (amt * 0.96);
		UPDATE Vendor SET Vbalance=v_bal WHERE Vno=v_num;

		select Cbalance into c_bal_curr from Customer where Account=acct_num;
		c_bal := c_bal_curr + amt;
		UPDATE Customer SET Cbalance=c_bal WHERE Account=acct_num;

		IF EXISTS (select * from Customer where Account=acct_num and Cbalance > Crlimit)
		THEN
			select * from Customer where Account=acct_num and Cbalance > Crlimit into c_info;
			c_bal := c_info.Cbalance + ((c_info.Cbalance - c_info.Crlimit) * 0.1);
			UPDATE Customer SET Cbalance=c_bal WHERE Account=acct_num;
		END IF;

		select * from Customer where Account=acct_num into c_info;
		select * from Vendor where Vno=v_num into v_info;
		select * from Transaction where Tno=t_num into t_info;

		raise notice 'Customer: %, %, %, %, %', c_info.Account, c_info.Cname, c_info.Province, c_info.Cbalance, c_info.Crlimit;
		raise notice 'Customer: %, %, %, %', v_info.Vno, v_info.Vname, v_info.City, v_info.Vbalance;
		raise notice 'Customer: %, %, %, %, %', t_info.Tno, t_info.Vno, t_info.Account, t_info.T_Date, t_info.Amount;

	end;
$$ language plpgsql;
