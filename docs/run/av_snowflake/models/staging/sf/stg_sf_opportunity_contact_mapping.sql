
  create or replace   view AV_EDM.AV_STAGING.stg_sf_opportunity_contact_mapping
  
  
  
  
  as (
    WITH sf_opportunity AS (
    SELECT
        id AS opportunity_id,
        name AS opportunity_name,
        account_id AS opportunity_account_id,
        amount,
        close_date,
        stage_name,
        iswon,
        owner_id,
        created_at,
        last_modified_at
    FROM AV_EDM.AV_SYSTEM.sys_sf_opportunity
),

sf_contact AS (
    SELECT
        id AS contact_id,
        firstname AS contact_first_name,
        lastname AS contact_last_name,
        email AS contact_email,
        phone AS contact_phone,
        accountid AS contact_account_id,
        createddate AS contact_created_date
    FROM AV_EDM.AV_SYSTEM.sys_sf_contact
),

sf_account AS (
    SELECT
        id AS account_id,
        name AS account_name,
        industry,
        type AS account_type,
        ownerid AS account_owner_id
    FROM AV_EDM.AV_SYSTEM.sys_sf_account
)

SELECT
    -- synthetic relationship id
    CONCAT(
        opp.opportunity_id, '-', contact.contact_id
    ) AS opportunity_contact_map_id,

    -- opportunity data
    opp.opportunity_id,
    opp.opportunity_name,
    opp.amount AS opportunity_amount,
    opp.stage_name AS opportunity_stage,
    opp.close_date AS opportunity_close_date,
    opp.iswon AS opportunity_is_won,
    opp.opportunity_account_id,

    -- contact data
    contact.contact_id,
    contact.contact_first_name,
    contact.contact_last_name,
    contact.contact_email,
    contact.contact_phone,
    contact.contact_account_id,

    -- account data
    acct.account_name,
    acct.industry AS account_industry,
    acct.account_type,

    -- derived fields
    CASE
        WHEN contact.contact_account_id = opp.opportunity_account_id THEN TRUE
        ELSE FALSE
    END AS is_contact_related_to_opportunity,

    -- timestamps
    opp.created_at AS opportunity_created_date,
    contact.contact_created_date

FROM sf_opportunity opp
LEFT JOIN sf_contact contact
    ON contact.contact_account_id = opp.opportunity_account_id
LEFT JOIN sf_account acct
    ON opp.opportunity_account_id = acct.account_id

-- only valid matches
WHERE contact.contact_id IS NOT NULL
  );

