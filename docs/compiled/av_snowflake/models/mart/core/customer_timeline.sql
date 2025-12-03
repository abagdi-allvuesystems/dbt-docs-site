WITH sf_cust AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), sf_accts AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), msa_contract_active_or_expired AS (
    SELECT * 
    FROM AV_EDM.AV_STAGING.dim_sf_contract_msa
    where status in ('Activated','Expired')
), product_rider_active_or_expired AS (
    SELECT * 
    FROM AV_EDM.AV_STAGING.dim_sf_contract_product_rider
    where status in ('Activated','Expired')
), full_contract_details AS (
    select sfa.id
            ,sfa.name
            ,sfa.type
            ,mae.contract_id as msa_contract_id
            ,mae.contract_number as msa_contract_number
            ,mae.status as msa_status
            ,mae.initial_contract_term_start_date as msa_initial_contract_term_start_date
            ,mae.current_contract_term_end_date as msa_current_contract_term_end_date
            ,pae.contract_id as pr_contract_id
            ,pae.contract_number as pr_contract_number
            ,pae.status as pr_status
            ,pae.initial_contract_term_start_date as pr_initial_contract_term_start_date
            ,pae.current_contract_term_end_date as pr_current_contract_term_end_date
    from sf_accts sfa JOIN msa_contract_active_or_expired mae ON sfa.id = mae.account_id
                    JOIN product_rider_active_or_expired pae ON sfa.id = pae.account_id
), list as (
    select id
            ,name
            ,type
            ,MIN(msa_initial_contract_term_start_date)::DATE as first_msa_start_date
            ,MIN(pr_initial_contract_term_start_date)::DATE as first_product_rider_start_date
            ,MAX(msa_current_contract_term_end_date)::DATE as last_msa_end_date
            ,MAX(pr_current_contract_term_end_date)::DATE as last_product_rider_end_date
    from full_contract_details
    group by id,name,type
), msa_data_rights as (
    select account_id
            ,MIN(initial_contract_term_start_date) as data_rights_aquired_date
    from msa_contract_active_or_expired
    where has_data_rights = true
    group by account_id
)
select l.id AS sf_account_id
    ,l.name AS name
    ,l.type AS type
    ,l.first_msa_start_date AS first_msa_start_date
    ,l.first_product_rider_start_date AS first_product_rider_start_date
    ,sfa.initial_go_live_date AS initial_go_live_date
    --,dr.data_rights_aquired_date AS data_rights_aquired_date
    ,l.last_msa_end_date as last_msa_end_date
    ,l.last_product_rider_end_date AS last_product_rider_end_date 
from list l JOIN sf_accts sfa on l.id = sfa.id
            left join msa_data_rights dr on l.id = dr.account_id