
  create or replace   view AV_EDM.AV_STAGING.dim_assets_services
  
  
  
  
  as (
    WITH assets_objects AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects
), asset_object_attributes AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects_attributes
), asset_attributes AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objectschema_attributes
), objects_attributes AS (
    SELECT ao.id
            ,ao.objecttype_id
            ,ao.objectschema_id
            ,ao.name
            ,ao.label
            ,aa.name AS attribute_name
            ,aoa.objectattributevalues
    FROM assets_objects ao JOIN asset_object_attributes aoa ON ao.id = aoa.objectid
                           JOIN asset_attributes aa ON aa.id = aoa.objecttypeattributeid
    WHERE ao.objectschema_id = 1 and ao.objecttype_id = 1
), org_pivot AS (
    SELECT *
    FROM (
        SELECT id,attribute_name,GET(PARSE_JSON(objectattributevalues),0):displayValue::VARCHAR as objectattributevalues
        FROM objects_attributes
    )
    PIVOT (
        MAX(objectattributevalues)
        FOR attribute_name IN (
            SELECT DISTINCT name
            FROM AV_EDM.AV_SYSTEM.assets_objectschema_attributes
            WHERE objecttype_id = 1
        )
    ) AS p
)
SELECT id AS object_id
    ,"'Key'" AS object_key
    ,"'Name'" AS service_name
    ,"'Description'" AS description
    ,"'Service ID'" AS jira_service_id
    ,"'Tier'" AS tier
    ,TRY_TO_TIMESTAMP_NTZ("'Created'", 'DD/MON/YY HH:MI PM') AS created
    ,TRY_TO_TIMESTAMP_NTZ("'Updated'", 'DD/MON/YY HH:MI PM') AS updated
FROM org_pivot
  );

