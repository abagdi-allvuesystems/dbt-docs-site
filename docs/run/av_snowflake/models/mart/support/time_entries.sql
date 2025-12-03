
  
    

create or replace transient table AV_EDM.AV_SUPPORT.time_entries
    
    
    
    as (WITH time_entries AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_time_entries where status_name != 'rejected' and deleted != true
) 

SELECT  * FROM time_entries
    )
;


  