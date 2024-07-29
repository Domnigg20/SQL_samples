

--A formular   with a rates_per_thousand() function that takes
-- three arguments to calculate the result: observed_number,
--base_number, and decimal_places.

create or replace function rates_per_thousand( observed_number numeric, base_number numeric,  decimal_places int)
returns numeric as $$

 begin 

 if base_number = 0 then
        RAISE EXCEPTION 'base_number cannot be zero';
    END IF;

    -- Calculate the ratio and round it to the specified number of decimal places
    RETURN ROUND(observed_number / base_number, decimal_places);

END;

$$
language plpgsql;