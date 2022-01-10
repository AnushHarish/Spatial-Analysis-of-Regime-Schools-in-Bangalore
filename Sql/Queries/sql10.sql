select schoolid, schoolname, passing_percentage_2020, 
dense_rank() 
over (order by Passing_percentage_2020 desc) as Rank
from gov_school_within2km