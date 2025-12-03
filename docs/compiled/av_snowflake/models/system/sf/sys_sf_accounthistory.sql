WITH raw_acct_history AS (
    SELECT * FROM AV_EDM.AV_SOURCE.src_ab_sf_accounthistory
)
select id AS id
    ,field AS field
    ,datatype AS datatype
    ,newvalue AS new_value
    ,oldvalue AS old_value
    ,accountid AS account_id
    ,isdeleted::BOOLEAN AS is_deleted
    ,createdbyid AS created_by_id
    ,createddate::TIMESTAMP_TZ AS created_date
    ,_airbyte_extracted_at::TIMESTAMP_TZ AS raw_updated
FROM raw_acct_history