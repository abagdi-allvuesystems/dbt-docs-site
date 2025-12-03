WITH adp_emp AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_adp_employees
), row_num AS (
    select ROW_NUMBER() OVER (PARTITION BY email_address ORDER BY litheo_update_date desc) AS row_number_desc
        ,associate_oid
    from adp_emp
), adp_emp_dedup AS (
    SELECT adp_emp.*
    FROM adp_emp JOIN row_num on adp_emp.associate_oid = row_num.associate_oid
    where row_num.row_number_desc = 1
), assets_employee AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_assets_users_internal
)
select MD5(adp.email_address) as id
    ,adp.associate_oid
    ,adp.worker_id
    ,adp.first_name
    ,adp.last_name
    ,CONCAT(adp.first_name,' ',adp.last_name) as display_name
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
    ,ae.country as country
    ,MD5(adp_sup.email_address) as supervisor_employee_id
    ,adp.supervisor_id as supervisor_worker_id
    ,adp.supervisor_oid as supervisor_oid
    ,CASE WHEN adp_sup.email_address is not null 
            THEN CONCAT(adp_sup.first_name,' ',adp_sup.last_name)
            ELSE NULL END as supervisor_display_name
from adp_emp_dedup adp LEFT JOIN adp_emp_dedup adp_sup on adp.supervisor_oid = adp_sup.associate_oid
                       LEFT JOIN assets_employee ae on adp.email_address = ae.email_address
where adp.email_address is not null