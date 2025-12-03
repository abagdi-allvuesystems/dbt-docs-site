WITH forex AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_forex
)

SELECT
        id::INT AS id
        ,symbol::VARCHAR AS symbol
        ,NULLIF(forex_date,'0000-00-00')::DATE AS forex_date
        ,jkey::VARCHAR AS jkey
        ,deleted::BOOLEAN AS deleted
        ,custom_cad::FLOAT AS custom_cad
        ,custom_usd::FLOAT AS custom_usd
        ,custom_gbp::FLOAT AS custom_gbp
        ,custom_eur::FLOAT AS custom_eur
        ,custom_uah::FLOAT AS custom_uah
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM
        forex