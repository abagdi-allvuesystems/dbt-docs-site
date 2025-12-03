WITH oa_cust as (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_customer
), oa_users as (
    SELECT * FROM AV_EDM.AV_SYSTEM.openair_user
)
select oc.id AS id
    ,oc.name AS name
    ,oc.custom_7 AS sf_account_id
    ,oc.custom_118 AS ns_customer_id
    ,oc.external_id AS external_id
    ,oc.currency as currency
    ,oc.user_id as user_id
    ,u.name AS user_name
    ,oc.custom_199 as delivery_mgr_user_id
    ,dm.name AS delivery_mgr_user_name
    ,oc.custom_237 AS segment
    ,oc.custom_238 AS deployment_type
    ,oc.custom_239 AS is_priority_client
    ,oc.custom_373 AS client_vertical
    ,CASE WHEN oc.name in ('Allvue','Allvue Scoping','AltaReturn','Black Mountain Systems','Training Company') THEN TRUE
            ELSE FALSE
            END::BOOLEAN AS is_internal
from oa_cust oc LEFT JOIN oa_users u ON oc.user_id = u.id
                LEFT JOIN oa_users dm ON oc.custom_199 = dm.id