WITH issuestatus AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_issue_status
)

SELECT id::INT AS id
    ,name::VARCHAR AS name
    ,IFNULL(active,FALSE)::BOOLEAN AS active
    ,IFNULL(deleted,FALSE)::BOOLEAN AS deleted
    ,created::TIMESTAMP_NTZ AS created
    ,updated::TIMESTAMP_NTZ AS updated
FROM issuestatus