WITH prod_xref AS (
    SELECT * FROM AV_EDM.AV_SOURCE.man_oa_lit_product_xref
)

SELECT segment
    ,IFNULL(product_family,'(n/a)') AS product_family
    ,product
    ,sub_product
FROM prod_xref