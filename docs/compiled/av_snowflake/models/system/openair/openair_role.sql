WITH role AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_role
)

SELECT
        id::INT AS id
        ,name::VARCHAR AS name
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,_extracted_at::TIMESTAMP_TZ AS raw_updated

FROM
        role