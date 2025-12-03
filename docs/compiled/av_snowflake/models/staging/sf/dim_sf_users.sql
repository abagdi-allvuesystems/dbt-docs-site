WITH dim_users AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_users
)
SELECT id as id
    ,name as name
    ,email as email
    ,title as title
    ,isactive AS isactive
    ,firstname as firstname
    ,lastname as lastname
    ,usertype as usertype
    ,username as username
    ,accountid as accountid
    ,managerid as managerid
    ,profileid as profileid
    ,department as department
    ,userroleid as userroleid
    ,createddate as createddate
    ,lastlogindate as lastlogindate
    ,systemmodstamp as systemmodstamp
    ,lastmodifiedbyid as lastmodifiedbyid
    ,lastmodifieddate as lastmodifieddate
    ,netsuite_id__c as netsuite_id
from dim_users