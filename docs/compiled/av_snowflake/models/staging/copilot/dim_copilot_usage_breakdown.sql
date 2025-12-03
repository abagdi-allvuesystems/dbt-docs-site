WITH copilot_usage as (
    select * from AV_EDM.AV_SYSTEM.copilot_usage
)
select day
    ,usage.value:editor::VARCHAR as editor
    ,usage.value:language::VARCHAR as language
    ,usage.value:active_users::INT as active_users
    ,usage.value:acceptances_count::INT as acceptances_count
    ,usage.value:lines_accepted::INT as lines_accepted
    ,usage.value:lines_suggested::INT as lines_suggested
    ,usage.value:suggestions_count::INT as suggestions_count
    ,raw_updated
from copilot_usage
    ,LATERAL FLATTEN(breakdown) usage