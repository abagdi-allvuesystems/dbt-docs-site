WITH assets_itsm AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_itsm_objects
), assets_ism AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_ism_objects
), assets_services AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_services_objects
)
, union_raw AS (
    SELECT id
            ,objecttype
            ,objectkey
            ,name
            ,label
            ,created
            ,updated
            ,globalid
            ,timestamp
            ,attributes
            ,workspaceid
            ,_airbyte_extracted_at
    FROM assets_itsm
    UNION 
    SELECT id
            ,objecttype
            ,objectkey
            ,name
            ,label
            ,created
            ,updated
            ,globalid
            ,timestamp
            ,attributes
            ,workspaceid
            ,_airbyte_extracted_at
    FROM assets_ism
    UNION
    SELECT id
            ,objecttype
            ,objectkey
            ,name
            ,label
            ,created
            ,updated
            ,globalid
            ,timestamp
            ,attributes
            ,workspaceid
            ,_airbyte_extracted_at
    FROM assets_services
)
SELECT id
        ,objecttype:id::INT AS objectType_id
        ,objecttype:objectSchemaId::INT AS objectSchema_id
        ,objectkey
        ,name
        ,label
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,globalid
        ,timestamp
        ,attributes
        ,workspaceid
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM union_raw