WITH raw_jsm_orgs AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_jsm_organizations
)
select id::INT AS id
    ,name as name
    ,created as created
    ,_airbyte_extracted_at::TIMESTAMP_TZ as raw_updated
from raw_jsm_orgs