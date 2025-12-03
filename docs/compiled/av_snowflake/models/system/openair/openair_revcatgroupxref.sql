WITH revcatgroupxref AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_revcatgroupxref
)

SELECT
        revenuecategory::VARCHAR AS revenue_category
        ,revenuegroup::VARCHAR AS revenue_group
        ,utilizationgroup::VARCHAR AS utilization_group
        ,internalID::INT AS id
FROM revcatgroupxref