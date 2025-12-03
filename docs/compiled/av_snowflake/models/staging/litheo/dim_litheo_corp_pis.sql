WITH lit_corp_pis as (
    select * from AV_EDM.AV_SYSTEM.litheo_ea_corporate_program_increments
)
select id
        ,name
        ,pistate as pi_state
        ,startdate as start_date
        ,enddate as end_date
        ,jirapiname as jira_pi_name
        ,epicreadinessdate as epic_readiness_date
        ,pireadinessdate as pi_readiness_date
        ,adddate as sys_created
        ,updatedate as sys_updated
        ,raw_updated
from lit_corp_pis