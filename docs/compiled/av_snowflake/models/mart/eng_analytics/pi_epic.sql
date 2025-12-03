

WITH pi_epic_detail AS (
    SELECT * FROM AV_EDM.AV_STAGING.ea_pi_epic_detail
)

SELECT 
        corp_pi_id
        ,epic_id
        ,MAX(in_scope_jira_attribute_at_epic_readiness_start) AS in_scope_jira_attribute_at_epic_readiness_start
        ,MAX(in_scope_jira_attribute_at_pi_readiness_start) AS in_scope_jira_attribute_at_pi_readiness_start
        ,MAX(in_scope_jira_attribute_between_pi_start_end) AS in_scope_jira_attribute_between_pi_start_end
        ,MAX(in_scope_aha_attribute) AS in_scope_aha_attribute
        ,MAX(in_scope_planned_workitems) AS in_scope_planned_workitems
FROM 
        pi_epic_detail
GROUP BY
        corp_pi_id,epic_id
ORDER BY 
        epic_id,corp_pi_id