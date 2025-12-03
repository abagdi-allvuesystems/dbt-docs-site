
  create or replace   view AV_EDM.AV_SYSTEM.openair_issue
  
  
  
  
  as (
    WITH issue AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_issue
)

SELECT id::INT AS id
    ,number::VARCHAR AS number
    ,prefix::VARCHAR AS prefix
    ,name::VARCHAR AS name
    ,owner_id::INT AS owner_id                  --Entered by
    ,description::VARCHAR AS description
    ,customer_id::INT AS customer_id
    ,project_id::INT AS project_id
    ,project_task_id::INT AS project_task_id
    ,issue_category_id::INT AS issue_category_id
    ,issue_status_id::INT AS issue_status_id
    ,issue_stage_id::INT AS issue_stage_id
    ,issue_severity_id::INT AS issue_severity_id
    ,issue_source_id::INT AS issue_source_id
    ,issue_notes::VARCHAR AS issue_notes
    ,resolution_notes::VARCHAR AS resolution_notes
    ,CASE WHEN date = '0000-00-00' THEN NULL ELSE date END::DATE AS date
    ,CASE WHEN date_resolved = '0000-00-00' THEN NULL ELSE date_resolved END::DATE AS date_resolved
    ,CASE WHEN date_resolved = '0000-00-00' THEN NULL ELSE DATEDIFF(DAY, date, date_resolved) END::INT AS days_to_resolution
    ,user_id::INT AS user_id                    --Assigned to
    ,priority::VARCHAR AS priority
    ,attachment_id::INT AS attachment_id
    ,IFNULL(deleted,FALSE)::BOOLEAN AS deleted
    ,CASE WHEN created = '0000-00-00' THEN NULL ELSE created END::TIMESTAMP_NTZ AS created
    ,CASE WHEN updated = '0000-00-00' THEN NULL ELSE updated END::TIMESTAMP_NTZ AS updated
    ,custom_167::VARCHAR AS custom_167          --Path to Green
    ,custom_334::DECIMAL(10,2) AS custom_334    --Project Snapshot Budget Hours
    ,custom_335::DECIMAL(10,2) AS custom_335    --Project Snapshot EAC Hours
    ,custom_336::DECIMAL(10,2) AS custom_336    --Project Snapshot Worked Hours
    ,custom_337::DECIMAL(10,2) AS custom_337    --Project Snapshot Approved Hours
    ,custom_338::DECIMAL(10,2) AS custom_338    --Project Snapshot ETC Hours
    ,custom_339::VARCHAR AS custom_339  --Project Snapshot RAG Status
    ,custom_340::VARCHAR AS custom_340  --Project Snapshot Project Stage
    ,IFNULL(custom_341,FALSE)::BOOLEAN AS custom_341  --Project Snapshot New Project
    ,custom_347::DECIMAL(10,2) AS custom_347  --Issue Stage Value
    ,CASE WHEN custom_348 = '0000-00-00' THEN NULL ELSE custom_348 END::DATE AS custom_348  --Path to Green Last Updated
    ,CASE WHEN custom_350 = '0000-00-00' THEN NULL ELSE custom_350 END::DATE AS custom_350  --Project Snapshot Close Date
    ,custom_377::DECIMAL(10,2) AS custom_377  --Prior EAC
    ,custom_378::DECIMAL(10,2) AS custom_378  --Revised EAC
    ,custom_382::VARCHAR AS custom_382  --EAC Change Category
FROM issue
  );

