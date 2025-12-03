
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.market_segment
    
    
    
    as (WITH dim_market_segment AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_market_segment
)

SELECT issue_id
    ,market_segement_field_id
    ,market_segement_field_value

FROM dim_market_segment
    )
;


  