
  create or replace   view AV_EDM.AV_SOURCE.src_confluence_page_versions
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.CONFLUENCE_CUSTOM.VERSIONS
  );

