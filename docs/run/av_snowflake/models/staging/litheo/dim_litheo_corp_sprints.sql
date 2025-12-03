
  create or replace   view AV_EDM.AV_STAGING.dim_litheo_corp_sprints
  
  
  
  
  as (
    WITH lit_corp_sprints AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.litheo_ea_corporate_sprints
)
SELECT 
        id
        ,name
        ,sprintstate AS sprint_state
        ,corporatepiid AS corp_pi_id
        ,sprintstartbegin AS sprint_start_begin
        ,sprintstartend AS sprint_start_end
        ,adddate AS sys_created
        ,updatedate as sys_updated
        ,row_number() OVER (PARTITION BY corporatepiid order by sprintStartBegin ) pi_sprint_num
        ,raw_updated
FROM lit_corp_sprints
  );

