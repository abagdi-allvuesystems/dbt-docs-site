WITH oa_proj AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project WHERE deleted = FALSE 
),dimh_proj AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project where is_current = true
), first_last_time_entry AS (
    select p.id
        ,min(time_entry_date) as first_time_entry
        ,max(time_entry_date) as last_time_entry
    from oa_proj p JOIN AV_EDM.AV_STAGING.dim_openair_time_entries t on p.id = t.project_id
    group by p.id
),oa_project_stage AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_stage
), oa_cust AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_customer
), oa_user as (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_user
), oa_original_budget as (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_budget where is_initial = true
), oa_project_owner AS (
    SELECT op.id   
            ,op.user_id
            ,ou.name
    FROM oa_proj op LEFT JOIN oa_user ou ON op.user_id = ou.id 
), oa_project_lead AS (
    SELECT op.id   
            ,op.custom_245 AS delivery_lead_id
            ,ou.name
    FROM oa_proj op LEFT JOIN oa_user ou ON op.custom_245 = ou.id 
), oa_cust_dlvy_leads AS (
    SELECT  c.id, 
            u.name 
    FROM oa_cust c LEFT JOIN oa_user u ON c.custom_199 = u.id
), oa_ranked_eac AS (
    SELECT id,
           effective_date_start,
           eac_hours,
           ROW_NUMBER() OVER (
               PARTITION BY id
               ORDER BY effective_date_start
           ) AS row_num
    FROM AV_EDM.AV_STAGING.dimh_openair_project
    WHERE eac_hours IS NOT NULL AND eac_hours != 0 
), oa_original_eac AS (
    SELECT * FROM oa_ranked_eac
    WHERE row_num = 1 
)
select p.id AS id
    ,p.name AS name
    ,p.project_stage_id AS project_stage_id
    ,pst.name AS project_stage_name
    ,p.custom_309 AS segment
    ,p.reporting_vertical AS reporting_vertical
    ,p.backlog_project AS backlog_project
    ,p.backlog_status AS backlog_status
    ,p.backlog_rag AS backlog_rag
    ,p.backlog_commentary AS backlog_commentary
    ,CASE WHEN p.custom_309 = 'Equity' THEN 'Equity'
        WHEN p.custom_309 IS NULL THEN NULL
        ELSE 'Credit' 
        END AS backlog_segment
    ,p.custom_151 AS project_type
    ,CASE WHEN p.custom_151 in ('Mariana','Accelerate','Cloud Upgrades','PaaS','Partner Engagement') THEN 'Other'
        WHEN p.custom_151 in ('Modernization','On-Prem Upgrades') THEN 'Implementation'
        WHEN p.custom_151 in ('Internal','Support','Servicing','Templates','Scoping - Consulting','Scoping - Implementation') THEN 'na'
        WHEN p.custom_151 IS NULL THEN 'na'
        ELSE p.custom_151
        END AS backlog_trend_group
    ,CASE WHEN dp.is_rev_drain_current = true THEN 'Bleeder Project'
        WHEN p.custom_151 in ('Implementation','Modernization','On-Prem Upgrades') THEN 'Implementation'
        WHEN p.custom_151 in ('Consulting') THEN 'Consulting'
        WHEN p.custom_151 in ('Mariana','Accelerate','Cloud Upgrades','PaaS','Partner Engagement','Consulting - Annual', 'Consulting - Portal') THEN 'Non-Forecast Demand'
        WHEN p.custom_151 in ('Internal','Support','Servicing','Templates','Scoping - Consulting','Scoping - Implementation') THEN 'na'
        WHEN p.custom_151 IS NULL THEN 'na'
        ELSE p.custom_151
        END AS backlog_burndown_group
    ,p.customer_id AS customer_id
    ,c.custom_7 AS customer_sf_id
    ,c.name AS customer_name
    ,c.custom_199 AS customer_delivery_lead_id
    ,dl.name AS customer_delivery_lead
    ,ou_po.user_id AS project_owner_id
    ,ou_po.name AS project_owner_name
    ,ou_dl.delivery_lead_id AS delivery_lead_id
    ,ou_dl.name AS delivery_lead_name
    ,p.active AS is_active
    ,p.custom_365 AS in_active_implementation
    ,p.deleted AS is_deleted
    ,p.custom_191 AS is_fixed_bid
    ,p.custom_194 AS rag_financial
    ,p.custom_195 AS project_health_commentary
    ,p.custom_197 AS rag_timeline
    ,RAG_CUSTOMER_EXPERIENCE AS rag_customer_experience
    ,p.custom_200 AS rag_overall
    ,ob.total AS original_budget
    ,ob.currency AS currency
    ,p.budget AS current_budget
    ,ob.hours AS original_budget_hours
    ,p.budget_time AS current_budget_hours
    ,oe.eac_hours AS original_eac_hours
    ,p.custom_236 AS current_eac_hours
    ,p.custom_318 AS approved_hours
    ,p.custom_329 AS is_rev_drain_current
    ,p.custom_189 AS is_on_invoicing_hold
    ,p.custom_183 AS special_billing_situation
    ,p.start_date AS start_date
    ,dd.first_time_entry AS first_time_entry
    ,p.finish_date AS finish_date
    ,p.custom_90 AS planned_go_live
    ,p.custom_91 AS revised_go_live
    ,p.custom_172 AS planned_project_completion_date
    ,p.custom_327 AS close_completed_date
    ,p.created AS sys_created
    ,p.updated AS sys_updated  
    ,p.notes AS notes  
from oa_proj p LEFT JOIN dimh_proj dp ON dp.id = p.id
                  LEFT JOIN oa_project_stage pst ON p.project_stage_id = pst.id
                  LEFT JOIN oa_cust c ON p.customer_id = c.id
                  LEFT JOIN oa_cust_dlvy_leads dl ON p.customer_id = dl.id
                  LEFT JOIN oa_project_owner ou_po ON ou_po.id = p.id
                  LEFT JOIN oa_project_lead ou_dl ON ou_dl.id = p.id
                  LEFT JOIN oa_original_budget ob ON p.id = ob.project_id
                  LEFT JOIN oa_original_eac oe ON p.id = oe.id
                  LEFT JOIN first_last_time_entry dd ON dd.id = p.id