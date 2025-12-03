
WITH acp_tickets AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issues
    where issue_type_id in (10119,10120,10121,10100) AND project_key = 'ACP' and is_deleted_from_jira = false
), des_flat AS (
    SELECT
    id as issue_id,
        LISTAGG(text_content.value:text::VARCHAR, '\n') as text
    FROM acp_tickets,
        LATERAL FLATTEN(input => fields:description:content) AS paragraph,
        LATERAL FLATTEN(input => paragraph.value:content) AS text_content,
    WHERE
        text_content.value:type::string = 'text'
    group by id
), ac_flat AS (
    SELECT
    id as issue_id,
        LISTAGG(text_content.value:text::VARCHAR, '\n') as text
    FROM  acp_tickets,
        LATERAL FLATTEN(input => fields:customfield_10171:content) AS paragraph,
        LATERAL FLATTEN(input => paragraph.value:content) AS text_content,
    WHERE
        text_content.value:type::string = 'text'
    group by id
), consultation_timing AS (
    SELECT issue_id
        ,status_id
        ,status_name
        ,effective_date_start
        ,effective_date_end
        ,ROW_NUMBER() OVER (PARTITION BY issue_id ORDER BY effective_date_start asc) as row_number
    FROM AV_EDM.AV_STAGING.dim_jira_jsm_issues_status
    WHERE STATUS_NAME = 'Consultation'
)
SELECT acp_t.id AS issue_id
        ,acp_t.key AS issue_key
        ,acp_t.issue_type_id AS issue_type_id
        ,acp_t.issue_type_name AS issue_type_name
        ,acp_t.request_type_id AS request_type_id
        ,acp_t.request_type_name AS request_type_name
        ,acp_t.fields:summary::VARCHAR AS summary
        ,acp_t.fields:reporter AS reporter
        ,acp_t.fields:reporter:accountId::VARCHAR AS reporter_user_account_id
        ,acp_t.fields:reporter:displayName::VARCHAR AS reporter_user_display_name
        ,acp_t.fields:assignee AS assignee
        ,acp_t.fields:assignee:accountId::VARCHAR AS assignee_user_account_id
        ,acp_t.fields:assignee:displayName::VARCHAR AS assignee_user_display_name
        ,acp_t.fields:customfield_10169:id::INT AS assignment_group_option_id
        ,acp_t.fields:customfield_10169:value::VARCHAR AS assignment_group_name
        ,acp_t.fields:customfield_10503:name::VARCHAR AS sentiment
        ,acp_t.fields:status:id::INT AS status_id
        ,acp_t.fields:status:name::VARCHAR AS status_name
        ,acp_t.fields:priority:name::VARCHAR AS priority_name
        ,acp_t.fields:customfield_10258[0]:value::BOOLEAN AS system_generated_ticket
        ,acp_t.fields:customfield_10253:value::VARCHAR AS product_base_area
        ,acp_t.fields:customfield_10244:value::VARCHAR AS product_area
        ,acp_t.fields:customfield_10244:child:value::varchar AS product_sub_area
        ,acp_t.fields:customfield_10243:value::VARCHAR AS ticket_type
        ,acp_t.fields:customfield_10237:id::INT AS consultation_assignment_group_option_id
        ,acp_t.fields:customfield_10237:value::VARCHAR AS consultation_assignment_group_name
        ,acp_t.fields:customfield_10044 AS pending_reason
        ,acp_t.fields:customfield_10116 AS customers
        ,acp_t.fields:customfield_10640:value::varchar AS is_upgrade_related
        ,acp_t.fields:customfield_11866::INT AS cqr_cause_code_accuracy
        ,acp_t.fields:customfield_11862::INT AS cqr_product_accuracy
        ,acp_t.fields:customfield_11864::INT AS cqr_resolution_quality
        ,acp_t.fields:customfield_11868::INT AS cqr_score
        ,acp_t.fields:customfield_11867::INT AS cqr_ticket_type_accuracy
        ,acp_t.fields:customfield_11863::INT AS cqr_time_accuracy
        ,acp_t.fields:customfield_10245:value::VARCHAR AS escalation_field
        ,acp_t.escalation_date AS escalation_date
        ,REGEXP_REPLACE(acp_t.fields:customfield_10178:value,'\u200B', '')::varchar AS cause
        ,REGEXP_REPLACE(acp_t.fields:customfield_10178:child:value,'\u200B', '')::varchar AS resolution
        ,acp_t.fields:customfield_10059 AS time_to_resolution
        ,ROUND(acp_t.fields:customfield_10059:completedCycles[0]:elapsedTime:millis::INT / (1000 * 60 * 60 * 24), 2) AS time_to_resolution_elapsed_days
        ,ROUND(acp_t.fields:customfield_10059:completedCycles[0]:goalDuration:millis::INT / (1000 * 60 * 60 * 24), 2) AS time_to_resolution_goal_days
        ,IFNULL(COALESCE(
            TRY_CAST(acp_t.fields:customfield_10025::VARCHAR AS VARCHAR)
            ,'0_*:*_0_*:*_0'
        ),'0_*:*_0_*:*_0') AS time_in_status
        ,acp_t.sys_created AS sys_created
        ,acp_t.sys_updated AS sys_updated
        ,concat(substring(acp_t.fields:resolutiondate,0,len(acp_t.fields:resolutiondate)-2),':',substring(acp_t.fields:resolutiondate,len(acp_t.fields:resolutiondate)-1,len(acp_t.fields:resolutiondate)))::TIMESTAMP_TZ as resolution_date
        ,concat(substring(acp_t.fields:customfield_10227,0,len(acp_t.fields:customfield_10227)-2),':',substring(acp_t.fields:customfield_10227,len(acp_t.fields:customfield_10227)-1,len(acp_t.fields:customfield_10227)))::TIMESTAMP_TZ as restored
        ,cons.effective_date_start as initial_consultation
        ,acp_t.fields:labels AS labels
        ,acp_t.fields:issuelinks AS issue_links
        ,acp_t.fields:customfield_10226 AS caused_by_change
        ,acp_t.fields:description AS description_raw
        ,des_flat.text AS description
        ,acp_t.fields:customfield_10171 AS additional_comments_raw
        ,ac_flat.text AS additional_comments
        ,acp_t.fields:worklog AS worklog
FROM acp_tickets acp_t LEFT JOIN des_flat ON acp_t.id = des_flat.issue_id
                       LEFT JOIN ac_flat ON acp_t.id = ac_flat.issue_id
                       LEFT JOIN consultation_timing cons ON acp_t.id = cons.issue_id AND cons.row_number = 1