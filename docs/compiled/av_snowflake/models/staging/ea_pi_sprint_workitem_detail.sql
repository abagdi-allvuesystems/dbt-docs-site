WITH sprint_workitem AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_jira_sprint_workitems
), corp_pi AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.corp_pi
), corp_sprint AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.corp_sprint
), team_sprint AS (
    SELECT * FROM AV_EDM.AV_ENG_ANALYTICS.team_sprint
    WHERE agile_team_id IS NOT NULL
), first_team_sprint_of_pi AS (
    SELECT ts.id
            ,pi.id AS corp_pi_id
            ,ts.agile_team_id AS agile_team_id
            ,ts.start_date AS start_date
            ,ts.end_date AS end_date
            ,cs.id AS corp_sprint_id
    FROM team_sprint ts JOIN corp_sprint cs ON ts.corp_sprint_id = cs.id
                        JOIN corp_pi pi ON cs.corp_pi_id = pi.id
    where cs.pi_sprint_number = 1
)
SELECT 
        pi.id AS corp_pi_id
        ,cs.id AS corp_sprint_id
        ,sw.sprint_id AS jira_sprint_id
        ,sw.issue_id AS jira_issue_id
        ,sw.effective_date_start AS sprint_workitem_effective_date_start
        ,sw.effective_date_end AS sprint_workitem_effective_date_end
        ,pi.start_date AS pi_start_date
        ,pi.end_date AS pi_end_date
        ,fts.start_date AS first_team_sprint_start_date
        ,ts.start_date AS team_sprint_start_date
        ,CASE WHEN pi.start_date BETWEEN sw.effective_date_start AND sw.effective_date_end THEN 1 ELSE 0 END AS existed_at_pi_start
        ,CASE WHEN fts.start_date BETWEEN sw.effective_date_start AND sw.effective_date_end THEN 1 ELSE 0 END AS existed_at_pi_start_ts
        ,CASE WHEN ts.start_date BETWEEN sw.effective_date_start AND sw.effective_date_end THEN 1 ELSE 0 END AS accepted_into_sprint_derived
        ,CASE WHEN pi.start_date < sw.effective_date_end AND pi.end_date > sw.effective_date_start THEN 1 ELSE 0 END AS existed_in_pi_window_pi_start
        ,CASE WHEN fts.start_date < sw.effective_date_end AND pi.end_date > sw.effective_date_start THEN 1 ELSE 0 END AS existed_in_pi_window_team_sprint_start

FROM 
        sprint_workitem sw 
JOIN 
        team_sprint ts ON sw.sprint_id = ts.id
JOIN 
        corp_sprint cs ON ts.corp_sprint_id = cs.id
JOIN 
        corp_pi pi ON cs.corp_pi_id = pi.id
LEFT JOIN 
        first_team_sprint_of_pi fts ON pi.id = fts.corp_pi_id AND ts.agile_team_id = fts.agile_team_id