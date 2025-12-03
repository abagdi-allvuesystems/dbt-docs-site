
  create or replace   view AV_EDM.AV.confluence_spaces
  
  
  
  
  as (
    WITH spaces AS (
    SELECT * FROM AV_EDM.AV_STAGING.stg_confluence_spaces
)
SELECT 
       space_id as space_id
       ,space_name as space_name
       ,space_key as space_key
       ,current_active_alias as current_active_alias
       ,home_page_id as home_page_id
       ,space_owner_id as space_owner_id
       ,author_Id as author_Id
       ,created_date AS created_date
       ,status as status
       ,type as type
       
FROM spaces
  );

