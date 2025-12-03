WITH cust AS (
    SELECT * FROM AV_EDM.AV_CORE.customer
), dim_sf_customers AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_sf_customers
), cust_timeline AS (
    SELECT * FROM AV_EDM.AV_CORE.customer_timeline
), current_year_forecast AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_sf_account__current_year_risk_forecast
), next_year_forecast AS (
    SELECT * FROM AV_EDM.AV_STAGING.dimh_sf_account__next_year_risk_forecast
), date_dim AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date where date >= '1/1/2023' and date <= CURRENT_TIMESTAMP()
), cust_monthly AS (
    select distinct date_dim.first_date_of_month
        ,date_dim.last_date_of_month
        ,cust.sf_account_id
    from date_dim FULL OUTER JOIN cust on 1=1
), nps_surveys AS (
    select * from AV_EDM.AV_STAGING.dim_sf_nps_surveys
)
select cm.first_date_of_month
    ,cm.last_date_of_month
    ,cm.sf_account_id
    ,COUNT(ns.survey_response_id) as count_total_surveys
    ,AVG(how_likely_to_recommend_allvue) as average_recommendation_score
    ,SUM(count_promotor) AS count_promotor
    ,SUM(count_passive) as count_passive
    ,SUM(count_detractor) as count_detractor
from cust_monthly cm LEFT join nps_surveys ns on cm.sf_account_id = ns.account_id and ns.completion_date >= cm.first_date_of_month and ns.completion_date <= cm.last_date_of_month
where ns.survey_response_id is not null
group by cm.first_date_of_month
    ,cm.last_date_of_month
    ,cm.sf_account_id