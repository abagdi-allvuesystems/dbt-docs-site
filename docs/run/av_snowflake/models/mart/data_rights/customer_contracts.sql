
  
    

create or replace transient table AV_EDM.AV_DATA_RIGHTS.customer_contracts
    
    
    
    as (WITH msa_contract AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_contract_msa
), product_rider AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_contract_product_rider
)
SELECT msa.contract_id AS msa_contract_id
    ,msa.contract_number AS msa_contract_number
    ,msa.account_id AS sf_account_id
    ,msa.initial_contract_term_start_date AS msa_initial_contract_term_start_date
    ,msa.current_contract_term_end_date AS msa_current_contract_term_end_date
    ,CASE WHEN DATA_RIGHTS IN ('Clause B', 'Clause C', 'Clause D', 'Clause E', 'Clause F') THEN true ELSE false END AS has_data_rights
    ,CASE WHEN DATA_RIGHTS IN ('Clause B', 'Clause C', 'Clause D', 'Clause E', 'Clause F') THEN 1 ELSE 0 END AS has_data_rights_count
    ,msa.data_rights
    ,msa.data_rights_last_updated AS data_rights_last_updated
    ,COUNT(pr.contract_id) AS count_active_product_riders
    ,MAX(pr.term_stage) AS product_riders_term_stage
    ,MAX(pr.current_contract_term_start_date) as active_product_rider_term_start_date
    ,MIN(pr.current_contract_term_end_date) AS active_product_rider_term_end_date
FROM msa_contract msa LEFT JOIN product_rider AS pr ON msa.contract_id = pr.msa_contract_id
WHERE msa.status = 'Activated' AND pr.status = 'Activated' AND IFNULL(msa.msa_deployment_type,'Hosted') != 'On-Prem'
GROUP BY msa.contract_id
        ,msa.contract_number
        ,msa.account_id
        ,msa.initial_contract_term_start_date
        ,msa.current_contract_term_end_date
        ,msa.data_rights
        ,msa.data_rights_last_updated
    )
;


  