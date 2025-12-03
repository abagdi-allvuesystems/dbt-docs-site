
  create or replace   view AV_EDM.AV_STAGING.stg_sf_opportunity_contact_role
  
  
  
  
  as (
    WITH sf_opportunity_contact_mapping AS (
    SELECT
        opportunity_contact_map_id,
        opportunity_id,
        opportunity_name,
        opportunity_amount,
        opportunity_stage,
        opportunity_close_date,
        opportunity_is_won,
        opportunity_account_id,
        contact_id,
        contact_first_name,
        contact_last_name,
        contact_email,
        contact_phone,
        contact_account_id,
        account_name,
        account_industry,
        account_type,
        is_contact_related_to_opportunity,
        opportunity_created_date,
        contact_created_date
    FROM AV_EDM.AV_STAGING.stg_sf_opportunity_contact_mapping
),

-- Determine primary contact: earliest created contact for the account
primary_contact AS (
    SELECT
        opportunity_id,
        contact_id,
        ROW_NUMBER() OVER (
            PARTITION BY opportunity_id
            ORDER BY contact_created_date ASC
        ) AS contact_rank
    FROM sf_opportunity_contact_mapping
),

sf_opportunity_contact_role AS (
    SELECT
        ocm.*,
        pc.contact_rank,
        
        -- synthetic role assignment
        CASE
            WHEN pc.contact_rank = 1 THEN 'Primary Decision Maker'
            ELSE 'Influencer'
        END AS synthetic_role,

        -- primary contact flag
        CASE
            WHEN pc.contact_rank = 1 THEN TRUE
            ELSE FALSE
        END AS is_primary_contact

    FROM sf_opportunity_contact_mapping ocm
    LEFT JOIN primary_contact pc
        ON ocm.opportunity_id = pc.opportunity_id
        AND ocm.contact_id = pc.contact_id
)

SELECT
    -- synthetic ID for unique key
    CONCAT(opportunity_id, '-', contact_id) AS opportunity_contact_role_id,

    -- opportunity fields
    opportunity_id,
    opportunity_name,
    opportunity_amount,
    opportunity_stage,
    opportunity_close_date,
    opportunity_is_won,
    opportunity_account_id,

    -- contact fields
    contact_id,
    contact_first_name,
    contact_last_name,
    contact_email,
    contact_phone,
    contact_account_id,

    -- account fields
    account_name,
    account_industry,
    account_type,

    -- synthetic role information
    synthetic_role,
    is_primary_contact,

    -- metadata
    opportunity_created_date,
    contact_created_date

FROM sf_opportunity_contact_role ocr
WHERE is_contact_related_to_opportunity = TRUE
  );

