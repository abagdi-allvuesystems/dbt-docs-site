WITH assets_objects AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects
)
SELECT ao.id AS objectId
    ,flat.VALUE:globalId::STRING AS globalId
    ,flat.VALUE:id::NUMBER AS id
    ,flat.VALUE:objectAttributeValues AS objectAttributeValues
    ,flat.VALUE:objectTypeAttributeId::NUMBER AS objectTypeAttributeId
    ,flat.VALUE:workspaceId::VARCHAR AS workspaceId
FROM assets_objects ao,
    LATERAL FLATTEN(input => ao.attributes) flat