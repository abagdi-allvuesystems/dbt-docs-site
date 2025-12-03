
  
    

create or replace transient table AV_EDM.AV_STAGING.dim_jira_epic_pi
    
    
    
    as (



WITH changelog AS (
    SELECT * 
    FROM 
        AV_EDM.AV_SYSTEM.jira_issue_changelog
    where 
        field_name IN ('Program Increment')
), jira_epic_pi_current AS (
    SELECT * 
    FROM 
        AV_EDM.AV_STAGING.dim_jira_epics
), jira_epic_pi_hist AS (
    SELECT 
         issue_id
        ,history_id
        ,field_name
        ,field_id
        ,ROW_NUMBER() OVER (PARTITION BY issue_id ORDER BY sys_created) AS row_number_asc
        ,LEAD(sys_created) OVER (PARTITION BY issue_id ORDER BY sys_created) AS lead
        ,LAG(sys_created) OVER (PARTITION BY issue_id ORDER BY sys_created) AS lag
        ,sys_created
        ,from_id
        ,to_id
        ,from_string
        ,to_string
    FROM 
        changelog c
), latest_change AS (
    SELECT issue_id,MAX(sys_created) as sys_created FROM changelog
    group by issue_id
), current_epic_pi_agg AS (
    SELECT
        e_pi.issue_id
        ,NULLIF(LISTAGG(pi.value:id,','),'') pi_ids
        ,NULLIF(LISTAGG(pi.value:value,','),'') pi_names

    FROM
        jira_epic_pi_current e_pi
        ,LATERAL FLATTEN(e_pi.program_increment,OUTER=>TRUE) pi
    GROUP BY
        e_pi.issue_id

), current_effective AS (
    SELECT
        e_pi.issue_id
        ,COALESCE(lc.sys_created,e_pi.sys_created) AS effective_date_start
        ,'9999-12-31'::TIMESTAMP_TZ AS effective_date_end
        ,pi_ids
        ,pi_names

    FROM
        jira_epic_pi_current e_pi
    JOIN
        current_epic_pi_agg agg ON agg.issue_id = e_pi.issue_id
    LEFT JOIN
        latest_change lc ON lc.issue_id = e_pi.issue_id

), hist_epic_pi_agg AS (
    SELECT 
        e_pi.issue_id
        ,e_pi.history_id
        ,REGEXP_REPLACE(e_pi.from_id,'\\[*\\]*','') AS pi_ids
        ,e_pi.from_string AS pi_names

    FROM
        jira_epic_pi_hist e_pi
        
), hist_effective AS (
    SELECT 
        e_pi.issue_id
        ,COALESCE(e_pi.lag,c.sys_created) AS effective_date_start
        ,e_pi.sys_created::TIMESTAMP_TZ AS effective_date_end
        ,pi_ids
        ,pi_names

    FROM
        jira_epic_pi_hist e_pi
    JOIN
        hist_epic_pi_agg agg ON agg.issue_id = e_pi.issue_id AND agg.history_id = e_pi.history_id
    LEFT JOIN
        jira_epic_pi_current c on e_pi.issue_id = c.issue_id
)

SELECT 
        issue_id
        ,effective_date_start
        ,effective_date_end
        ,pi_ids
        ,pi_names

FROM 
        current_effective

UNION

SELECT
        issue_id
        ,effective_date_start
        ,effective_date_end
        ,pi_ids
        ,pi_names

FROM 
        hist_effective
    )
;


  