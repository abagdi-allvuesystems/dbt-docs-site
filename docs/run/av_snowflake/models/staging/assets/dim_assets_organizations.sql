
  create or replace   view AV_EDM.AV_STAGING.dim_assets_organizations
  
  
  
  
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
    WHERE aot.name = 'Organizations'
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
            WHERE objecttype_id = 9
        )
    ) AS p
)
SELECT id AS object_id
    ,"'Key'" AS object_key
    ,"'Organization Name'" AS organization_name
    ,"'SalesforceAccountID'" AS salesforce_account_id
    ,"'JSM ID'" AS jsm_id
    ,"'Customer List Item ID'" AS customer_list_item_id
    ,"'Salesforce Customer Inactive Override'" AS salesforce_customer_inactive_override
    ,TRY_TO_TIMESTAMP_NTZ("'Customer Inactive Date'", 'DD/MON/YY') as customer_inactive_date
    ,"'Production Services Inactive'" AS production_services_inactive
    ,TRY_TO_TIMESTAMP_NTZ("'Production Services Inactive Date'", 'DD/MON/YY') AS production_services_inactive_date
    ,"'Test - Demo - System Account'" AS test_demo_system_account
    ,TRY_TO_TIMESTAMP_NTZ("'Created'", 'DD/MON/YY HH:MI PM') AS created
    ,TRY_TO_TIMESTAMP_NTZ("'Updated'", 'DD/MON/YY HH:MI PM') AS updated
FROM org_pivot
  );

