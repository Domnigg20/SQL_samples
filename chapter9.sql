
----Answer to section 9 in Practical SQL, a beginner' guide.
----how many of the plants in the table process meat, and how many process poultry
SELECT 
    SUM(CASE WHEN activities ILIKE '%Meat Processing%' THEN 1 ELSE 0 END) AS meat_plants,
    SUM(CASE WHEN activities ILIKE '%Poultry Processing%' THEN 1 ELSE 0 END) AS poultry_plants
FROM public.meat_poultry_egg_inspect;
