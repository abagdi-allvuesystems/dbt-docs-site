
  create or replace   view AV_EDM.AV_STAGING.stg_sf_quote
  
  
  
  
  as (
    WITH sf_quote AS (
    SELECT
        quote_id,
        quote_name,
        account_id,
        opportunity_id,
        status,
        expiration_date,
        pricebook_id,
        billing_city,
        billing_country,
        billing_postal_code,
        billing_state,
        shipping_city,
        shipping_country,
        shipping_postal_code,
        shipping_state,
        created_at,
        last_modified_at
    FROM AV_EDM.AV_SYSTEM.sys_sf_quote
),

sf_opportunity AS (
    SELECT
        id AS opportunity_id,
        account_id,
        owner_id,
        name AS opportunity_name,
        amount,
        stage_name,
        iswon,
        isclosed,
        type,
        close_date,
        created_at
    FROM AV_EDM.AV_SYSTEM.sys_sf_opportunity
),

sf_account AS (
    SELECT
        id AS account_id,
        name AS account_name,
        type AS account_type,
        industry
    FROM AV_EDM.AV_SYSTEM.sys_sf_account
)

SELECT
    q.quote_id,
    q.quote_name,
    q.account_id,
    q.opportunity_id,
    q.status AS quote_status,
    q.expiration_date,
    q.pricebook_id,
    q.billing_city,
    q.billing_country,
    q.billing_postal_code,
    q.billing_state,
    q.shipping_city,
    q.shipping_country,
    q.shipping_postal_code,
    q.shipping_state,
    q.created_at,
    q.last_modified_at,

    -- Opportunity enriched
    o.opportunity_name,
    o.amount AS opportunity_amount,
    o.stage_name,
    o.iswon,
    o.isclosed,
    o.type AS opportunity_type,
    o.close_date AS opportunity_close_date,

    -- Account enriched
    a.account_name,
    a.account_type,
    a.industry AS account_industry

FROM sf_quote q
LEFT JOIN sf_opportunity o
    ON q.opportunity_id = o.opportunity_id
LEFT JOIN sf_account a
    ON q.account_id = a.account_id
  );

