WITH sf_event AS (
    SELECT
        id AS event_id,
        whoid AS contact_or_lead_id,
        whatid AS related_to_id,
        ownerid AS owner_id,
        location,
        activitydate AS event_date,
        startdatetime AS start_time,
        enddatetime AS end_time,
        isalldayevent,
        description,
        createddate AS created_at,
        lastmodifieddate AS last_modified_at,
        lastmodifiedbyid AS last_modified_by_id
    FROM AV_EDM.AV_SYSTEM.sys_sf_event
),

sf_user AS (
    SELECT
        id AS user_id,
        name AS user_name,
        email AS user_email,
        username AS user_username
    FROM AV_EDM.AV_SYSTEM.sys_sf_users
),

sf_contact AS (
    SELECT
        id AS contact_id,
        accountid,
        firstname,
        lastname,
        email
    FROM AV_EDM.AV_SYSTEM.sys_sf_contact
),

sf_lead AS (
    SELECT
        id AS lead_id,
        first_name,
        last_name,
        email,
        company,
        status AS lead_status
    FROM AV_EDM.AV_SYSTEM.sys_sf_lead
),

sf_account AS (
    SELECT
        id AS account_id,
        name AS account_name,
        type AS account_type,
        industry
    FROM AV_EDM.AV_SYSTEM.sys_sf_account
),

sf_opportunity AS (
    SELECT
        id AS opportunity_id,
        name AS opportunity_name,
        stage_name AS opportunity_stage,
        amount AS opportunity_amount,
        close_date
    FROM AV_EDM.AV_SYSTEM.sys_sf_opportunity
)

SELECT
    e.event_id,
    e.event_date,
    e.start_time,
    e.end_time,
    e.isalldayevent,
    e.location,
    e.description,
    e.owner_id,
    e.contact_or_lead_id,
    e.related_to_id,
    e.created_at,
    e.last_modified_at,
    e.last_modified_by_id,

    -- Owner enrichment
    u.user_name AS owner_name,
    u.user_email AS owner_email,
    u.user_username AS owner_username,

    -- Contact enrichment
    c.firstname AS contact_first_name,
    c.lastname AS contact_last_name,
    c.email AS contact_email,
    c.accountid AS contact_account_id,

    -- Lead enrichment
    l.first_name AS lead_first_name,
    l.last_name AS lead_last_name,
    l.email AS lead_email,
    l.company AS lead_company,
    l.lead_status,

    -- Account enrichment if WhatId refers to Account
    a.account_name,
    a.account_type,
    a.industry AS account_industry,

    -- Opportunity enrichment if WhatId refers to Opportunity
    o.opportunity_name,
    o.opportunity_stage,
    o.opportunity_amount,
    o.close_date AS opportunity_close_date

FROM sf_event e
LEFT JOIN sf_user u
    ON e.owner_id = u.user_id
LEFT JOIN sf_contact c
    ON e.contact_or_lead_id = c.contact_id
LEFT JOIN sf_lead l
    ON e.contact_or_lead_id = l.lead_id
LEFT JOIN sf_account a
    ON e.related_to_id = a.account_id
LEFT JOIN sf_opportunity o
    ON e.related_to_id = o.opportunity_id