
  create or replace   view AV_EDM.AV_STAGING.solution_project_id_mapping
  
  
  
  
  as (
    WITH jira_project AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_projects
)

SELECT
        HASH(p.id)::INT AS id
        ,p.id AS jira_project_id

FROM
        jira_project p
  );

