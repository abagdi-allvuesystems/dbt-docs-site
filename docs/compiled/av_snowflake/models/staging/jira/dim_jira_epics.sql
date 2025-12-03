WITH jira_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_issues WHERE type_name in ('Epic')

), jira_projects AS (
        SELECT * FROM AV_EDM.AV_STAGING.dim_jira_projects
)


SELECT 
        ji.id::INT AS issue_id
        ,ji.key AS issue_key
        ,ji.type_name AS issue_type_name
        ,ji.type_id AS issue_type_id
        ,ji.fields:status.name::VARCHAR AS issue_status_name
        ,ji.fields:status.id::INT AS issue_status_id
        ,ji.fields:status.statusCategory.name::VARCHAR AS issue_status_category
        ,ji.fields:parent.id::INT AS parent_issue_id
        ,ji.fields:parent.key::VARCHAR AS parent_issue_key
        ,ji.parent_type_name as parent_issue_type_name
        ,ji.project_id
        ,ji.project_key
        ,jp.name AS project_name
        ,ji.fields:summary::VARCHAR AS issue_summary
        ,ji.fields:customfield_10410.value::VARCHAR AS program_increment_old
        ,ji.fields:customfield_10431.value::VARCHAR AS issue_investment_layers
        ,ji.fields:customfield_10465 AS program_increment
        ,ji.fields:customfield_10596 as associated_products_raw
        ,ji.fields:labels as labels
        ,ji.fields:reporter as reporter
        ,ji.fields:assignee as assignee
        ,ji.fields:customfield_10333 AS story_points_to_do
        ,ji.fields:customfield_10334 AS story_points_in_progress
        ,ji.fields:customfield_10335 AS story_points_done
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ji.fields:customfield_10709:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"level":4',''),'"level":3',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS scoping_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ji.fields:customfield_10710:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"level":4',''),'"level":3',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS architecture_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ji.fields:customfield_10711:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"level":4',''),'"level":3',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS ui_ux_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ji.fields:customfield_10712:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"level":4',''),'"level":3',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS infrastructure_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(ji.fields:customfield_10713:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"level":4',''),'"level":3',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS security_documentation
        ,ji.fields:customfield_10587:value::VARCHAR AS scope_complete
        ,ji.fields:customfield_10588:value::VARCHAR AS arch_rev_complete
        ,ji.fields:customfield_10591:value::VARCHAR AS infr_rev_complete
        ,ji.fields:customfield_10590:value::VARCHAR AS ui_ux_rev_complete
        ,ji.fields:customfield_10592:value::VARCHAR AS qa_rev_complete
        ,ji.fields:customfield_10589:value::VARCHAR AS dev_rev_complete
        ,ji.fields:customfield_10675:value::VARCHAR AS eng_scope_accepted
        ,ji.fields:customfield_10674:value::VARCHAR AS sec_rev_complete
        ,ji.fields:customfield_10028 AS story_points
        ,ji.fields:customfield_10001:name::VARCHAR AS team
        ,ji.sys_created
        ,ji.sys_updated
        ,ji.raw_updated

FROM 
        jira_issues ji LEFT JOIN jira_projects jp ON jp.id = ji.project_id