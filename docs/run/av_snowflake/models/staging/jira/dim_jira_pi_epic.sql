
  create or replace   view AV_EDM.AV_STAGING.dim_jira_pi_epic
  
  
  
  
  as (
    

WITH field_option AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_issue_custom_field_option
), jira_epic_flat AS (
    SELECT
        issue_id
        ,effective_date_start
        ,effective_date_end
        ,pi.value::INT AS pi_id
    FROM AV_EDM.AV_STAGING.dim_jira_epic_pi e_pi
    ,LATERAL FLATTEN(INPUT => SPLIT(e_pi.pi_ids,','),OUTER=>TRUE) pi
)
    SELECT
        issue_id
        ,o.value AS pi_name
        ,effective_date_start
        ,effective_date_end
        
    FROM jira_epic_flat e
    JOIN field_option o ON e.pi_id = o.id
  );

