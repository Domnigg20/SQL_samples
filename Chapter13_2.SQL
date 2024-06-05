---Imagine in our dataset, any of these 3 scenarios

--1. A second hour exists but not a second date. This occurs when a
--report covers a range of hours on one date.
--2. A second date and second hour exist. This occurs when a report
--covers more than one date.
--3. Neither a second date nor a second hour exists.


UPDATE crime_reports
SET 
    date_1 = (
        to_char(
            to_date(
                (regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1], 
                'MM/DD/YY'
            ), 
            'YYYY-MM-DD'
        )
        || ' ' ||
        (regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1]
        || ' US/Eastern'
    )::timestamptz,
    
    date_2 = (
        CASE
            WHEN (
                (SELECT regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})')) IS NULL
                AND 
                (SELECT regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})')) IS NOT NULL
            ) THEN (
                to_char(
                    to_date(
                        (regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1], 
                        'MM/DD/YY'
                    ), 
                    'YYYY-MM-DD'
                )
                || ' ' ||
                (regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})'))[1]
                || ' US/Eastern'
            )::timestamptz
            WHEN (
                (SELECT regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})')) IS NOT NULL
                AND 
                (SELECT regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})')) IS NOT NULL
            ) THEN (
                to_char(
                    to_date(
                        (regexp_match(original_text, '-(\d{1,2}\/\d{1,2}\/\d{1,2})'))[1], 
                        'MM/DD/YY'
                    ), 
                    'YYYY-MM-DD'
                )
                || ' ' ||
                (regexp_match(original_text, '\/\d{2}\n\d{4}-(\d{4})'))[1]
                || ' US/Eastern'
            )::timestamptz
            ELSE NULL
        END
    ),
    
    street = (regexp_match(original_text, 'hrs.\n(\d+ .+(?:Sq.|Plz.|Dr.|Ter.|Rd.))'))[1],
    city = (regexp_match(original_text, '(?:Sq.|Plz.|Dr.|Ter.|Rd.)\n(\w+ \w+|\w+)\n'))[1],
    crime_type = (regexp_match(original_text, '\n(?:\w+ \w+|\w+)\n(.*):'))[1],
    description = (regexp_match(original_text, ':\s(.+)(?:C0|SO)'))[1],
    case_number = (regexp_match(original_text, '(?:C0|SO)[0-9]+'))[1];
