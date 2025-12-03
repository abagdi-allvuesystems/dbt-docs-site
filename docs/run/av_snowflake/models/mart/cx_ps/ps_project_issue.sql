
  
    

create or replace transient table AV_EDM.AV_CX_PS.ps_project_issue
    
    
    
    as (WITH dim_oa_issue AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_issue where deleted != TRUE
), dim_customer AS (
    SELECT * FROM AV_EDM.AV_SALES.dim_customer
)

SELECT di.id as issue_id
    ,di.name AS issue_name
    ,di.entered_by_user AS entered_by_user
    ,di.description AS description
    ,dc.customer_id AS av_customer_id
    ,di.customer_id AS oa_customer_id
    ,dc.name AS customer_name
    ,di.project_id AS project_id
    ,di.project_name AS project_name
    ,di.issue_category as issue_category
    ,di.issue_status as issue_status
    ,di.issue_stage as issue_stage
    ,di.issue_source as issue_source
    ,di.issue_notes as issue_notes
    ,di.issue_date as issue_date
    ,di.date_resolved as date_resolved
    ,di.days_to_resolution as days_to_resolution
    ,di.assigned_to_user as assigned_to_user
    ,di.created as created
    ,di.updated as updated
    ,di.path_to_green as path_to_green
    ,di.path_to_green_last_updated as path_to_green_last_updated
    ,di.prior_eac as prior_eac
    ,di.revised_eac as revised_eac
    ,di.eac_change_category as eac_change_category 
FROM dim_oa_issue di LEFT JOIN dim_customer dc ON di.customer_id = dc.oa_customer_id
    )
;


  