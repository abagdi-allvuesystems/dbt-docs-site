WITH litheo_emp as (
    SELECT * FROM AV_EDM.AV_SYSTEM.litheo_employees
)
SELECT associateOID as associate_OID
    ,workerid as worker_id
    ,firstname as first_name
    ,lastname as last_name
    ,nickname as nick_name
    ,email as email_address
    ,hiredate as hire_date
    ,terminationdate as termination_date
    ,status as status
    ,location as location
    ,workertype as worker_type
    ,jobcode as job_code
    ,jobtitle as job_title
    ,department as department
    ,functionalteam as functional_team
    ,supervisorid as supervisor_id
    ,supervisoroid as supervisor_oid
    ,updatedate as litheo_update_date
    ,raw_updated as raw_updated
FROM litheo_emp