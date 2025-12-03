
  create or replace   view AV_EDM.AV_SYSTEM.assets_objectschema_objecttypes
  
  
  
  
  as (
    WITH assets_objecttypes AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_objectschema_objecttypes
)
SELECT id
        ,objectschemaid
        ,name
        ,type
        ,description
        ,created::TIMESTAMP_TZ as created
        ,updated::TIMESTAMP_TZ as updated
        ,position
        ,inherited
        ,abstractobjecttype
        ,parentobjecttypeid
        ,parentobjecttypeinherited
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM assets_objecttypes
  );

