WITH raw_versions AS (
    SELECT * FROM AV_EDM.AV_SOURCE.jira_project_project_versions_raw
)
SELECT id::INT as id
    ,name::VARCHAR as name
    ,self::VARCHAR AS self
    ,overdue::BOOLEAN AS overdue
    ,archived::BOOLEAN as archived
    ,released::BOOLEAN as released
    ,projectid::INT as projectid
    ,startdate::date as startdate
    ,description::VARCHAR as description
    ,releasedate::DATE as releasedate
    ,TO_DATE(userstartdate, 'DD/Mon/YY') as userstartdate
    ,TO_DATE(userreleasedate, 'DD/Mon/YY') as userreleasedate
from raw_versions