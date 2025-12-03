WITH assets_objects AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects
), asset_object_attributes AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects_attributes
), asset_objecttypes AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objectschema_objecttypes
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
                        JOIN asset_objecttypes aot ON ao.objecttype_id = aot.id
                        JOIN asset_attributes aa ON aa.id = aoa.objecttypeattributeid
    WHERE aot.name = 'AVS Services'
), avs_service_pivot AS (
    SELECT *
    FROM (
        SELECT id
            ,attribute_name
            --,GET(PARSE_JSON(objectattributevalues),0):displayValue::VARCHAR as objectattributevalues
            ,objectattributevalues
        FROM objects_attributes
    )
    PIVOT (
        MAX(objectattributevalues)
        FOR attribute_name IN (
            SELECT DISTINCT name
            FROM AV_EDM.AV_SYSTEM.assets_objectschema_attributes
            WHERE objecttype_id = 18
        )
    ) AS p
)
SELECT id AS object_id
    ,GET(PARSE_JSON("'Key'"),0):displayValue::VARCHAR AS object_key
    ,GET(PARSE_JSON("'Name'"),0):displayValue::VARCHAR AS object_name
    ,GET(PARSE_JSON("'JSM Service'"),0):displayValue::VARCHAR AS jsm_service_name
    ,GET(PARSE_JSON("'JSM Service'"),0):referencedObject:id::INT AS jsm_service_object_id
    ,GET(PARSE_JSON("'JSM Service'"),0):referencedObject:objectKey::VARCHAR AS jsm_service_object_key
    ,GET(PARSE_JSON("'Affected Service ListID'"),0):displayValue::VARCHAR AS affected_service_field_option_id
    ,GET(PARSE_JSON("'Internal or Client'"),0):displayValue::VARCHAR AS internal_or_client
    ,GET(PARSE_JSON("'Product Vertical'"),0):displayValue::VARCHAR AS product_vertical
    ,TRY_TO_TIMESTAMP_NTZ(GET(PARSE_JSON("'Created'"),0):displayValue::VARCHAR, 'DD/MON/YY HH:MI PM') AS created
    ,TRY_TO_TIMESTAMP_NTZ(GET(PARSE_JSON("'Updated'"),0):displayValue::VARCHAR, 'DD/MON/YY HH:MI PM') AS updated
FROM avs_service_pivot