WITH ab_copilot_usage as (
    select * from AV_EDM.AV_SOURCE.ab_copilot_usage
)
select day::DATE as day
    ,total_active_users::INT as total_active_users
    ,total_lines_accepted::INT as total_lines_accepted
    ,total_lines_suggested::INT as total_lines_suggested
    ,total_acceptances_count::INT as total_acceptances_count
    ,total_suggestions_count::INT as total_suggestions_count
    ,breakdown
    ,_airbyte_extracted_at::TIMESTAMP_TZ as raw_updated
from ab_copilot_usage