WITH sf_opportunity AS (
    SELECT
        id AS opportunity_id,
        account_id,
        owner_id,
        name AS opportunity_name,
        amount,
        stage_name,
        iswON,
        isclosed,
        type,
        close_date,
        created_at
    FROM AV_EDM.AV_SYSTEM.sys_sf_opportunity
),

sf_opportunityproduct AS (
    SELECT *
    FROM AV_EDM.AV_SYSTEM.sys_sf_opportunityproduct
),

sf_product AS (
    SELECT *
    FROM AV_EDM.AV_SYSTEM.sys_sf_product2
)

SELECT
    o.opportunity_id,
    o.opportunity_name,
    o.account_id,
    o.owner_id,
    o.amount AS opportunity_amount,
    o.stage_name,
    o.iswon,
    o.isclosed,
    o.type,
    o.close_date,
    o.created_at,

    -- Line Item data
    op.id as opportunity_product_id,
    op.quantity,
    op.unit_price,
    op.list_price,
    op.discount,
    op.total_price,

    -- Product data
    p.id as product_id,
    p.name as product_name,
    p.family as product_family,
    p.pricing_category__c AS pricing_category

FROM sf_opportunity o
left join sf_opportunityproduct op
    ON o.opportunity_id = op.opportunity_id
left join sf_product p
    ON op.product_id = p.id