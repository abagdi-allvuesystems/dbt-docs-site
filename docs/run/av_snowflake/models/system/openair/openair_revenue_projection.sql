
  create or replace   view AV_EDM.AV_SYSTEM.openair_revenue_projection
  
  
  
  
  as (
    WITH revenue_projection AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_revenue_projection
)

SELECT 
        currency::VARCHAR AS currency
        ,rate::FLOAT AS rate
        ,total::FLOAT AS total
        ,id::INT AS id
        ,project_task_id::INT AS project_task_id
        ,transaction_id::INT AS task_id
        ,project_billing_rule_id::INT AS project_billing_rule_id
        ,category_4_id::INT AS revcatgroupxref_id
        ,NULLIF(date,'0000-00-00')::DATE AS date
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,_extracted_at::TIMESTAMP_TZ AS raw_updated
        ,IFNULL(deleted,false)::BOOLEAN AS deleted

FROM
        revenue_projection
  );

