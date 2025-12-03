WITH jira_jsm_issues as (
    select * from AV_EDM.AV_SYSTEM.jira_jsm_issues
), jira_jsm_changelogs as (
    select * from AV_EDM.AV_SOURCE.ab_jsm_acp_changelog
)
select issueid as issue_id
        ,id as history_id
        ,created::TIMESTAMP_TZ as SYS_CREATED
        ,author:accountId::VARCHAR as ACCOUNT_ID
        ,author:displayName::VARCHAR as ACCOUNT_DISPLAY_NAME
        ,author:accountType::VARCHAR as ACCOUNT_TYPE
        ,items.value:field::VARCHAR as FIELD_NAME
        ,items.value:fieldId::VARCHAR as FIELD_ID
        ,items.value:fieldtype::VARCHAR as FIELD_TYPE
        ,items.value:from::VARCHAR as FROM_ID
        ,items.value:fromString::VARCHAR as FROM_STRING
        ,items.value:to::VARCHAR as TO_ID
        ,items.value:toString::VARCHAR as TO_STRING
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
from jira_jsm_changelogs,    /*
lateral flatten( INPUT => author.value) as author,*/
lateral flatten( INPUT => items) as items

/*
select id as issue_id
        ,hist.value:id::INT as history_id
        ,TO_TIMESTAMP_TZ(TRANSLATE(hist.value:created::VARCHAR,':',''),'YYYY-MM-DD"T"HH24MISS.FF TZHTZM') as SYS_CREATED
        ,hist.value:author:accountId::VARCHAR as ACCOUNT_ID
        ,hist.value:author:displayName::VARCHAR as ACCOUNT_DISPLAY_NAME
        ,hist.value:author:accountType::VARCHAR as ACCOUNT_TYPE
        ,items.value:field::VARCHAR as FIELD_NAME
        ,items.value:fieldId::VARCHAR as FIELD_ID
        ,items.value:fieldtype::VARCHAR as FIELD_TYPE
        ,items.value:from::VARCHAR as FROM_ID
        ,items.value:fromString::VARCHAR as FROM_STRING
        ,items.value:to::VARCHAR as TO_ID
        ,items.value:toString::VARCHAR as TO_STRING
        ,RAW_UPDATED
from jira_jsm_issues,
lateral flatten( INPUT => changelog:histories ) as hist,
lateral flatten( INPUT => hist.value:items ) as items
*/