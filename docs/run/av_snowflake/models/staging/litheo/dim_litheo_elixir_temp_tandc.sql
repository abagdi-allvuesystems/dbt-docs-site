
  create or replace   view AV_EDM.AV_STAGING.dim_litheo_elixir_temp_tandc
  
  
  
  
  as (
    WITH lit_tandc AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.litheo_elixir_time_and_charges
)

SELECT

    TASK
    ,Week
    ,Year
	,Hours
	,Month
	,Client
	,Created
	,Project
	,Updated
	,Currency
	,Task_Type
	,User_Name
	,User_Team
	,Charge_Date
	,Hourly_Rate
	,Update_Date
	,User_PS_Term
	,User_Region
	,Charge_Total
	,Project_Type
	,User_Manager
	,User_PS_Start
	,Project_Owner
	,Project_Stage
	,Record_Source
	,Revenue_Group
	,Task_EAC_Hours
	,Hourly_Rate_USD
	,Time_Entry_Date
	,Charge_Total_USD
	,Project_Segment
	,Task_Internal_ID
	,Task_Scope_Hours
	,Time_Entry_Notes
	,User_Department
	,User_Internal_ID
	,Revenue_Category
	,Charge_Internal_ID
	,Client_Internal_ID
	,Project_Internal_ID
	,User_Current_Target
	,User_Functional_Team
	,Project_Delivery_Lead
	,Time_Entry_Internal_ID
	,User_Delivery_Vertical
	,User_Timesheet_Required
	,User_Utilization_Category
    ,Deleted

FROM lit_tandc
  );

