WITH dim_lit_products AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_products
)
SELECT 
        segment AS segment
        ,product_family AS product_family
        ,product AS products

FROM dim_lit_products