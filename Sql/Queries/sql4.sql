ALTER TABLE bang_boundry ADD COLUMN NumSch INTEGER DEFAULT 0;
 
SELECT bd.ogc_fid,bd.pin_code,bd.area_name, count(*) as NumSchInpincode
FROM bang_boundry as bd, ben_gov_sch as bgs
where ST_CONTAINS(bd.wkb_geometry,bgs.wkb_geometry) 
group by bd.ogc_fid
 
With PolygonQuery as (
SELECT bd.ogc_fid,bd.pin_code,bd.area_name, count(*) as NumSchInpincode
FROM bang_boundry as bd, ben_gov_sch as bgs
where ST_CONTAINS(bd.wkb_geometry,bgs.wkb_geometry) 
group by bd.ogc_fid
)
UPDATE bang_boundry
SET NumSch = PolygonQuery.NumSchInpincode
FROM PolygonQuery
WHERE PolygonQuery.ogc_fid = bang_boundry.ogc_fid;
 
 
SELECT ogc_fid,pin_code, area_name, NumSch from bang_boundry 
ORDER BY NumSch DESC;