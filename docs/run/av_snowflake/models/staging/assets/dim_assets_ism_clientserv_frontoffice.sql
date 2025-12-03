
  create or replace   view AV_EDM.AV_STAGING.dim_assets_ism_clientserv_frontoffice
  
  
  
  
  as (
    WITH assets_objects AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects
), asset_object_attributes AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects_attributes
), asset_objecttypes AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objectschema_objecttypes
), asset_attributes AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objectschema_attributes
), asset_object_attribute_values AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects_attributes_values
), front_office_objects AS (
    SELECT ao.id
            ,ao.objecttype_id
            ,ao.objectschema_id
            ,ao.name
            ,ao.label
            ,aoa.id AS asset_object_attribute_id
            ,aoa.objecttypeattributeid AS assost_objecttype_attribute_id
            ,aa.name AS attribute_name
            ,aoav.displayValue AS displayValue
            ,aoav.searchValue AS searchValue
    FROM assets_objects ao JOIN asset_object_attributes aoa ON ao.id = aoa.objectid
                        JOIN asset_objecttypes aot ON ao.objecttype_id = aot.id
                        JOIN asset_attributes aa ON aa.id = aoa.objecttypeattributeid AND aa.objecttype_id = aot.id
                        JOIN asset_object_attribute_values aoav ON aoa.id = aoav.objectattributeid
    WHERE aot.name = 'Front Office'
), return_values AS (
    SELECT id
            ,attribute_name
            ,CASE WHEN attribute_name = 'Client' THEN searchvalue ELSE displayvalue END AS returnvalue
    FROM front_office_objects
)
SELECT * 
FROM (SELECT id,attribute_name,returnvalue
      FROM return_values)
    PIVOT (
        MAX(returnvalue)
        FOR attribute_name IN ('Key'
                                ,'Name'
                                ,'Client'
                                ,'Everest App Server'
                                ,'Everest DB Server'
                                ,'Everest App Database'
                                ,'Everest App Warehouse Database'
                                ,'Everest Version (Build)'
                                ,'Service Tier'
                                ,'Created'
                                ,'Updated')
    ) AS p(id,key,name,client,everest_app_server,everest_db_server,everest_app_database,everest_app_warehouse_database,everest_version_build,service_tier,created,updated)
  );

