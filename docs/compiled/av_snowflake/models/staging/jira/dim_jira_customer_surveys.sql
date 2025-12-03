WITH surveys AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_jsm_issues_surveys
), description_md AS (
    SELECT
        id as issue_id,
        LISTAGG(text_content.value:text::VARCHAR, '\n') as text
    FROM  surveys,
        LATERAL FLATTEN(input => fields:description:content) AS paragraph,
        LATERAL FLATTEN(input => paragraph.value:content) AS text_content,
        --LATERAL (SELECT seq FROM TABLE(GENERATOR(ROWCOUNT => 1))) AS seq
    WHERE
        text_content.value:type::string = 'text'
    group by id
)
select id as id
    ,key as key
    ,fields:summary::VARCHAR as summary
    ,fields:status:id::INT as status_id
    ,fields:status:name::VARCHAR as status_name
    ,fields:description::VARCHAR as description
    ,dmd.text as description_md
    ,fields:components AS components
    ,fields:issuelinks[0]:inwardIssue:id::INT as issue_links_id
    ,fields:issuelinks[0]:inwardIssue:key::VARCHAR as issue_links_key
    ,fields:issuelinks[0]:type:name::VARCHAR as issue_links_type_name
    ,fields:customfield_10377:accountId::VARCHAR as csat_recipient_account_ids
    ,fields:customfield_10377:displayName::VARCHAR as csat_recipient_display_name
    ,fields:customfield_10377:emailAddress::VARCHAR as csat_recipient_email_address
    ,fields:customfield_10375:value::VARCHAR as customer_survey_rating
    ,fields:customfield_10379::INT as customer_survey_rating_value
    ,fields:customfield_10641:value::VARCHAR as dissatisfaction_reason
    ,concat(substring(fields:resolutiondate,0,len(fields:resolutiondate)-2),':',substring(fields:resolutiondate,len(fields:resolutiondate)-1,len(fields:resolutiondate)))::TIMESTAMP_TZ as resolution_date
    ,sys_created as sys_created
    ,sys_updated as sys_updated
    
from surveys s LEFT JOIN description_md dmd on s.id = dmd.issue_id