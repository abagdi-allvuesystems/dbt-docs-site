WITH sf_task AS (
    SELECT
        task_id,
        person_id AS contact_or_lead_id,
        related_object_id AS related_to_id,
        owner_id,
        subject,
        status,
        priority,
        activitydate,
        description,
        is_closed,
        created_at,
        last_modified_at
    FROM AV_EDM.AV_SYSTEM.sys_sf_task
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
)

SELECT
    t.task_id,
    t.subject,
    t.status,
    t.priority,
    t.activitydate,
    t.description,
    t.is_closed,
    t.created_at,
    t.last_modified_at,
    t.owner_id,
    t.contact_or_lead_id,
    t.related_to_id,

    -- Owner details
    u.user_name AS owner_name,
    u.user_email AS owner_email,
    u.user_username AS owner_username,

    -- Contact details (if WhoId refers to Contact)
    c.firstname AS contact_first_name,
    c.lastname AS contact_last_name,
    c.email AS contact_email,
    c.accountid AS contact_account_id,

    -- Lead details (if WhoId refers to Lead)
    l.first_name AS lead_first_name,
    l.last_name AS lead_last_name,
    l.email AS lead_email,
    l.company AS lead_company,
    l.lead_status

FROM sf_task t
LEFT JOIN sf_user u
    ON t.owner_id = u.user_id
LEFT JOIN sf_contact c
    ON t.contact_or_lead_id = c.contact_id
LEFT JOIN sf_lead l
    ON t.contact_or_lead_id = l.lead_id