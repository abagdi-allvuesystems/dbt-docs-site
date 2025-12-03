

WITH man_ps AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_odata_oa_project_snapshots
)
SELECT 
    "INTERNAL ID - PROJECT_ID"::INT AS project_id,
    "PROJECT STAGE"::VARCHAR AS project_stage,
    "ISSUE DATE"::DATE AS snapshot_date,
    "PROJECT BUDGET HOURS"::DECIMAL(10,2) AS budget_hours,
    "PROJECT EAC HOURS"::DECIMAL(10,2) AS eac_hours,
    "PROJECT APPROVED HOURS"::DECIMAL(10,2) AS approved_hours,
    "PROJECT WORKED HOURS"::DECIMAL(10,2) AS worked_hours,
    "PROJECT ETC HOURS"::DECIMAL(10,2) AS etc_hours,
    "PROJECT RAG STATUS"::VARCHAR AS rag_status
FROM man_ps