WITH lit_tandc AS (
    SELECT * FROM AV_EDM.AV_STAGING.dim_litheo_elixir_temp_tandc
)

SELECT 

    Charge_Date
    ,Charge_Internal_ID
    ,Charge_Total
    ,Charge_Total_USD
    ,Client
    ,Client_Internal_ID
    ,Created
    ,Currency
    ,Hourly_Rate
    ,Hourly_Rate_USD
    ,Hours
    ,Month
    ,Project
    ,Project_Delivery_Lead
    ,Project_Internal_ID
    ,Project_Owner
    ,Project_Segment
    ,Project_Stage
    ,Project_Type
    ,Record_Source
    ,Revenue_Category
    ,Revenue_Group
    ,TASK
    ,Task_Internal_ID
    ,Task_Type
    ,Time_Entry_Date
    ,Time_Entry_Notes
    ,Time_Entry_Internal_ID
    ,Update_Date
    ,Updated
    ,User_Current_Target
    ,User_Delivery_Vertical
    ,User_Department
    ,User_Functional_Team
    ,User_Internal_ID
    ,User_Manager
    ,User_Name
    ,User_PS_Start
    ,User_PS_Term
    ,User_Region
    ,User_Team
    ,User_Timesheet_Required
    ,User_Utilization_Category
    ,Week
    ,Year

FROM lit_tandc WHERE Deleted != '1' OR Deleted IS NULL