
  create or replace   view AV_EDM.AV_SYSTEM.litheo_jira_sprint_items
  
  
  
  
  as (
    WITH ab_lit_sprint_items AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_sprint_items
)

SELECT 

        sprintid::INT AS sprintid
       ,sprintitmcompstatus::VARCHAR AS sprintitmcompstatus
       ,issueid::INT AS issueid
       ,issuekey::VARCHAR AS issuekey
       ,issuetypename::VARCHAR AS issuetypename
       ,issuesummary::VARCHAR AS issuesummary
       ,issuepriority::VARCHAR AS issuepriority
       ,issuestorypoints_current::VARCHAR AS issuestorypoints_current
       ,issuestorypoints_initial::VARCHAR AS issuestorypoints_initial
       ,parentissueid::INT AS parentissueid
       ,parentissuekey::VARCHAR AS parentissuekey
       ,parentissuetypename::VARCHAR AS parentissuetypename
       ,parentissuesummary::VARCHAR AS parentissuesummary
       ,issuekeyaddedduringsprint::BOOLEAN AS issuekeyaddedduringsprint
       ,updatedate::TIMESTAMP_TZ AS updatedate
       ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_sprint_items
  );

