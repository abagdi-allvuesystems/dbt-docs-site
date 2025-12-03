WITH source_lead AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_lead
)

SELECT
    -- Primary Key
    id AS id,

    -- Core Lead Fields
    name::varchar AS name,
    company::varchar AS company,
    email::varchar AS email,
    phone::varchar AS phone,
    mobilephone::varchar AS mobile_phone,
    fax::varchar AS fax,
    website::varchar AS website,
    industry::varchar AS industry,
    rating::varchar AS rating,
    leadsource::varchar AS lead_source,
    status::varchar AS status,
    ownerid::varchar AS owner_id,
    title::varchar AS title,
    description::text AS description,

    -- Location Fields
    street::varchar AS street,
    city::varchar AS city,
    state::varchar AS state,
    postalcode::varchar AS postal_code,
    country::varchar AS country,

    -- Person Fields
    salutation::varchar AS salutation,
    firstname::varchar AS first_name,
    middlename::varchar AS middle_name,
    lastname::varchar AS last_name,
    suffix::varchar AS suffix,

    -- Business Attributes
    numberofemployees::integer AS number_of_employees,
    annualrevenue::numeric AS annual_revenue,

    -- Conversion Fields
    isconverted::boolean AS is_converted,
    converteddate::timestamp_tz AS converted_date,
    convertedaccountid::varchar AS converted_account_id,
    convertedcontactid::varchar AS converted_contact_id,
    convertedopportunityid::varchar AS converted_opportunity_id,

    -- Audit Fields
    createddate::timestamp_tz AS created_at,
    lastmodifieddate::timestamp_tz AS last_modified_at,
    lastactivitydate::date AS last_activity_date,
    createdbyid::varchar AS created_by_id,
    lastmodifiedbyid::varchar AS last_modified_by_id,
    isdeleted::boolean AS is_deleted,
    systemmodstamp::timestamp_tz AS system_modstamp,

    -- Airbyte Metadata
    _airbyte_extracted_at::timestamp_tz AS raw_updated

FROM source_lead