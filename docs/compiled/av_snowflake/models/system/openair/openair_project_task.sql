/*

CAN BE A PHASE OR A TASK

The individual tasks (work packages) that comprise a project. 
If any other project_task lists this task as its parent, then we are a phase. 
If we are a phase, then the "is_a_phase" field is set to 1 and the start_date, 
planned_hours, and percent_complete fields do not apply because they are computed from the child tasks.

*/
WITH project_task AS (
    SELECT * FROM AV_EDM.AV_SOURCE.wor_oa_project_task
)

SELECT
        id::INT AS id
        ,customerid:: INT AS customer_id
        ,projectid::INT AS project_id
        ,parentid::INT AS parent_id
        ,projecttask_typeid::INT AS projecttask_type_id
        ,externalid::VARCHAR AS external_id
        ,predecessors::VARCHAR AS predecessors
        ,IFNULL(is_a_phase,FALSE)::BOOLEAN AS is_a_phase
        ,seq::INT AS seq
        ,id_number::VARCHAR AS id_number
        ,name::VARCHAR AS name
        ,notes::VARCHAR AS notes
        ,CASE WHEN starts = '0000-00-00' THEN NULL
            WHEN starts = '0000-00-00 0:0:0' THEN NULL
              ELSE starts END::DATE as start_date
        ,CASE WHEN fnlt_date = '0000-00-00' THEN NULL
            WHEN fnlt_date  = '0000-00-00 0:0:0' THEN NULL
                ELSE fnlt_date END::DATE AS fnlt_date
        ,planned_hours::DECIMAL(10,2) AS planned_hours
        ,estimated_hours::DECIMAL(10,2) AS estimated_hours
        ,priority::VARCHAR AS priority
        ,IFNULL(closed,FALSE)::BOOLEAN AS closed
        ,percent_complete::DECIMAL(10,4) AS percent_complete
        ,currency::VARCHAR AS currency
        ,IFNULL(non_billable,FALSE)::BOOLEAN AS non_billable
        ,IFNULL(deleted,FALSE)::BOOLEAN AS deleted
        ,created::TIMESTAMP_NTZ AS created
        ,updated:: TIMESTAMP_NTZ AS updated
        ,classification::VARCHAR AS classification

        --CUSTOM FIELDS
        ,TASK_CATEGORY__C::VARCHAR AS custom_83    --task_category
        ,TASK_BUDGET_MONEY__C::DECIMAL(20,2) AS custom_87  --task_budget_money
        ,TASK_STATUS__C::VARCHAR AS custom_154  --task_status
        ,TASK_DOCUMENT_REPOSITORY__C::VARCHAR AS custom_171  --task_document_repository
        ,CASE WHEN PHASE_REVISED_GO_LIVE_DATE__C = '0000-00-00' THEN NULL
            WHEN PHASE_REVISED_GO_LIVE_DATE__C  = '0000-00-00 0:0:0' THEN NULL
              ELSE PHASE_REVISED_GO_LIVE_DATE__C END::DATE as custom_212   --phase_revised_go_live_date
        ,CASE WHEN PHASE_GO_LIVE_DATE__C = '0000-00-00' THEN NULL
            WHEN PHASE_GO_LIVE_DATE__C  = '0000-00-00 0:0:0' THEN NULL
              ELSE PHASE_GO_LIVE_DATE__C END::DATE as custom_213   --phase_planned_go_live_date
        ,IFNULL(TASK_SCOPE_HOURS__C,0)::DECIMAL(10,2) AS custom_253    --task_scope_hours
        ,PHASE_EPIC_DELIVERY_TEAM__C::VARCHAR AS custom_274  --phase_epic_delivery_team
        ,PHASE_SCOPE_HOURS__C::DECIMAL(10,2) AS custom_275    --phase_scope_hours
        ,IFNULL(PHASE_CURRENT_ESTIMATED_HOURS__C,0)::DECIMAL(10,2) AS custom_283    --phase_eac_hours
        ,TASK_STORY_DELIVERY_TEAM__C::VARCHAR AS custom_288  --task_story_delivery_team
        ,TASK_CUSTOM_OR_STANDARD__C::VARCHAR AS custom_289  --task_custom_or_standard
        ,TASK_PRODUCT__C::VARCHAR AS custom_290  --task_product
        ,TASK_SUB_PRODUCT__C::VARCHAR AS custom_291  --task_sub_product
        ,CASE WHEN TASK_CONTRACTUAL_COMMITMENT__C = 'f' THEN NULL
            WHEN TASK_CONTRACTUAL_COMMITMENT__C IS NULL THEN FALSE
            WHEN TASK_CONTRACTUAL_COMMITMENT__C = 't' THEN 1
            WHEN TASK_CONTRACTUAL_COMMITMENT__C = 1 THEN TRUE
            WHEN TASK_CONTRACTUAL_COMMITMENT__C = 0 THEN FALSE
        END::BOOLEAN AS custom_292  --task_contractual_commitment
        ,CASE WHEN TASK_SELF_SERVICE__C = 'f' THEN NULL
            WHEN TASK_SELF_SERVICE__C = 't' THEN 1
            WHEN TASK_SELF_SERVICE__C IS NULL THEN FALSE
            WHEN TASK_SELF_SERVICE__C = 1 THEN TRUE
            WHEN TASK_SELF_SERVICE__C = 0 THEN FALSE
        END::BOOLEAN AS custom_293 --task_self_service
        ,CASE WHEN TASK_IS_CHANGE_REQUEST__C = 'f' THEN NULL
            WHEN TASK_IS_CHANGE_REQUEST__C IS NULL THEN FALSE
            WHEN TASK_IS_CHANGE_REQUEST__C = 't' THEN 1
            WHEN TASK_IS_CHANGE_REQUEST__C = 1 THEN TRUE
            WHEN TASK_IS_CHANGE_REQUEST__C = 0 THEN FALSE
        END::BOOLEAN AS custom_294  --task_is_change_request
        ,TASK_PARENT_SCOPE_ITEM_ID__C::INT AS custom_307  --task_parent_scope_item_id
        ,PHASE_PRODUCT__C::VARCHAR AS custom_310  --phase_product
        ,PHASE_SUB_PRODUCT__C::VARCHAR AS custom_311  --phase_sub_product
        ,TASK_ACTUAL_HOURS__C::DECIMAL(10,2) AS custom_315    --task_actual_hours
        ,TASK_PARTNER_ENGAGEMENT_CLIENT__C::INT AS custom_349  --task_partner_engagement_client
        ,IFNULL(TASK_PLANNED_HOURS__C,0)::DECIMAL(10,2) AS custom_352    --task_eac_hours
        ,IFNULL(PHASE_FIRST_GO_LIVE__C,FALSE)::BOOLEAN AS custom_369    --phase_is_first_go_live
        ,IFNULL(TASK_FIRST_GO_LIVE__C,FALSE)::BOOLEAN AS custom_370    --task_is_first_go_live 
        ,CASE WHEN TASK_GO_LIVE_DATE__C = '0000-00-00' THEN NULL
            WHEN TASK_GO_LIVE_DATE__C  = '0000-00-00 0:0:0' THEN NULL
              ELSE TASK_GO_LIVE_DATE__C END::DATE as custom_371 --task_planned_go_live_date
        ,CASE WHEN TASK_REVISED_ACTUAL_GOLIVE_DATE__C = '0000-00-00' THEN NULL
            WHEN TASK_REVISED_ACTUAL_GOLIVE_DATE__C  = '0000-00-00 0:0:0' THEN NULL
              ELSE TASK_REVISED_ACTUAL_GOLIVE_DATE__C END::DATE as custom_372 --task_revised_actual_golive_date
        ,IFNULL(TASK_MISSING_BILLING_RULE__C,FALSE)::BOOLEAN AS custom_374    --task_missing_billing_rule
        ,CLIENT_APPROVED_SCOPE_HURS__C::DECIMAL(10,2) AS custom_386
        ,TASK_EAC_CHANGES_BILLABLE__C::VARCHAR AS custom_388

FROM project_task