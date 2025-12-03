WITH source_powermap AS (
    SELECT *FROM AV_EDM.AV_SOURCE.src_ab_sf_powermap
)

SELECT
    -- Primary Key
    id AS id,

    -- Core Attributes
    name AS name,
    role__c AS role,
    persona__c AS persona,
    qs_name__c AS qs_name,
    qs_title__c AS qs_title,
    email__c AS email,

    -- Relationship to Opportunities / QS
    qs_opportunity__c AS qs_opportunity_id,

    -- Influence Metadata
    qs_primary__c AS is_primary,
    qs_influence_level__c AS influence_level,
    qs_formal_role__c AS formal_role,
    qs_relationshipsupport__c AS relationship_support,
    qs_has_necessary_clout_to_get_a_yes__c AS has_clout_to_get_yes,
    qs_has_a_record_of_getting_things_done__c AS has_record_of_execution,
    qs_hyper_focused_on_executive_priority__c AS hyper_focused_on_executive_priority,
    opponent_reason__c AS opponent_reason,
    value_map__c AS value_map,

    -- Win/Loss
    win_loss_program_participant__c AS win_loss_participant,

    -- Audit Fields
    createddate AS created_at,
    createdbyid AS created_by_id,
    lastmodifieddate AS last_modified_at,
    lastmodifiedbyid AS last_modified_by_id,
    lastactivitydate AS last_activity_date,
    systemmodstamp AS system_modstamp,
    isdeleted AS is_deleted,

    -- Currency
    currencyisocode AS currency_iso_code,
    -- Airbyte Metadata
    _airbyte_extracted_at AS extracted_at

FROM source_powermap