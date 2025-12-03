
  create or replace   view AV_EDM.AV_SYSTEM.openair_custom_field_mapping
  
  
  
  
  as (
    WITH custom_field AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_cust_field order by created desc
), custom_field_link AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_cust_field_link
)

SELECT 
        field.id::INT AS id
        ,field.name::VARCHAR AS name
        ,field.description::VARCHAR AS description
        ,field.association::VARCHAR AS association
        ,field.title::VARCHAR AS title
        ,field.active::BOOLEAN AS active
        ,field.created::TIMESTAMP_TZ AS created
        ,field.updated::TIMESTAMP_TZ AS updated
        ,field._extracted_at::TIMESTAMP_TZ AS raw_updated
        ,link.cust_field_id::VARCHAR AS cust_field_id

FROM 
        custom_field field
LEFT JOIN 
        custom_field_link link on field.id = link.id
  );

