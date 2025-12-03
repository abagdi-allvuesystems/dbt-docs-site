--this model separates out the non-Snapshot issues, only.  Snapshots may be discontinued in the future, but other issues will continue to be used indefinitely.

WITH issue AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_issue WHERE issue_category_id != 2 AND deleted != TRUE
), issuecat AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_issue_category
), issuesev AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_issue_severity
), issuesource AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_issue_source
), issuestage AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_issue_stage
), issuestatus AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_issue_status
), customer AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_customer
), user AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_user
), project AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_openair_project
)

select iss.id AS id
    ,iss.name AS name
    ,iss.owner_id AS project_owner_id
    ,ow.name AS entered_by_user
    ,iss.description AS description
    ,iss.customer_id AS customer_id
    ,cs.name AS customer_name
    ,iss.project_id AS project_id
    ,pj.name AS project_name
    ,iss.project_task_id AS project_task_id
    ,iss.issue_category_id AS issue_category_id
    ,ca.name AS issue_category
    ,iss.issue_status_id AS issue_status_id
    ,ss.name AS issue_status
    ,iss.issue_stage_id AS issue_stage_id
    ,st.name AS issue_stage
    ,iss.issue_severity_id AS issue_severity_id
    ,se.name AS issue_severity
    ,iss.issue_source_id AS issue_source_id
    ,so.name AS issue_source
    ,iss.issue_notes AS issue_notes
    ,iss.resolution_notes AS resolution_notes
    ,iss.date AS issue_date
    ,iss.date_resolved AS date_resolved
    ,iss.days_to_resolution AS days_to_resolution
    ,iss.user_id AS user_id
    ,us.name AS assigned_to_user
    ,iss.priority AS priority
    ,iss.attachment_id AS attachment_id
    ,IFNULL(iss.deleted,FALSE) AS deleted
    ,iss.created AS created
    ,iss.updated AS updated
    ,iss.custom_167 AS path_to_green
    ,iss.custom_347 AS issue_stage_value
    ,iss.custom_348 AS path_to_green_last_updated
    ,iss.custom_377 AS prior_eac
    ,iss.custom_378 AS revised_eac
    ,iss.custom_382 AS eac_change_category

from issue iss   LEFT JOIN user ow ON iss.owner_id = ow.id 
                LEFT JOIN user us ON iss.user_id = us.id
                LEFT JOIN issuecat ca ON iss.issue_category_id = ca.id
                LEFT JOIN issuesev se ON iss.issue_severity_id = se.id
                LEFT JOIN issuesource so ON iss.issue_source_id = so.id
                LEFT JOIN issuestage st ON iss.issue_stage_id = st.id
                LEFT JOIN issuestatus ss ON iss.issue_status_id = ss.id
                LEFT JOIN customer cs ON iss.customer_id = cs.id
                LEFT JOIN project pj ON iss.project_id = pj.id