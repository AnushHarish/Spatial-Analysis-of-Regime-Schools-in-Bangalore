DROP TABLE IF EXISTS "ben_gov_sch" CASCADE;
create table ben_gov_sch as
(select gs.ogc_fid as ogc_fid,gs.wkb_geometry as wkb_geometry,
gs.district as district, gs.block as block, gs.cluster as cluster, gs.schoolid as schoolid,
gs.schoolname as schoolname, gs.category as category, gs.gender as gender, gs.medium_of_ as medium_of_,
gs.address as address, gs.area as area, gs.pincode as pincode, gs.landmark as landmark, gs.busroutes as busroutes
from gov_school as gs, bang_boundry as bd 
where ST_CONTAINS(bd.wkb_geometry,gs.wkb_geometry) 
group by gs.ogc_fid;
select * from ben_gov_sch;
