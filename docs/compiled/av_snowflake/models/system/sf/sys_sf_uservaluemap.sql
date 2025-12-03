WITH raw_value_map AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_uservaluemap
)

SELECT
    -- Primary key
    id AS value_map_id,

    -- Name of the value map entry
    name AS value_map_name,

    -- Relationships / foreign keys
    opportunity__c AS opportunity_id,
    persona__c AS persona_id,

    -- Value Map Details
    objective__c AS objective,
    objective_motivation__c AS objective_motivation,
    challenges__c AS challenges,
    pain_cost_of_inaction__c AS pain_cost_of_inaction,
    initiatives__c AS initiatives,
    our_proof__c AS our_proof,
    our_impact__c AS our_impact,
    success_measure__c AS success_measure,
    deadline_milestones__c AS deadline_milestones,
    value_map_100_completed__c AS is_100_completed,

    -- Metadata dates
    createddate AS created_at,
    lastmodifieddate AS last_modified_at,
    lastactivitydate AS last_activity_date,
    lastreferenceddate AS last_referenced_date,
    lastvieweddate AS last_viewed_date,

    -- Airbyte metadata
    _airbyte_extracted_at AS raw_updated
FROM raw_value_map