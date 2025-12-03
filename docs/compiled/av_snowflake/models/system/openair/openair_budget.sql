WITH budget AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_budget
)

SELECT
        id::INT AS id
        ,name::VARCHAR AS name
        ,customer_id::INT AS customer_id
        ,project_id::INT AS project_id
        ,budget_category_id::INT AS budget_category_id
        ,date::DATE AS date
        ,currency::VARCHAR AS currency
        ,total::DECIMAL(20,2) AS total
        ,notes::VARCHAR AS notes
        ,IFNULL(deleted,FALSE)::BOOLEAN AS deleted
        ,created::TIMESTAMP_NTZ AS created
        ,updated::TIMESTAMP_NTZ AS updated
        ,custom_314::DECIMAL(10,2) AS custom_314


FROM 
        budget