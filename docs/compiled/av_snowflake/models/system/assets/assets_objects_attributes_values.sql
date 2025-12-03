WITH assets_objects AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.assets_objects_attributes
)
SELECT aoa.objectid
    ,aoa.globalId AS objectGlobalId
    ,aoa.id AS objectAttributeId
    ,flat.VALUE:displayValue::VARCHAR AS displayValue
    ,flat.VALUE:referencedObject:id::VARCHAR as referecedObject_objectId
    ,flat.VALUE:referencedObject:objectKey::VARCHAR as referencedObject_objectKey
    ,flat.VALUE:referencedObject AS referencedObject
    ,flat.VALUE:referencedType::BOOLEAN AS referencedType
    ,flat.VALUE:searchValue::VARCHAR AS searchValue
    ,flat.VALUE:value::VARCHAR AS value
FROM assets_objects aoa,
    LATERAL FLATTEN(input => aoa.objectAttributeValues) flat