
  create or replace   view AV_EDM.AV_SOURCE.src_ab_sf_collaborationrequest
  
  
  
  
  as (
    SELECT * FROM LANDING_AIRBYTE.SALESFORCE.QS_COLLABORATION_REQUEST__C
  );

