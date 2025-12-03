
  create or replace   view AV_EDM.AV_STAGING.dim_openair_budget
  
  
  
  
  as (
    WITH oa_budget as (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_budget WHERE deleted = FALSE
), oa_cust as (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_customer
), oa_proj as (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_project
)
select ob.id AS id
    ,ob.name AS name
    ,ob.customer_id AS customer_id
    ,c.name::VARCHAR AS customer_name
    ,ob.project_id AS project_id
    ,pr.name::VARCHAR AS project_name
    ,ob.budget_category_id AS budget_category_id
    ,CASE WHEN ob.budget_category_id = 1 THEN 'original'
            WHEN ob.budget_category_id = 2 THEN 'change order'
            ELSE NULL
            END::VARCHAR AS budget_category
    ,ob.date AS date
    ,ob.currency AS currency
    ,ob.total AS total
    ,ob.notes AS notes
    ,ob.deleted AS deleted
    ,ob.created AS created
    ,ob.updated AS updated
    ,ob.custom_314 AS hours
    ,CASE WHEN ROW_NUMBER() OVER (PARTITION BY project_id ORDER BY ob.created) = 1 THEN true
        ELSE false
        END as is_initial
from oa_budget ob LEFT JOIN oa_cust c ON ob.customer_id = c.id
                LEFT JOIN oa_proj pr ON ob.project_id = pr.id
  );

