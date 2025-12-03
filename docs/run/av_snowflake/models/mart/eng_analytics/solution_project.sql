
  
    

create or replace transient table AV_EDM.AV_ENG_ANALYTICS.solution_project
    
    
    
    as (WITH jira_project AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_projects
), solution_project_mapping AS (
    SELECT * FROM AV_EDM.AV_STAGING.solution_project_id_mapping
)

SELECT
        spm.id AS id
        ,p.name
        ,p.id AS jira_project_id
        ,key AS jira_project_key
        ,CASE WHEN key IN ('ACC','BI/ETL','CRM','ECE','FPPM','FOSHO','PARTY','LPPM','PLAT','SPP','SNOW') THEN true ELSE false END AS is_roadmap
        ,CASE WHEN key IN ('ARCH','ECE','DBA','CICD','EIM','ISEC','NEO','QA','TSE') THEN true ELSE false END AS is_shared_service
        ,CASE WHEN key IN ('FOD','LPPMD') THEN true ELSE false END AS is_delivery
        ,raw_updated

FROM
        solution_project_mapping spm
LEFT JOIN
        jira_project p ON spm.jira_project_id = p.id
    )
;


  