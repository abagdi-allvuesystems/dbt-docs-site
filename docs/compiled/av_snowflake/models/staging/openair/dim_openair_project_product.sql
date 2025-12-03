WITH hist_dim_task AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_openair_project_task where is_current = true and is_deleted = false
), sys_proj_task AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project_task
), product_xref AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_product_xref
)
    SELECT pt.project_id
        ,MD5(CONCAT(pt.project_id::VARCHAR
                 ,IFNULL(dpt.product,'(Not Identified)') ))
                 AS proj_prod_key
        ,CASE WHEN IFNULL(dpt.product,'(Not Identified)') = '(n/a)' THEN '(n/a)'
            WHEN IFNULL(dpt.product, '(Not Identified)') = '(Not Identified)' THEN '(Not Identified)'
            ELSE px.product_family END AS product_family
        ,IFNULL(dpt.product,'(Not Identified)') AS product
        ,SUM(pt.custom_253) AS scope_hours
    from hist_dim_task dpt JOIN sys_proj_task pt on dpt.project_task_id = pt.id
        LEFT JOIN product_xref px on dpt.product = px.product
    GROUP BY pt.project_id, dpt.product, px.product_family