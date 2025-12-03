
  create or replace   view AV_EDM.AV_SYSTEM.openair_project
  
  
  
  
  as (
    WITH project AS (
    SELECT * FROM AV_EDM.AV_SOURCE.wor_oa_project
)
SELECT 
        id::INT AS id
        ,name::VARCHAR AS name
        ,PROJECT_STAGEID::INT as project_stage_id
        ,customerid::INT as customer_id
        ,tb_approver::INT as tb_approver
        ,tb_approvalprocess::INT as tb_approvalprocess
        ,start_date::DATE as start_date
        ,finish_date::DATE as finish_date
        ,budget_time::DECIMAL(10,2) as budget_time
        ,notes::VARCHAR as notes
        ,IFNULL(active,false)::BOOLEAN AS active
        ,externalid::VARCHAR as external_id
        ,budget::DECIMAL(20,2) as budget
        ,currency::VARCHAR as currency
        ,ta_approver::INT as ta_approver
        ,userid::INT as user_id

        --Custom Fields
        ,IFNULL(PROJ_ALLOW_TIME_ENTRY__C,false)::BOOLEAN as custom_18 --proj_allow_time_entry
        ,CASE WHEN PROJECT_PLANNED_GOLIVE__C = '0000-00-00' THEN NULL
              ELSE PROJECT_PLANNED_GOLIVE__C END::DATE as custom_90 --project_planned_golive
        ,CASE WHEN PROJECT_REVISED_GOLIVE__C = '0000-00-00' THEN NULL
              ELSE PROJECT_REVISED_GOLIVE__C END::DATE as custom_91 --project_revised_golive
        ,POSTMORTEM_NOTES__C::VARCHAR as custom_94 --postmortem_notes
        ,PROJECT_ORIGINAL_HOURS__C::DECIMAL(10,2) as custom_95 --project_original_hours
        ,PROJECT_OPPORTUNITY__C::VARCHAR as custom_98 --project_opportunity
        ,IFNULL(EXPORT_TO_NS__C,false)::BOOLEAN as custom_104 --export_to_ns
        ,NETSUITE_PROJECT_ID__C::INT as custom_109 --netsuite_project_id
        ,PROJECT_COMPLIANCE__C::VARCHAR as custom_148 --project_compliance
        ,PROJECT_TYPE__C::VARCHAR as custom_151 --project_type
        ,IFNULL(PROJECT_CLUSTER_CHECKBOX__C,false)::BOOLEAN as custom_157 --billing rules setup
        ,IFNULL(PROJECT_FINANCE_REVIEW__C,false)::BOOLEAN as custom_158 --project_finance_review
        ,PROJECT_DOCUMENT_REPOSITORY__C::VARCHAR as custom_166 --project_document_repository
        ,PROJ_STATUS_SUMMARY__C::VARCHAR as custom_168 --proj_status_summary
        ,SPECIAL_BILLING_SITUATION__C::VARCHAR as custom_183 --special_billing_situation
        ,NS_SALES_ORDER_NUMBER__C::INT as custom_185 --ns_sales_order_number
        ,CASE WHEN INVOICING_HOLD__C = '1' THEN true
              WHEN INVOICING_HOLD__C is NULL THEN false
              WHEN INVOICING_HOLD__C = '0' THEN NULL
         END::BOOLEAN AS custom_189 --invoicing_hold
        ,IFNULL(ISFIXEDBID__C,false)::BOOLEAN as custom_191 --isfixedbid
        ,RAG_FINANCIAL__C::VARCHAR as custom_194 --rag_financial
        ,RAG_SUMMARY__C::VARCHAR as custom_195 --project_health_commentary
        ,RAG_TIMELINE__C::VARCHAR as custom_197 --rag_timeline
        ,RAG_CUSTOMER_EXPERIENCE__C::VARCHAR as RAG_CUSTOMER_EXPERIENCE 
        ,IFNULL(SCOPING_PROJECT__C,false)::BOOLEAN as custom_218 --scoping_project
        ,RAG_OVERALL__C::VARCHAR as custom_200 --rag_overall
        ,SF_PROJECT_ID__C::VARCHAR as custom_219 --sf_project_id
        ,PROJECT_SF_CUSTOMER_TYPE__C::VARCHAR as custom_220 --project_sf_customer_type
        ,PROJECT_SF_ORDER_SUB_TYPE__C::VARCHAR as custom_221 --project_sf_order_sub_type
        ,PROJECT_SF_ORDER_TYPE__C::VARCHAR as custom_222 --project_sf_order_type
        ,PROJECT_OPP_STAGE__C::VARCHAR as custom_223 --project_opp_stage
        ,PROJECT_EAC_HOURS__C::DECIMAL(10,2) as custom_236 --project_eac_hours
        ,PRJ_PROJECT_DELIVERY_LEAD__C::INT as custom_245 --prj_project_delivery_lead
        ,LITHEO_CUSTOMER_ID__C::INT as custom_249 --litheo_customer_id
        ,NET_REVENUE_IMPACT__C::DECIMAL(20,2) as custom_252 --net revenue impact
        ,SF_UNIQUE_ID__C::INT as customer_261 --litheo_opportunity_id
        ,SF_OPP_NAME__C::VARCHAR as custom_262 --sf_opp_name
        ,PROJECT_PRACTICE__C::VARCHAR as custom_309 --project_segment
        ,REPORTING_VERTICAL__C::VARCHAR AS reporting_vertical
        ,BACKLOG_STATUS__C::VARCHAR AS backlog_status
        ,BACKLOG_RAG__C::VARCHAR AS backlog_rag
        ,BACKLOG_COMMENTARY__C::VARCHAR AS backlog_commentary
        ,PROJECT_APPROVED_HOURS__C::DECIMAL(10,2) as custom_318 --project_approved_hours
        ,SF_OPP_UNIQUE_ID__C::VARCHAR as custom_322 --sf_opp_unique_id
        ,PROJECT_SUB_PRODUCT__C::VARCHAR as custom_324 --project_sub_product
        ,CASE WHEN PROJECTCOMPLETIONDATE__C = '0000-00-00' THEN NULL
              ELSE PROJECTCOMPLETIONDATE__C END::DATE as custom_172 --planned_project_completion_date 
        ,CASE WHEN PROJECT_CLOSE_COMPLETED_DATE__C = '0000-00-00' THEN NULL
              ELSE PROJECT_CLOSE_COMPLETED_DATE__C END::DATE as custom_327 --planned_uat_end  
        ,IFNULL(REV_DRAIN_CURRENT__C,false)::BOOLEAN as custom_329 --rev_drain_current
        ,IFNULL(REV_DRAIN_POTENTIAL__C,false)::BOOLEAN as custom_331 --rev_drain_potential
        ,CASE WHEN REV_DRAIN_DATE__C = '0000-00-00' THEN NULL
              ELSE REV_DRAIN_DATE__C END::DATE as custom_332 --rev_drain_date
        ,CASE WHEN REV_DRAIN_POTENTIAL_DATE__C = '0000-00-00' THEN NULL
              ELSE REV_DRAIN_POTENTIAL_DATE__C END::DATE as custom_333 --rev_drain_potential_date
        ,IFNULL(PRJ_PROCEEDING_WO_SOW__C,false)::BOOLEAN as custom_342
        ,CLIENT_PURCHASE_ORDER__C::VARCHAR as custom_364 --client_purchase_order
        ,IFNULL(PROJECT_ACTIVE_IMPLEMENTATION__C,false)::BOOLEAN as custom_365 --project_active_implementation
        ,created::TIMESTAMP_NTZ as created
        ,updated::TIMESTAMP_NTZ as updated
        ,_extracted_at::TIMESTAMP_TZ AS raw_updated
        ,IFNULL(deleted,false)::BOOLEAN AS deleted
        ,IFNULL(MATERIAL_PROJECT__c,0)::BOOLEAN AS BACKLOG_PROJECT
FROM
        project
  );

