with source_oppportunity as (
    select * from AV_EDM.AV_SOURCE.src_ab_sf_opportunity
)

select
    -- Primary Keys
    id,
    accountid as account_id,
    ownerid as owner_id,
    contactid as contact_id,
    campaignid as campaign_id,
    pricebook2id as pricebook_id,
    recordtypeid as record_type_id,

    -- Core Fields
    name,
    type,
    stagename as stage_name,
    iswon,
    isclosed,
    isdeleted,
    amount,
    probability,
    expectedrevenue as expected_revenue,
    leadsource as lead_source,
    closedate as close_date,
    createddate as created_at,
    lastmodifieddate as last_modified_at,
    lastactivitydate as last_activity_date,
    fiscalquarter as fiscal_quarter,
    fiscalyear as fiscal_year,
    description,

    -- ARR fields (very commonly used)
    arr__c as arr,
    ssp_arr__c as ssp_arr,
    active_arr__c as active_arr,
    qs_order_sub_type__c as qs_order_sub_type,
    contract_term__c as contract_term,
    exclude_from_hitting_bookings_target__c as exclude_from_hitting_bookings_target,
    sales_bookings_type__c as sales_bookings_type,
    total_contract_value__c as total_contract_value,
    sales_vp_forecast_category__c as sales_vp_forecast_category,
    sales_vertical__c as sales_vertical,
    sales_vp_arr__c as sales_vp_arr,
    uplift_arr__c as uplift_arr,
    average_arr__c as average_arr,
    new_contract_arr__c as new_contract_arr,
    ending_contract_arr__c as ending_contract_arr,

    -- Forecasting
    forecastcategory as forecast_category,
    forecastcategoryname as forecast_category_name,
    opp_forecasting_color__c as opp_forecasting_color,
    opportunity_status__c as opportunity_status,

    -- Health score fields
    opp_health_color__c as opp_health_color,
    map_health_score__c as map_health_score,
    redlines_health_score__c as redlines_health_score,
    infosec_health_score__c as infosec_health_score,
    scoping_health_score__c as scoping_health_score,
    forecast_confidence_health_score__c as forecast_confidence_health_score,

    -- Region/Segment
    region__c as region,
    segment__c as segment,
    sub_team__c as sub_team,
    market_segment__c as market_segment,

    -- Dates
    sal_date__c as sal_date,
    sql_date__c as sql_date,
    ss2_date__c as ss2_date,
    ss3_date__c as ss3_date,
    ss4_date__c as ss4_date,
    ss5_date__c as ss5_date,
    ss6_date__c as ss6_date,

    -- Winning/Losing
    loss_reason__c as loss_reason,
    win_loss_comments__c as win_loss_comments,

    -- Custom Business Logic Flags
    x1st_deal__c as is_first_deal,
    x2nd_deal__c as is_second_deal,
    at_risk__c as is_at_risk,
    selected_vendor__c as is_selected_vendor,

    -- Airbyte Metadata
    _airbyte_extracted_at as extracted_at
from source_oppportunity