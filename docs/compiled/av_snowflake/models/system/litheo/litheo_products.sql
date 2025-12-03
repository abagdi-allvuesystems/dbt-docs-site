WITH ab_lit_products AS (
    SELECT * FROM AV_EDM.AV_SOURCE.ab_lit_products
)

SELECT 
         subproductid::FLOAT AS id 
        ,productfamilyid::FLOAT as productfamilyid
        ,productfamilyname::VARCHAR as productfamilyname
        ,productid::FLOAT as productid
        ,productname::VARCHAR as productname
        ,segmentid::FLOAT as segmentid
        ,segmentname::VARCHAR as segmentname
        ,subproductid::FLOAT as subproductid
        ,subproductname::VARCHAR as subproductname
        ,_airbyte_extracted_at::TIMESTAMP_TZ as raw_updated
        ,_airbyte_generation_id::NUMBER as airbyte_generation_id
        ,_airbyte_meta::VARIANT as airbyte_meta
        ,_airbyte_raw_id::VARCHAR as airbyte_raw_id
        --,_globalrownumber::FLOAT as global_row_number
        --,_rownumber_::FLOAT as row_number
        
FROM ab_lit_products