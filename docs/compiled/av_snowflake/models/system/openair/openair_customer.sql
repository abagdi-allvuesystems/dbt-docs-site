WITH customers AS (
        SELECT * FROM AV_EDM.AV_SOURCE.wor_oa_customer
)

SELECT 
        id::INT AS id
        ,name::VARCHAR AS name
        ,CUSTOMER_LOCATIONID::INT AS customer_location_id
        ,currency::VARCHAR AS currency
        ,notes::VARCHAR AS notes
        ,IFNULL(active,FALSE)::BOOLEAN AS active
        ,EXTERNALID::VARCHAR AS external_id
        ,USERID::INT AS user_id
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,CUSTOMER_SF_ID__C::VARCHAR AS custom_7  --salesforce_id
        ,NETSUITE_CUSTOMER_ID__C::INT AS custom_118  --netsuite_id
        ,DELIVERY_MGR__C::INT AS custom_199  --delivery manager
        ,SEGMENT_2__C::VARCHAR AS custom_237      --segment
        ,DEPLOYMENT_TYPE__C::VARCHAR AS custom_238    --deployment type
        ,IFNULL(PRIORITY_CLIENT__C,FALSE)::BOOLEAN AS custom_239        --priority client
        ,CLIENT_VERTICAL__C::VARCHAR AS custom_373      --client vertical

FROM 
        customers