
  create or replace   view AV_EDM.AV_SOURCE.src_ab_confluence_spaces
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.CONFLUENCE_CUSTOM.CONFLUENCE_SPACES
  );

