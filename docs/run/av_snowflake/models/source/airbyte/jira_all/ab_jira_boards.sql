
  create or replace   view AV_EDM.AV_SOURCE.ab_jira_boards
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.JIRA_ALL.BOARDS
  );

