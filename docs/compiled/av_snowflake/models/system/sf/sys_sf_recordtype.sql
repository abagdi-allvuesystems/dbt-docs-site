WITH airbyte_raw_recordtype AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_recordtype
)
SELECT id AS id
        ,name AS name
        ,isactive::BOOLEAN AS isactive
        ,createdbyid AS createdbyid
        ,createddate::TIMESTAMP_TZ AS createddate
        ,description AS description
        ,sobjecttype AS sobjecttype
        ,developername AS developername
        ,systemmodstamp::TIMESTAMP_TZ AS systemmodstamp
        ,lastmodifiedbyid AS lastmodifiedbyid
        ,lastmodifieddate::TIMESTAMP_TZ AS lastmodifieddate
        ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM airbyte_raw_recordtype