
    
    

select
    accountteammember_id as unique_field,
    count(*) as n_records

from AV_EDM.AV_STAGING.dim_sf_customer_account_team
where accountteammember_id is not null
group by accountteammember_id
having count(*) > 1


