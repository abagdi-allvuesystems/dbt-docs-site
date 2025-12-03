
  
    

create or replace transient table AV_EDM.AV_DATA_RIGHTS.ex_accounts_with_mutliple_active_contracts
    
    
    
    as (WITH customer_contracts AS (
    SELECT * FROM AV_EDM.AV_DATA_RIGHTS.customer_contracts
)
SELECT SF_ACCOUNT_ID
    ,COUNT(msa_contract_id) as Count_MSA
FROM customer_contracts
GROUP BY SF_ACCOUNT_ID
    )
;


  