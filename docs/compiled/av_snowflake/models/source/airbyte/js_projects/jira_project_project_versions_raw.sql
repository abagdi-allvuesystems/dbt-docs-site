WITH acc_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_acc_project_versions
), arch_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_arch_project_versions
), crm_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_crm_project_versions
), dba_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_dba_project_versions
), ece_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_ece_project_versions
), fod_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_fod_project_versions
), fosho_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_fosho_project_versions
), fppm_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_fppm_project_versions
), lppm_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_lppm_project_versions
), lppmd_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_lppmd_project_versions
), party_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_party_project_versions
), pie_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_pie_project_versions
), plat_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_plat_project_versions
), snow_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_snow_project_versions
), spp_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_spp_project_versions
), tse_project_versions as (
    select * from AV_EDM.AV_SOURCE.ab_jira_tse_project_versions
)
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from acc_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from arch_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from crm_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from dba_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from ece_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from fod_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from fosho_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from fppm_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from lppm_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from lppmd_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from party_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from pie_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from plat_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from snow_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from spp_project_versions
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,name
    ,self
    ,expand
    ,overdue
    ,project
    ,archived
    ,released
    ,projectid
    ,startdate
    ,operations
    ,description
    ,releasedate
    ,userstartdate
    ,userreleasedate
    ,moveunfixedissuesto
    ,issuesstatusforfixversion
from tse_project_versions