
  
    

create or replace transient table AV_EDM.AV_STAGING.dim_date
    
    
    
    as (

WITH date_spine AS (
  





with rawdata as (

    

    

    with p as (
        select 0 as generated_number union all select 1
    ), unioned as (

    select

    
    p0.generated_number * power(2, 0)
     + 
    
    p1.generated_number * power(2, 1)
     + 
    
    p2.generated_number * power(2, 2)
     + 
    
    p3.generated_number * power(2, 3)
     + 
    
    p4.generated_number * power(2, 4)
     + 
    
    p5.generated_number * power(2, 5)
     + 
    
    p6.generated_number * power(2, 6)
     + 
    
    p7.generated_number * power(2, 7)
     + 
    
    p8.generated_number * power(2, 8)
     + 
    
    p9.generated_number * power(2, 9)
     + 
    
    p10.generated_number * power(2, 10)
     + 
    
    p11.generated_number * power(2, 11)
     + 
    
    p12.generated_number * power(2, 12)
     + 
    
    p13.generated_number * power(2, 13)
     + 
    
    p14.generated_number * power(2, 14)
    
    
    + 1
    as generated_number

    from

    
    p as p0
     cross join 
    
    p as p1
     cross join 
    
    p as p2
     cross join 
    
    p as p3
     cross join 
    
    p as p4
     cross join 
    
    p as p5
     cross join 
    
    p as p6
     cross join 
    
    p as p7
     cross join 
    
    p as p8
     cross join 
    
    p as p9
     cross join 
    
    p as p10
     cross join 
    
    p as p11
     cross join 
    
    p as p12
     cross join 
    
    p as p13
     cross join 
    
    p as p14
    
    

    )

    select *
    from unioned
    where generated_number <= 18597
    order by generated_number



),

all_periods as (

    select (
        

    dateadd(
        day,
        row_number() over (order by generated_number) - 1,
        to_date('01/01/2000', 'mm/dd/yyyy')
        )


    ) as date_day
    from rawdata

),

filtered as (

    select *
    from all_periods
    where date_day <= to_date('12/01/2050', 'mm/dd/yyyy')

)

select * from filtered


),
current_date_info AS (
    SELECT
        CURRENT_DATE AS current_date,
        DATE_TRUNC('QUARTER', CURRENT_DATE) AS current_quarter_start,
        DATE_TRUNC('QUARTER', DATEADD(QUARTER, -1, CURRENT_DATE)) AS last_quarter_start
),
past_quarters AS (
    SELECT
        DATE_TRUNC('QUARTER', DATE_DAY) AS quarter_start,
        DENSE_RANK() OVER (ORDER BY DATE_TRUNC('QUARTER', DATE_DAY) DESC) AS past_rank_quarter
    FROM date_spine
    WHERE DATE_DAY < (SELECT current_quarter_start FROM current_date_info)
    GROUP BY quarter_start
)

SELECT
    DATE_DAY AS date,
    DATE_PART(DAY, DATE_DAY) AS day,
    DAYNAME(DATE_DAY) AS day_name_abr,
    DECODE(EXTRACT(dayofweek FROM DATE_DAY),
        1, 'Monday',
        2, 'Tuesday',
        3, 'Wednesday',
        4, 'Thursday',
        5, 'Friday',
        6, 'Saturday',
        0, 'Sunday') AS day_name,
    WEEK(DATE_DAY) AS week_of_year,
    WEEKISO(DATE_DAY) AS week_of_year_iso,
    DAYOFWEEK(DATE_DAY) AS day_of_week,
    DAYOFWEEKISO(DATE_DAY) AS day_of_week_iso,
    MONTH(DATE_DAY) AS month_num,
    MONTHNAME(DATE_DAY) AS month_name_abr,
    DECODE(EXTRACT(month FROM DATE_DAY),
        1, 'January',
        2, 'February',
        3, 'March',
        4, 'April',
        5, 'May',
        6, 'June',
        7, 'July',
        8, 'August',
        9, 'September',
        10, 'October',
        11, 'November',
        12, 'December') AS the_month_name,
    QUARTER(DATE_DAY) AS quarter_num,
    CONCAT('Q', QUARTER(DATE_DAY)::VARCHAR) AS quarter_name_abv,
    YEAR(DATE_DAY) AS the_year,
    TO_CHAR(DATE_DAY, 'YYYY') || '-Q' || TO_CHAR(QUARTER(DATE_DAY)) AS year_quarter,
    TO_CHAR(DATE_DAY, 'YYYY-MM') AS year_month_number,
    DATE_TRUNC('MONTH', DATE_DAY) AS first_date_of_month,
    LAST_DAY(DATE_DAY) AS last_date_of_month,
    DATE_PART('DOY', DATE_DAY) AS day_of_year,
    CASE
        WHEN DAYOFWEEK(DATE_DAY) IN (6, 0) THEN 'Weekend'
        ELSE 'Weekday'
        END AS weekend_flag,
    CASE
        WHEN DAYOFWEEK(DATE_DAY) IN (6, 0) THEN TRUE
        ELSE FALSE
    END AS is_weekend,
    CASE
        WHEN DAYOFWEEK(DATE_DAY) IN (6, 0) THEN FALSE
        ELSE TRUE
    END AS is_weekday,
    DATE_TRUNC('QUARTER', DATE_DAY) AS first_date_of_quarter,
    LAST_DAY(DATE_TRUNC('QUARTER', DATE_DAY), 'QUARTER') AS last_date_of_quarter,
    DATE_DAY::DATETIME AS first_datetime_of_day,
    DATEADD(SECOND, -1, DATEADD(DAY, 1, DATE_DAY)) AS last_datetime_of_day,
    CASE
        WHEN DAYOFWEEK(DATE_DAY) = 0 THEN TRUE
        ELSE FALSE
    END AS is_first_day_of_week,
    CASE
        WHEN DAYOFWEEK(DATE_DAY) = 6 THEN TRUE
        ELSE FALSE
    END AS is_last_day_of_week,
    CASE
        WHEN DAYOFWEEK(DATE_DAY) = 1 THEN TRUE
        ELSE FALSE
    END AS is_first_day_of_week_iso,
    CASE
        WHEN DAYOFWEEK(DATE_DAY) = 7 THEN TRUE
        ELSE FALSE
    END AS is_last_day_of_week_iso,
    CASE
        WHEN DATE_PART('DAY', DATE_DAY) = 1 THEN TRUE
        ELSE FALSE
    END AS is_first_day_of_month,
    CASE
        WHEN DATE_DAY = LAST_DAY(DATE_DAY) THEN TRUE
        ELSE FALSE
    END AS is_last_day_of_month,
    CASE
        WHEN DATE_PART('DAY', DATE_DAY) = 1 AND DATE_PART('MONTH', DATE_DAY) IN (1, 4, 7, 10) THEN TRUE
        ELSE FALSE
    END AS is_first_day_of_quarter,
    CASE
        WHEN DATE_DAY = LAST_DAY(DATE_TRUNC('QUARTER', DATE_DAY), 'QUARTER') THEN TRUE
        ELSE FALSE
    END AS is_last_day_of_quarter,
    CASE
        WHEN DATE_PART('DOY', DATE_DAY) = 1 THEN TRUE
        ELSE FALSE
    END AS is_first_day_of_year,
    CASE
        WHEN DATE_PART('DOY', DATE_DAY) = 365 OR (EXTRACT(year FROM DATE_DAY)::INTEGER % 4 = 0 AND 
            DATE_PART('DOY', DATE_DAY) = 366) THEN TRUE
        ELSE FALSE
    END AS is_last_day_of_year,
    CASE
        WHEN DATE_TRUNC('QUARTER', DATE_DAY) = (SELECT current_quarter_start FROM current_date_info) THEN TRUE
        ELSE FALSE
    END AS is_current_quarter,
    CASE
        WHEN DATE_TRUNC('QUARTER', DATE_DAY) < (SELECT current_quarter_start FROM current_date_info) THEN TRUE
        ELSE FALSE
    END AS is_closed_quarter,
    pq.past_rank_quarter,
    CASE
        WHEN DATE_DAY = (SELECT current_date FROM current_date_info) THEN TRUE
        ELSE FALSE
    END AS is_current_date,
    DATE_TRUNC('WEEK', DATE_DAY) AS start_of_week_iso,
    DATEADD(DAY, 6, DATE_TRUNC('WEEK', DATE_DAY)) AS end_of_week_iso,
    DATEADD(DAY, -CASE WHEN DAYOFWEEK(DATE_DAY) = 1 THEN 0 ELSE DAYOFWEEK(DATE_DAY) - 1 END, DATE_DAY) AS start_of_week,
    DATEADD(DAY, 6, DATEADD(DAY, -CASE WHEN DAYOFWEEK(DATE_DAY) = 1 THEN 0 ELSE DAYOFWEEK(DATE_DAY) - 1 END, DATE_DAY)) AS end_of_week

FROM 
    date_spine
LEFT JOIN 
    past_quarters pq
ON 
    DATE_TRUNC('QUARTER', date_spine.DATE_DAY) = pq.quarter_start
    )
;


  