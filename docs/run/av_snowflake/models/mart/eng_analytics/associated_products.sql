
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.associated_products
    
    
    
    as (WITH dim_assoc_prod AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_associated_products
)

SELECT issue_id
    ,associated_products_field_id
    ,associated_products_field_value

FROM dim_assoc_prod
    )
;


  