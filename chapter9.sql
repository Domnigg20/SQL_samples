
----Answer to section 9 in Practical SQL, a beginner' guide.
----how many of the plants in the table process meat, and how many process poultry
----File in crime_report.csv .
SELECT COUNT(activities) 
FROM public.meat_poultry_egg_inspect mpi
WHERE EXISTS (
    SELECT * 
    FROM meat_poultry_egg_inspect_temp temp
    WHERE temp.activities = mpi.activities
    AND (temp.activities ILIKE '%Meat Processing%' )
);
