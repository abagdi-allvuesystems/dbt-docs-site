WITH portal_cust_raw AS (
    SELECT * FROM AV_EDM.AV_SOURCE.jsm_portal_only_customers
)
SELECT username AS username
    ,full_name AS full_name
    ,email AS email
    ,active::BOOLEAN AS active
    ,CASE WHEN last_login = '' THEN NULL ELSE last_login END::TIMESTAMP_TZ AS last_login
    ,extracted_date::TIMESTAMP_TZ AS raw_updated
FROM portal_cust_raw