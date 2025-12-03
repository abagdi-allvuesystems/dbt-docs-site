WITH user AS (
    SELECT * FROM AV_EDM.AV_SOURCE.csv_oa_user
)

SELECT
        id::INT AS id
        ,name::VARCHAR AS name
        ,first::VARCHAR AS first_name
        ,middle::VARCHAR AS middle_name
        ,last::VARCHAR AS last_name
        ,department_id::INT AS department_id
        ,email::VARCHAR AS email
        ,role_id::INT AS role_id
        ,line_manager_id::INT AS line_manager_id
        ,workschedule_id::INT AS work_schedule_id
        ,IFNULL(active,false)::BOOLEAN AS active
        ,created::TIMESTAMP_TZ AS created
        ,updated::TIMESTAMP_TZ AS updated
        ,external_id::VARCHAR AS external_id
        ,IFNULL(generic, false)::BOOLEAN AS generic
        ,nickname::VARCHAR AS nickname
        ,ta_approver::INT AS ta_approver
        ,timezone::VARCHAR AS timezone
        ,custom_19::VARCHAR AS custom_19        --emp_status
        ,custom_138::INT AS custom_138  --netsuite_user_id
        ,custom_188::BOOLEAN AS custom_188      --IsManager
        ,custom_205::VARCHAR AS custom_205      --user_delivery_team
        ,custom_206::VARCHAR AS custom_206      --user_delivery_org
        ,custom_207::VARCHAR AS custom_207      --user_ps_vertical
        ,NULLIF(custom_231,'0000-00-00')::DATE AS custom_231    --PS_Start_Date
        ,NULLIF(custom_232,'0000-00-00')::DATE AS custom_232    --PS_Term_Date
        ,custom_233::VARCHAR AS custom_233      --Utilization_Category
        ,custom_247::VARCHAR AS custom_247      --user_region_2022
        ,custom_256::VARCHAR AS custom_256      --user_contractor_group
    
FROM 
        USER
ORDER BY 
        ID::INT asc