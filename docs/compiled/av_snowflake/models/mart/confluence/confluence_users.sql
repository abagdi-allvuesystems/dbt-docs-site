WITH distinct_users AS (
    SELECT distinct * FROM AV_EDM.AV_STAGING.stg_confluence_users
), dim_jira_users AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_users
), adp_emp AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_adp_employees
), row_num AS (
    select ROW_NUMBER() OVER (PARTITION BY email_address ORDER BY litheo_update_date desc) AS row_number_desc
        ,associate_oid
    from adp_emp
), adp_emp_dedup AS (
    SELECT adp_emp.*
    FROM adp_emp JOIN row_num on adp_emp.associate_oid = row_num.associate_oid
    where row_num.row_number_desc = 1
)
select  du.id as confluence_user_id
        ,du.title as confluence_title
        ,du.entity_type as confluence_entity_type
        ,du.account_id AS confluence_account_id
        ,du.display_name AS confluence_display_name
        ,du.email AS confluence_email_address
        ,du.time_zone AS confluence_time_zone
        ,du.user_type AS confluence_user_type
        ,du.public_name AS confluence_public_name
        ,du.account_type AS confluence_account_type
        ,du.is_external_collaborator AS confluence_is_external_collaborator
        ,du.last_modified_date as confluence_last_modified_date
        ,dju.account_id as jira_account_id
        ,dju.displayname as display_name
        ,dju.emailaddress as email_address
        ,adp_emp.associate_oid as adp_oid
        ,adp_emp.worker_id as adp_worker_id
        ,adp_emp.first_name as first_name
        ,adp_emp.last_name as last_name
        ,adp_emp.hire_date as hire_date
        ,adp_emp.termination_date as termination_date
        ,adp_emp.status as employment_status
        ,adp_emp.location as location
        ,adp_emp.worker_type as worker_type
        ,adp_emp.job_code as job_code
        ,adp_emp.job_title as job_title
        ,adp_emp.department as department
        ,adp_emp.functional_team as functional_team
        ,adp_emp.supervisor_oid as supervisor_oid
        ,adp_sup.first_name::VARCHAR || ' ' || adp_sup.last_name::VARCHAR as supervisor_display_name
        ,adp_sup.email_address as supervisor_email_address
from  distinct_users du LEFT JOIN dim_jira_users dju on dju.account_id = du.account_id
                            LEFT JOIN adp_emp_dedup adp_emp on dju.emailaddress = adp_emp.email_address
                            LEFT JOIN adp_emp_dedup adp_sup on adp_sup.associate_oid = adp_emp.supervisor_oid