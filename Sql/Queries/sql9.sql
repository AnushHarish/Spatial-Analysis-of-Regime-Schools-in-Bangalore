CREATE OR REPLACE VIEW gov_school_within2km
AS 
SELECT * FROM ben_gov_sch
WHERE (ST_DISTANCE(
	ST_TRANSFORM(ST_GEOMFROMTEXT('POINT(77.536142 12.971725)',4326), 32643),
	ST_TRANSFORM((wkb_geometry),32643)) <= 2000 )
    and (gender = 'co-ed') 
    and (medium_of_ = 'kannada') 
    and (busroutes != 'null');