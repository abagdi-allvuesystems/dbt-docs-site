
  create or replace   view AV_EDM.AV_SOURCE.ab_confluence_comments
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.CONFLUENCE_CUSTOM.CONFLUENCE_COMMENTS
  );

