
  
    

create or replace transient table AV_EDM.AV_SOURCE.jira_project_issues_raw
    
    
    
    as (
WITH acc_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_acc_issues
), arch_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_arch_issues
), crm_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_crm_issues
), dba_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_dba_issues
), ece_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_ece_issues
), fod_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_fod_issues
), fosho_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_fosho_issues
), fppm_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_fppm_issues
), lppm_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_lppm_issues
), lppmd_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_lppmd_issues
), party_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_party_issues
), pie_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_pie_issues
), plat_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_plat_issues
), snow_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_snow_issues
), spp_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_spp_issues
), tse_issues as (
    select * from AV_EDM.AV_SOURCE.ab_jira_tse_issues
), rd_issues AS (
    select * from AV_EDM.AV_SOURCE.ab_jira_rd_issues
), eim_issues AS (
    select * from AV_EDM.AV_SOURCE.ab_jira_eim_issues
), da_issues AS (
    select * from AV_EDM.AV_SOURCE.ab_jira_da_issues
), ac_issues AS (
    select * from AV_EDM.AV_SOURCE.ab_jira_ac_issues
), sre_issues AS (
    select * from AV_EDM.AV_SOURCE.ab_jira_sre_issues
), hs_issues AS (
    select * from AV_EDM.AV_SOURCE.ab_jira_hs_issues
)
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from acc_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from arch_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from crm_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from dba_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from ece_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from fod_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from fosho_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from fppm_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from lppm_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from lppmd_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from party_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from pie_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from plat_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from snow_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from spp_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from tse_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from rd_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from eim_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from da_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from ac_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from sre_issues
UNION
select _airbyte_raw_id
    ,_airbyte_extracted_at
    ,_airbyte_meta
    ,_airbyte_generation_id
    ,id
    ,key
    ,self
    ,names
    ,expand
    ,fields
    ,schema
    ,created
    ,updated
    ,editmeta
    ,changelog
    ,projectid
    ,operations
    ,projectkey
    ,properties
    ,transitions
    ,renderedfields
    ,fieldstoinclude
    ,versionedrepresentations
from hs_issues
    )
;


  