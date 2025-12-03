
  create or replace   view AV_EDM.AV_STAGING.stg_sf_campaign_member
  
  
  
  
  as (
    WITH sf_campaign_member AS (
    SELECT
        id AS campaign_member_id,
        campaignid,
        leadid,
        contactid,
        status,
        hasresponded,
        createddate,
        lastmodifieddate,
        isdeleted
    FROM AV_EDM.AV_SYSTEM.sys_sf_campaignmember
),

sf_campaign AS (
    SELECT
        id AS campaign_id,
        name AS campaign_name,
        type AS campaign_type,
        status AS campaign_status,
        startdate,
        enddate,
        expectedrevenue,
        budgetedcost,
        actualcost
    FROM AV_EDM.AV_SYSTEM.sys_sf_campaign
),

sf_lead AS (
    SELECT
        id AS lead_id,
        first_name AS lead_first_name,
        last_name AS lead_last_name,
        email AS lead_email,
        company AS lead_company,
        lead_source AS lead_source,
        status AS lead_status
    FROM AV_EDM.AV_SYSTEM.sys_sf_lead
),

sf_contact AS (
    SELECT
        id AS contact_id,
        firstname AS contact_first_name,
        lastname AS contact_last_name,
        email AS contact_email,
        accountid AS contact_account_id
    FROM AV_EDM.AV_SYSTEM.sys_sf_contact
)

SELECT
    cm.campaign_member_id,

    -- campaign details
    cm.campaignid AS campaign_id,
    camp.campaign_name,
    camp.campaign_type,
    camp.campaign_status,
    camp.startdate AS campaign_start_date,
    camp.enddate AS campaign_end_date,
    camp.expectedrevenue AS campaign_expected_revenue,
    camp.budgetedcost AS campaign_budgeted_cost,
    camp.actualcost AS campaign_actual_cost,

    -- member information (lead or contact)
    cm.leadid,
    cm.contactid,

    lead.lead_first_name,
    lead.lead_last_name,
    lead.lead_email,

    contact.contact_first_name,
    contact.contact_last_name,
    contact.contact_email,
    contact.contact_account_id,

    -- member engagement
    cm.status AS member_status,
    cm.hasresponded AS has_responded,

    cm.createddate,
    cm.lastmodifieddate

FROM sf_campaign_member cm
LEFT JOIN sf_campaign camp
    ON cm.campaignid = camp.campaign_id
LEFT JOIN sf_lead lead
    ON cm.leadid = lead.lead_id
LEFT JOIN sf_contact contact
    ON cm.contactid = contact.contact_id

WHERE cm.isdeleted = FALSE
  );

