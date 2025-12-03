
WITH jsm_acp_issues_recent AS (
    SELECT
        id::INT AS id
        ,key
        ,fields:issuetype.id::INT AS issue_type_id
        ,fields:issuetype.name::VARCHAR AS issue_type_name
        ,fields:customfield_10010:requestType:id::INT AS request_type_id
        ,fields:customfield_10010:requestType:name::VARCHAR AS request_type_name
        ,TRY_CAST(
            REGEXP_REPLACE(fields:customfield_10350::STRING, '([+-]\\d{2})(\\d{2})$', '\\1:\\2') AS TIMESTAMP_TZ
         ) AS escalation_date
        ,fields
        ,renderedfields AS rendered_fields
        ,changelog
        ,projectid::INT AS project_id
        ,projectkey AS project_key
        ,created::TIMESTAMP_TZ AS sys_created
        ,updated::TIMESTAMP_TZ AS sys_updated
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

    
    FROM AV_EDM.AV_SOURCE.ab_jsm_acp_issues
    WHERE projectid::INT = 10156
), jsm_acp_issues_2023 AS (
    SELECT
        id::INT as id
        ,key
        ,fields:issuetype.id::INT AS issue_type_id
        ,fields:issuetype.name::VARCHAR AS issue_type_name
        ,fields:customfield_10010:requestType:id::INT AS request_type_id
        ,fields:customfield_10010:requestType:name::VARCHAR AS request_type_name
        ,TRY_CAST(
            REGEXP_REPLACE(fields:customfield_10350::STRING, '([+-]\\d{2})(\\d{2})$', '\\1:\\2') AS TIMESTAMP_TZ
         ) AS escalation_date
        ,fields
        ,renderedfields AS rendered_fields
        ,changelog
        ,fields:project:id::INT AS project_id
        ,fields:project:key AS project_key
        ,concat(substring(fields:created,0,len(fields:created)-2),':',substring(fields:created,len(fields:created)-1,len(fields:created)))::TIMESTAMP_TZ
         AS sys_created
        ,concat(substring(fields:updated,0,len(fields:updated)-2),':',substring(fields:updated,len(fields:updated)-1,len(fields:updated)))::TIMESTAMP_TZ
         AS sys_updated
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated

    FROM AV_EDM.AV_SOURCE.ab_jsm_acp_issues_2023
), iap AS (
       SELECT
        id::INT AS id
        ,key
        ,fields:issuetype.id::INT AS issue_type_id
        ,fields:issuetype.name::VARCHAR AS issue_type_name
        ,fields:customfield_10010:requestType:id::INT AS request_type_id
        ,fields:customfield_10010:requestType:name::VARCHAR AS request_type_name
        ,TRY_CAST(
            REGEXP_REPLACE(fields:customfield_10350::STRING, '([+-]\\d{2})(\\d{2})$', '\\1:\\2') AS TIMESTAMP_TZ
         ) AS escalation_date
        ,fields
        ,renderedfields AS rendered_fields
        ,changelog
        ,projectid::INT AS project_id
        ,projectkey AS project_key
        ,created::TIMESTAMP_TZ AS sys_created
        ,updated::TIMESTAMP_TZ AS sys_updated
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
        FROM AV_EDM.AV_SOURCE.ab_jsm_iap_issues
), eim AS (
       SELECT
        id::INT AS id
        ,key
        ,fields:issuetype.id::INT AS issue_type_id
        ,fields:issuetype.name::VARCHAR AS issue_type_name
        ,fields:customfield_10010:requestType:id::INT AS request_type_id
        ,fields:customfield_10010:requestType:name::VARCHAR AS request_type_name
        ,TRY_CAST(
            REGEXP_REPLACE(fields:customfield_10350::STRING, '([+-]\\d{2})(\\d{2})$', '\\1:\\2') AS TIMESTAMP_TZ
         ) AS escalation_date
        ,fields
        ,renderedfields AS rendered_fields
        ,changelog
        ,projectid::INT AS project_id
        ,projectkey AS project_key
        ,created::TIMESTAMP_TZ AS sys_created
        ,updated::TIMESTAMP_TZ AS sys_updated
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
        FROM AV_EDM.AV_SOURCE.ab_jsm_eim_issues
), jsm_issues_all AS (
    SELECT * FROM jsm_acp_issues_recent
        UNION
    SELECT * FROM jsm_acp_issues_2023
        UNION
    SELECT * FROM iap
        UNION
    SELECT * FROM eim
), deleted_issues AS (
    SELECT * FROM AV_EDM.AV_SOURCE.deleted_jira_issues
), jsm_issues_with_row_num AS (
    SELECT
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY sys_updated DESC) AS row_num
        ,id
        ,key
        ,issue_type_id
        ,issue_type_name
        ,request_type_id
        ,request_type_name
        ,escalation_date
        ,fields
        ,rendered_fields
        ,changelog
        ,project_id
        ,project_key
        ,sys_created
        ,sys_updated
        ,raw_updated
        ,CASE WHEN deleted_issues.issue_id IS NOT NULL THEN true else false END as is_deleted_from_jira
    FROM jsm_issues_all LEFT JOIN deleted_issues on jsm_issues_all.id = deleted_issues.issue_id
)
SELECT 
        id
        ,key
        ,issue_type_id
        ,issue_type_name
        ,request_type_id
        ,request_type_name
        ,escalation_date
        ,fields
        ,rendered_fields
        ,changelog
        ,project_id
        ,project_key
        ,sys_created
        ,sys_updated
        ,raw_updated
        ,is_deleted_from_jira
FROM 
        jsm_issues_with_row_num

WHERE 
        row_num = 1