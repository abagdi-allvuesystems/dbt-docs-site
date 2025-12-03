
  create or replace   view AV_EDM.AV_STAGING.dim_copilot_usage
  
  
  
  
  as (
    WITH copilot_usage as (
    select * from AV_EDM.AV_SYSTEM.copilot_usage
)
select day
    ,total_active_users
    ,total_lines_accepted
    ,total_lines_suggested
    ,total_acceptances_count
    ,total_suggestions_count
    ,raw_updated
from copilot_usage
  );

