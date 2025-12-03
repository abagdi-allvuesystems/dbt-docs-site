WITH objectschema_attr AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_objectschema_attributes
), assets_type_attribute AS (
    SELECT DISTINCT o.objecttype_id,a.objecttypeattributeid
    FROM AV_EDM.AV_SYSTEM.assets_objects o JOIN AV_EDM.AV_SYSTEM.assets_objects_attributes a ON o.id = a.objectid
)
SELECT attr.id
        ,attr_type.objecttype_id
        ,attr.name
        ,attr.type
        ,attr.label
        ,attr.description
        ,attr.hidden
        ,attr.suffix
        ,attr.system
        ,attr.indexed
        ,attr.options
        ,attr.iql
        ,attr.qlquery
        ,attr.editable
        ,attr.globalId
        ,attr.position::INT as position
        ,attr.sortable
        ,attr.summable
        ,attr.removable
        ,attr.typevalue
        ,attr.defaulttype
        ,attr.workspaceId
        ,attr.referenceType
        ,attr.typevaluemulti
        ,attr.additionalvalue
        ,attr.regexvalidation
        ,attr.uniqueattribute
        ,attr.maximumcardinality
        ,attr.minimumcardinality
        ,attr.referenceObjectType
        ,attr.referenceObjectTypeId
        ,attr.includeChildObjectTypes
        ,attr._airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM objectschema_attr attr JOIN assets_type_attribute attr_type ON attr.id = attr_type.objecttypeattributeid
ORDER BY attr_type.objecttype_id,position