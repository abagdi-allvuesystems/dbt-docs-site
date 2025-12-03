WITH dim_oa_proj AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project
), dim_customer AS (
    SELECT * FROM AV_EDM.AV_SALES.dim_customer
), oa_customer AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_customer 
)

select dp.id as id
    ,'openair' as source_system
    ,dp.name as name
    ,dp.project_stage_name as project_stage_name
    ,dp.segment as segment
    ,dp.reporting_vertical AS reporting_vertical
    ,dp.backlog_project AS backlog_project
    ,dp.backlog_status AS backlog_status
    ,dp.backlog_rag AS backlog_rag
    ,dp.backlog_commentary AS backlog_commentary
    ,dp.rag_customer_experience AS rag_customer_experience
    ,dp.rag_financial AS rag_financial
    ,dp.rag_timeline AS rag_timeline
    ,dp.rag_overall AS rag_overall
    ,dp.project_health_commentary AS project_health_commentary
    ,dc.customer_id as av_customer_id 
    ,oc.id as oa_customer_id
    ,oc.name as customer_name
    ,dp.customer_sf_id as customer_sf_id
    ,dp.customer_delivery_lead as customer_delivery_lead
    ,dp.project_type as project_type
    ,dp.project_owner_name as project_owner_name
    ,dp.delivery_lead_name as delivery_lead_name
    ,dp.is_active as is_active
    ,dp.in_active_implementation as in_active_implementation
    ,dp.is_deleted as is_deleted
    ,dp.is_fixed_bid as is_fixed_bid
    ,dp.original_budget AS original_budget
    ,dp.currency AS currency
    ,dp.original_budget_hours AS original_budget_hours
    ,dp.original_eac_hours AS original_eac_hours
    ,dp.is_rev_drain_current as is_rev_drain_current
    ,dp.is_on_invoicing_hold as is_on_invoicing_hold
    --,dp.invoicing_hold_notes AS invoicing_hold_notes
    ,dp.start_date AS scheduled_start_date
    ,dp.planned_go_live AS planned_go_live
    ,dp.revised_go_live AS revised_go_live
    --,dp.planned_uat AS planned_uat
    ,dp.sys_created AS created
    ,dp.sys_updated AS updated
    ,dp.first_time_entry AS first_time_entry
    ,dp.close_completed_date AS close_completed_date
    ,dp.planned_project_completion_date AS planned_project_completion_date
    ,dp.notes AS notes
FROM dim_oa_proj dp LEFT JOIN dim_customer dc ON dp.customer_id = dc.oa_customer_id 
                    LEFT JOIN oa_customer oc ON dp.customer_id = oc.id