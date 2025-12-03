WITH lit_products AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.litheo_products
)
SELECT 
        segmentname AS segment
        ,productfamilyname AS product_family
        ,productname AS product 

FROM lit_products
    GROUP BY segmentname, productfamilyname, productname