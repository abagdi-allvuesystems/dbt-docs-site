WITH ab_lit_sprint_metrics AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_sprint_metrics
)

SELECT 

        sprintid::INT AS sprintid
        ,velocity::FLOAT AS velocity
        ,pointsplanned::FLOAT AS pointsplanned
        ,churn_totalpoints::FLOAT AS churn_totalpoints
        ,churn::FLOAT AS churn
        ,performancetocommit::FLOAT AS performancetocommit
        ,sprintsuccess::BOOLEAN AS sprintsuccess
        ,completedpointsplanned::FLOAT AS completedpointsplanned
        ,sprintscopecompletionrate::FLOAT AS sprintscopecompletionrate
        ,corporatesprintid::INT AS corporatesprintid
        ,teamcommentary::VARCHAR AS teamcommentary
        ,adddate::TIMESTAMP_TZ AS adddate
        ,updatedate::TIMESTAMP_TZ AS updatedate
        ,adduser::VARCHAR AS adduser
        ,updateuser::VARCHAR AS updateuser
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM ab_lit_sprint_metrics