WITH issuestage AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_issue_stage
)

SELECT id::INT AS id
    ,name::VARCHAR AS name
    ,IFNULL(considered_closed,FALSE)::BOOLEAN AS considered_closed
    ,position::INT AS position
    ,IFNULL(deleted,FALSE)::BOOLEAN AS deleted
    ,created::TIMESTAMP_NTZ AS created
    ,updated::TIMESTAMP_NTZ AS updated
FROM issuestage