
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.employees
    
    
    
    as (WITH adp_emp AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_adp_employees
), row_num AS (
    select ROW_NUMBER() OVER (PARTITION BY email_address ORDER BY litheo_update_date desc) AS row_number_desc
        ,associate_oid
    from adp_emp
), adp_emp_dedup AS (
    SELECT adp_emp.*
    FROM adp_emp JOIN row_num on adp_emp.associate_oid = row_num.associate_oid
    where row_num.row_number_desc = 1
), dim_jira_users AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_users
)
select adp.associate_oid
    ,adp.worker_id
    ,adp.first_name
    ,adp.last_name
    ,adp.email_address
    ,adp.hire_date
    ,adp.termination_date
    ,adp.status
    ,adp.location
    ,adp.worker_type
    ,adp.job_code
    ,adp.job_title
    ,adp.department
    ,adp.functional_team
    ,adp.supervisor_id
    ,adp.supervisor_oid
    ,jira.account_id as jira_account_id
    ,jira.active as jira_account_is_active
from adp_emp_dedup adp LEFT JOIN dim_jira_users jira ON adp.email_address = jira.emailaddress
    )
;


  