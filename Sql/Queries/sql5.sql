ALTER TABLE bang_boundry ADD COLUMN NumSchDen REAL DEFAULT 0.0;
SELECT bd.ogc_fid,bd.pin_code,bd.area_name,
count(*)/(ST_Area(ST_Transform(bd.wkb_geometry,32643))/1000000) as SchoolsPerKM2
FROM bang_boundry as bd, ben_gov_sch as bgs
where ST_CONTAINS(bd.wkb_geometry,bgs.wkb_geometry) 
group by bd.ogc_fid
With PolygonQuery as (
 SELECT bd.ogc_fid,bd.pin_code,bd.area_name,
count(*)/(ST_Area(ST_Transform(bd.wkb_geometry,32643))/1000000) as SchoolsPerKM2
FROM bang_boundry as bd, ben_gov_sch as bgs
where ST_CONTAINS(bd.wkb_geometry,bgs.wkb_geometry) 
group by bd.ogc_fid
)
UPDATE bang_boundry
SET NumSchDen = PolygonQuery.SchoolsPerKM2
FROM PolygonQuery
WHERE PolygonQuery.ogc_fid = bang_boundry.ogc_fid;
 
SELECT ogc_fid,pin_code, area_name, NumSch, NumSchDen from bang_boundry 
ORDER BY NumSchDen DESC;