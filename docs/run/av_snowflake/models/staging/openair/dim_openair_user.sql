
  create or replace   view AV_EDM.AV_STAGING.dim_openair_user
  
  
  
  
  as (
    WITH sys_users AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_user
), sys_depts AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_department
)
select u.id AS id
    ,u.name AS name
    ,u.first_name AS first_name
    ,u.last_name AS last_name
    ,u.email AS email
    ,u.custom_138 AS netsuite_user_id
    ,u.external_id AS external_id
    ,u.custom_19 AS emp_status
    ,u.line_manager_id AS line_manager_id
    ,lm.name AS line_manager_name
    ,u.custom_188 AS is_manager
    ,u.department_id AS department_id
    ,d.name as department_name
    ,u.custom_206 AS user_delivery_org
    ,u.custom_205 AS user_delivery_team
    ,u.custom_231 AS ps_start_date
    ,u.custom_233 AS utilization_category
    ,u.ta_approver AS timesheet_approver_role
    ,u.active AS is_active
    ,u.created as sys_created
    ,u.updated as sys_updated
from sys_users u LEFT JOIN sys_users lm ON u.line_manager_id = lm.id
                 LEFT JOIN sys_depts d on u.department_id = d.id
  );

