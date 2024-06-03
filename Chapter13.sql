UPDATE crime_reports
SET date_1 = (
    TO_CHAR(
        TO_DATE((regexp_match(original_text, '\d{1,2}\/\d{1,2}\/\d{2}'))[1], 'MM/DD/YY'),
        'YYYY-MM-DD'
    )
    || ' ' ||
    SUBSTRING((regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1] FROM 1 FOR 2) -- Extracts hours
    || ':' ||
    SUBSTRING((regexp_match(original_text, '\/\d{2}\n(\d{4})'))[1] FROM 3 FOR 2) -- Extracts minutes
    || ' US/Eastern'
)::timestamptz;

SELECT crime_id,
       date_1,
       original_text
FROM crime_reports;
