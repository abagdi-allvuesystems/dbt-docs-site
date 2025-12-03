WITH source_opportunity_field_history AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_opportunityfieldhistory
)

SELECT
    -- Primary & Foreign Keys
    id AS id,
    opportunityid AS opportunity_id,

    -- Field Change Metadata
    field AS field,
    datatype  AS data_type,
    oldvalue AS old_value,
    newvalue AS new_value,

    -- Audit Fields
    isdeleted AS is_deleted,
    createdbyid AS created_by_id,
    createddate AS created_at,

    -- Airbyte Metadata
    _airbyte_extracted_at AS extracted_at

FROM source_opportunity_field_history