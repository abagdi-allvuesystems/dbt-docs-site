
  
    

create or replace transient table AV_EDM.AV_DATA_RIGHTS.fact_customer_data_rights_trend
    
    
    
    as (WITH customer_contracts AS (
    select * from AV_EDM.AV_DATA_RIGHTS.customer_contracts
), fact_cust_status AS (
    SELECT * FROM AV_EDM.AV_CORE.fact_customer_status
)
select fcs.date as date
    ,fcs.sf_account_id as sf_account_id
    ,CASE WHEN cc.has_data_rights = true and fcs.is_active = true then true else false END::BOOLEAN as has_data_rights
    ,CASE WHEN cc.has_data_rights = true and fcs.is_active = true then 1 else 0 END::INT as has_data_rights_count
    ,CASE WHEN cc.has_data_rights = true and fcs.is_active = true then cc.data_rights else NULL END::VARCHAR as data_rights_clause
from fact_cust_status fcs LEFT JOIN customer_contracts cc on fcs.sf_account_id = cc.sf_account_id and cc.data_rights_last_updated >= fcs.date
    )
;


  