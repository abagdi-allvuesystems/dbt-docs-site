WITH ab_lit_employees AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_employees
)
SELECT id as id
    ,associateOID as associateOID
    ,workerid as workerid
    ,firstname as firstname
    ,lastname as lastname
    ,NickName as nickname
    ,email as email
    ,HireDate::DATE as HireDate
    ,TerminationDate::DATE as TerminationDate
    ,status as status
    ,workertype as workertype
    ,jobcode as jobcode
    ,jobtitle as jobtitle
    ,department as department
    ,functionalteam as functionalteam
    ,supervisoroid as supervisoroid
    ,supervisorid as supervisorid
    ,updatedate::TIMESTAMP_TZ as updatedate
    ,location as location
    ,_airbyte_extracted_at::TIMESTAMP_TZ as raw_updated
FROM ab_lit_employees