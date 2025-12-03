WITH src_snap AS (
    SELECT * FROM AV_EDM.AV_SOURCE.sp_openair_projects
)
SELECT 
        id::INT AS id
        ,dbt_valid_from AS snapshot_valid_from
        ,dbt_valid_to as snapshot_valid_to
        ,name::VARCHAR AS name
        ,project_stage_id::INT as project_stage_id
        ,start_date::DATE as start_date
        ,finish_date::DATE as finish_date
        ,budget::DECIMAL(20,2) as budget
        ,budget_time::DECIMAL(10,2) AS budget_hours
        ,notes::VARCHAR as notes
        ,active::BOOLEAN AS active
        ,tb_approvalprocess::INT as tb_approvalprocess
        ,user_id::INT as user_id

        --Custom Fields
        ,custom_18::BOOLEAN AS custom_18 --proj_allow_time_entry
        ,custom_90::DATE AS custom_90 --project_planned_golive
        ,custom_91::DATE AS custom_91 --project_revised_golive
        ,custom_94::VARCHAR as custom_94 --postmortem_notes
        ,custom_151::VARCHAR as custom_151 --project_type
        ,custom_157::BOOLEAN as custom_157 --billing rules setup
        ,custom_158::BOOLEAN as custom_158 --project_finance_review
        ,custom_166::VARCHAR as custom_166 --project_document_repository
        ,custom_168::VARCHAR as custom_168 --proj_status_summary
        ,custom_169::DATE as custom_169 --planned_uat
        ,custom_170::DATE as custom_170 --revised_uat
        ,custom_183::VARCHAR as custom_183 --special_billing_situation
        ,custom_185::INT as custom_185 --ns_sales_order_number
        ,custom_189::BOOLEAN AS custom_189 --invoicing_hold
        ,custom_194::VARCHAR as custom_194 --rag_financial
        ,custom_195::VARCHAR as custom_195 --rag_summary
        ,custom_197::VARCHAR as custom_197 --rag_plan
        ,custom_198::VARCHAR as custom_198 --rag_resources
        ,custom_200::VARCHAR as custom_200 --rag_overall
        ,custom_223::VARCHAR as custom_223 --project_opp_stage
        ,custom_236::DECIMAL(10,2) as custom_236 --project_eac_hours
        ,custom_245::INT as custom_245 --prj_project_delivery_lead
        ,custom_252::DECIMAL(20,2) as custom_252 --net revenue impact
        ,custom_309::VARCHAR as custom_309 --project_segment
        ,custom_318::DECIMAL(10,2) as custom_318 --project_approved_hours
        ,custom_322::VARCHAR as custom_322 --sf_opp_unique_id
        ,custom_324::VARCHAR as custom_324 --project_sub_product
        ,custom_327::DATE as custom_327 --planned_uat_end  
        ,custom_329::BOOLEAN as custom_329 --rev_drain_current
        ,custom_331::BOOLEAN as custom_331 --rev_drain_potential
        ,custom_332::DATE as custom_332 --rev_drain_date
        ,custom_333::DATE as custom_333 --rev_drain_potential_date
        ,custom_342::BOOLEAN as custom_342
        ,custom_353::DATE as custom_353 --planned_uat_end   
        ,custom_354::DATE as custom_354 --revised uat end
        ,custom_364::VARCHAR as custom_364 --client_purchase_order
        ,custom_365::BOOLEAN as custom_365 --project_active_implementation
        ,custom_366::DATE as custom_366 --project_planned_final_go_live
        ,custom_367::DATE as custom_367 --project_revised_actual_final_go_live
        ,deleted::BOOLEAN AS deleted
FROM src_snap