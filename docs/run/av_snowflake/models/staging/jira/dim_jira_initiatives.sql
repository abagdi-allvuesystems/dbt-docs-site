
  create or replace   view AV_EDM.AV_STAGING.dim_jira_initiatives
  
  
  
  
  as (
    WITH jira_issues AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.jira_issues WHERE type_name IN ('Initiative')
)

SELECT 
        ji.id::INT AS issue_id
        ,ji.key AS issue_key
        ,ji.type_name AS issue_type_name
        ,ji.type_id AS issue_type_id
        ,ji.fields:status.name::VARCHAR AS issue_status_name
        ,ji.fields:status.id::INT AS issue_status_id
        ,ji.fields:status.statusCategory.name::VARCHAR AS issue_status_category
        ,ji.project_id
        ,ji.project_key
        ,ji.fields:summary::VARCHAR AS issue_summary
        ,ji.fields:customfield_10431.value::VARCHAR AS issue_investment_layers
        ,ji.fields:customfield_10465 AS program_increment
        ,ji.fields:labels as labels
        ,ji.fields:reporter as reporter
        ,ji.fields:assignee as assignee
        ,ji.sys_created
        ,ji.sys_updated
        ,ji.raw_updated
        ,ji.fields:customfield_10610::DATE as start_target
        ,ji.fields:customfield_10613::DATE as end_target
        ,ji.fields:customfield_10585 as market_segment_raw
        ,ji.fields:customfield_10596 as associated_products_raw
        ,ji.fields:customfield_10597:value::VARCHAR as vertical
        ,ji.fields:customfield_10598:value::VARCHAR as roadmap_year
        ,ji.fields:customfield_10599:value::VARCHAR as roadmap_commitment
        ,ji.fields:customfield_10587:value::VARCHAR AS scope_complete
        ,ji.fields:customfield_10586 AS initial_estimate
        ,ji.fields:customfield_10588:value::VARCHAR AS arch_rev_complete_approved
        ,ji.fields:customfield_10591:value::VARCHAR AS infr_rev_complete_approved
        ,ji.fields:customfield_10590:value::VARCHAR AS ui_ux_rev_complete_approved
        ,ji.fields:customfield_10674:value::VARCHAR AS sec_rev_complete_approved
        ,ji.fields:customfield_10592:value::VARCHAR AS qa_rev_complete_approved
        ,ji.fields:customfield_10589:value::VARCHAR AS dev_rev_complete_approved
        ,ji.fields:customfield_10593:value::VARCHAR AS documentation_needed
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(
                fields:customfield_10709:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS scoping_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(
                fields:customfield_10710:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS architecture_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(
                fields:customfield_10711:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS ui_ux_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(
                fields:customfield_10712:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS infrastructure_documentation
        ,REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
                REPLACE(REPLACE(REPLACE(REPLACE(
                fields:customfield_10713:content,']',''),'[',''),'{',''),'}',''),'"content":',''),'"type":',''),'"paragraph"',''),'"doc",',''),'"version":1',''),'"attrs":','')
                ,'"inlineCard"',''),'"text":',''),'"text"',''),'"url":',''),'"href":',''),'"collection":"",',''),'"marks":',''),'"file"',''),'"mediaInline"',''),'"heading"','')
                ,'"level":2',''),'"listItem"',''),'"bulletList"',''),'"',''),',','') AS security_documentation

        
FROM 
        jira_issues ji
  );

