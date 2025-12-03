/*
Slip, timebill, charge, or bill

Basic transaction unit. Invoices are created by aggregating multiple slips

*/
WITH slip AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_slip
)

SELECT 
        id::INT AS id
        ,customer_id::INT AS customer_id
        ,project_id::INT AS project_id
        ,project_task_id::INT AS project_task_id
        ,user_id::INT AS user_id
        ,currency::VARCHAR AS currency
        ,rate::FLOAT AS rate
        ,hour::INT AS hour
        ,minute::INT AS minute
        ,total::FLOAT AS total
        ,hour::INT + (minute::INT/60) AS decimal_hours
        ,notes::VARCHAR AS notes
        ,NULLIF(date,'0000-00-00')::DATE AS date
        ,category_4_id::INT AS revcatgroupxref_id
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,_extracted_at::TIMESTAMP_TZ AS raw_updated
        ,IFNULL(deleted,false)::BOOLEAN AS deleted

FROM 
        slip