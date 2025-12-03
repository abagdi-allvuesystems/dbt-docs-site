
  
    

create or replace transient table AV_EDM.AV_SYSTEM.jira_issues
    
    
    
    as (
WITH jira_project_issue AS (
    SELECT * FROM AV_EDM.AV_SOURCE.jira_project_issues_raw
), jira_project_issue_rn AS (
    SELECT _airbyte_raw_id
        ,_airbyte_extracted_at
        ,id
        ,fields:parent.fields:issuetype.id::INT AS parent_type_id
        ,fields:parent.fields:issuetype.name::VARCHAR AS parent_type_name
        ,fields:parent.id::INT AS parent_issue_id
        ,fields:parent.key::VARCHAR AS parent_issue_key
        ,updated
        ,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated desc) as rn
    FROM jira_project_issue
)

SELECT 
        iss.id::INT as id
        ,iss.key
        ,iss.fields:issuetype.id::INT AS type_id
        ,iss.fields:issuetype.name::VARCHAR AS type_name
        ,iss.fields
        ,rn.parent_type_id
        ,rn.parent_type_name
        ,rn.parent_issue_id
        ,rn.parent_issue_key
        ,iss.renderedfields AS rendered_fields
        ,iss.changelog
        ,iss.projectid::INT AS project_id
        ,iss.projectkey AS project_key
        ,iss.created::TIMESTAMP_TZ AS sys_created
        ,iss.updated::TIMESTAMP_TZ AS sys_updated
        ,iss._airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM
        jira_project_issue iss JOIN jira_project_issue_rn rn ON iss._airbyte_raw_id = rn._airbyte_raw_id AND iss.id = rn.id AND rn.rn = 1
    )
;


  