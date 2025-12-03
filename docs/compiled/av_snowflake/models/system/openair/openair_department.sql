WITH department AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_department
)

SELECT
        id::INT AS id
        ,name::VARCHAR AS name
        ,user_id::INT AS user_id
        ,notes::VARCHAR AS notes
        ,created::TIMESTAMP_NTZ AS created
        ,updated::TIMESTAMP_NTZ AS updated


FROM 
        department