
  create or replace   view AV_EDM.AV_STAGING.dim_assets_users_internal
  
  
  
  
  as (
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
    WHERE aot.name = 'Internal'
), avs_users_internal_pivot AS (
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
            WHERE objecttype_id = 4
        )
    ) AS p
)
SELECT id AS object_id
    ,GET(PARSE_JSON("'Key'"),0):displayValue::VARCHAR AS object_key
    ,GET(PARSE_JSON("'Full Name'"),0):displayValue::VARCHAR AS full_name
    ,GET(PARSE_JSON("'First Name'"),0):displayValue::VARCHAR AS first_name
    ,GET(PARSE_JSON("'Last Name'"),0):displayValue::VARCHAR AS last_name
    ,GET(PARSE_JSON("'Email Address'"),0):displayValue::VARCHAR AS email_address
    ,GET(PARSE_JSON("'City'"),0):displayValue::VARCHAR AS city
    ,GET(PARSE_JSON("'State'"),0):displayValue::VARCHAR AS state
    ,GET(PARSE_JSON("'Country'"),0):displayValue::VARCHAR AS country
    ,GET(PARSE_JSON("'Jira Account ID'"),0):displayValue::VARCHAR AS jira_account_id
    ,GET(PARSE_JSON("'Regional Office'"),0):displayValue::VARCHAR AS regional_office
    ,GET(PARSE_JSON("'Title'"),0):displayValue::VARCHAR AS title
    ,TRY_TO_TIMESTAMP_NTZ(GET(PARSE_JSON("'Start Date'"),0):displayValue::VARCHAR, 'DD/MON/YY') as start_date
    ,TRY_TO_TIMESTAMP_NTZ(GET(PARSE_JSON("'Termination Date'"),0):displayValue::VARCHAR, 'DD/MON/YY') as termination_date
    ,GET(PARSE_JSON("'Is Active'"),0):displayValue::boolean AS is_active
    ,GET(PARSE_JSON("'Is Supervisor'"),0):displayValue::boolean AS is_supervisor
    ,GET(PARSE_JSON("'ADP Business Unit'"),0):displayValue::VARCHAR AS adp_business_unit
    ,GET(PARSE_JSON("'Supervisor'"),0):displayValue::VARCHAR AS supervisor_display_name
    ,GET(PARSE_JSON("'Supervisor'"),0):referencedObject:id::INT AS supervisor_object_id
    ,GET(PARSE_JSON("'Supervisor'"),0):referencedObject:objectKey::VARCHAR AS supervisor_object_key
    ,GET(PARSE_JSON("'ADP AssociateOID'"),0):displayValue::VARCHAR AS adp_associate_oid
    ,GET(PARSE_JSON("'ADP WorkerID'"),0):displayValue::VARCHAR AS adp_worker_id
    ,GET(PARSE_JSON("'Department'"),0):displayValue::VARCHAR AS department
    ,GET(PARSE_JSON("'Functional Team'"),0):displayValue::VARCHAR AS functional_team
    ,TRY_TO_TIMESTAMP_NTZ(GET(PARSE_JSON("'Created'"),0):displayValue::VARCHAR, 'DD/MON/YY HH:MI PM') AS created
    ,TRY_TO_TIMESTAMP_NTZ(GET(PARSE_JSON("'Updated'"),0):displayValue::VARCHAR, 'DD/MON/YY HH:MI PM') AS updated
    ,GET(PARSE_JSON("'User'"),0):displayValue::VARCHAR AS user_display_name
    ,GET(PARSE_JSON("'User'"),0):searchValue::VARCHAR AS user_account_id
FROM avs_users_internal_pivot
  );

