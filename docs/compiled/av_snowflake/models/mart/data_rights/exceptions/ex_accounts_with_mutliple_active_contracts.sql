WITH customer_contracts AS (
    SELECT * FROM AV_EDM.AV_DATA_RIGHTS.customer_contracts
)
SELECT SF_ACCOUNT_ID
    ,COUNT(msa_contract_id) as Count_MSA
FROM customer_contracts
GROUP BY SF_ACCOUNT_ID