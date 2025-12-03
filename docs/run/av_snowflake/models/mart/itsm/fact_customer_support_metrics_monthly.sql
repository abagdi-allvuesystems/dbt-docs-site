
  
    

create or replace transient table AV_EDM.AV_ITSM.fact_customer_support_metrics_monthly
    
    
    
    as (WITH fact_ticket_backlog AS (
    SELECT * FROM AV_EDM.AV_ITSM.fact_customer_ticket_backlog
), core_cust AS (
    SELECT * FROM AV_EDM.AV_CORE.customer
), jira_org_map AS (
    SELECT * FROM AV_EDM.AV_ITSM.jira_organization_mapping
), cust_tickets AS (
    SELECT * FROM AV_EDM.AV_ITSM.customer_tickets
), cust_tickets_cust AS (
    SELECT * FROM AV_EDM.AV_ITSM.customer_tickets_customers
), dim_date AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_date
), flat AS (
    select d.date
        ,d.first_date_of_month
        ,ct.derived_ticket_type
        ,jom.assets_salesforce_account_id
        ,ftb.is_closed
        ,ftb.is_opened
        ,ftb.issue_id
        ,ct.time_to_resolution_elapsed_days
        ,ct.time_to_close_days
        ,ct.priority
    from dim_date d JOIN fact_ticket_backlog ftb on d.date = ftb.date
                    LEFT JOIN cust_tickets ct on ftb.issue_id = ct.issue_id
                    LEFT JOIN cust_tickets_cust ctc on ct.issue_id = ctc.issue_id
                    LEFT JOIN jira_org_map jom on ctc.customer_field_id = jom.jira_customer_field_id
    where ct.is_client_reportable_ticket = 'true' AND jom.assets_salesforce_account_id is not null
), closed AS (
    select first_date_of_month
        ,derived_ticket_type
        ,assets_salesforce_account_id
        ,COUNT(issue_id) as count_closed_issues
        ,AVG(time_to_resolution_elapsed_days)::DECIMAL(10,2) as mttr
        ,AVG(time_to_close_days)::DECIMAL(10,2) as mttc
        ,SUM(CASE WHEN priority = 'Critical' THEN 1 ELSE 0 END)::INT AS count_critical_issues
    from flat
    where is_closed = true
    group by first_date_of_month
        ,derived_ticket_type
        ,assets_salesforce_account_id
), opened AS (
    select first_date_of_month
        ,derived_ticket_type
        ,assets_salesforce_account_id
        ,COUNT(issue_id) as count_opened_issues
    from flat
    where is_opened = true
    group by first_date_of_month
        ,derived_ticket_type
        ,assets_salesforce_account_id
), backlog AS (
        select first_date_of_month
        ,derived_ticket_type
        ,assets_salesforce_account_id
        ,COUNT(issue_id) as count_backlog_issues
    from flat
    where is_opened != true and date = first_date_of_month
    group by first_date_of_month
        ,derived_ticket_type
        ,assets_salesforce_account_id
), dist_month_type AS (
    select distinct first_date_of_month
                ,derived_ticket_type
    from closed
), fact as (
    select dmt.first_date_of_month as date
        ,dmt.derived_ticket_type
        ,cc.sf_account_id
    from dist_month_type dmt JOIN core_cust cc on 1=1
)
select f.sf_account_id
        ,f.date
        ,f.derived_ticket_type
        ,IFNULL(b.count_backlog_issues,0) as count_backlog_issues
        ,IFNULL(o.count_opened_issues,0) as count_opened_issues
        ,IFNULL(c.count_closed_issues,0) as count_closed_issues
        ,c.mttr
        ,c.mttc
        ,IFNULL(c.count_critical_issues,0) as count_critical_issues
from fact f LEFT JOIN closed c on f.date = c.first_date_of_month AND f.derived_ticket_type = c.derived_ticket_type AND f.sf_account_id = c.assets_salesforce_account_id
            LEFT JOIN opened o on f.date = o.first_date_of_month AND f.derived_ticket_type = o.derived_ticket_type AND f.sf_account_id = o.assets_salesforce_account_id
            LEFT JOIN backlog b on f.date = b.first_date_of_month AND f.derived_ticket_type = b.derived_ticket_type AND f.sf_account_id = b.assets_salesforce_account_id
    )
;


  