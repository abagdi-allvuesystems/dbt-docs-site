
  create or replace   view AV_EDM.AV_SOURCE.ab_jsm_acp_changelog
  
  
  
  
  as (
    select * from LANDING_AIRBYTE.JSM_ACP.ISSUE_CHANGELOGS
  );

