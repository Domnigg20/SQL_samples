WITH state_median_populations AS (
    SELECT
        state_us_abbreviation,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY p0010001) AS median_population
    FROM
        us_counties_2010
    GROUP BY
        state_us_abbreviation
)
SELECT
    state_us_abbreviation,
    median_population
FROM
    state_median_populations
WHERE
    state_us_abbreviation IN ('CA', 'NY');

