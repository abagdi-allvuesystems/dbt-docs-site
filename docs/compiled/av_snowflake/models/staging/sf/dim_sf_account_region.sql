WITH sf_account AS (
    SELECT * FROM AV_EDM.AV_SYSTEM.sys_sf_account
), country_region_mapping AS (
    SELECT 'Andorra' AS BILLINGCOUNTRY, 'UMEA' AS REGION UNION ALL
    SELECT 'Armenia', 'UMEA' UNION ALL
    SELECT 'Australia', 'APAC' UNION ALL
    SELECT 'Austria', 'UMEA' UNION ALL
    SELECT 'Azerbaijan', 'UMEA' UNION ALL
    SELECT 'Bahamas', 'America' UNION ALL
    SELECT 'Bahrain', 'UMEA' UNION ALL
    SELECT 'Bangladesh', 'APAC' UNION ALL
    SELECT 'Belgium', 'UMEA' UNION ALL
    SELECT 'Bermuda', 'America' UNION ALL
    SELECT 'Bhutan', 'APAC' UNION ALL
    SELECT 'Botswana', 'UMEA' UNION ALL
    SELECT 'Brazil', 'America' UNION ALL
    SELECT 'Bulgaria', 'UMEA' UNION ALL
    SELECT 'Canada', 'America' UNION ALL
    SELECT 'Cayman Islands', 'America' UNION ALL
    SELECT 'Chile', 'America' UNION ALL
    SELECT 'China', 'APAC' UNION ALL
    SELECT 'Chinese Taipei', 'APAC' UNION ALL
    SELECT 'Costa Rica', 'America' UNION ALL
    SELECT 'Croatia', 'UMEA' UNION ALL
    SELECT 'Curaçao', 'America' UNION ALL
    SELECT 'Cyprus', 'UMEA' UNION ALL
    SELECT 'Czech Republic', 'UMEA' UNION ALL
    SELECT 'Denmark', 'UMEA' UNION ALL
    SELECT 'Egypt', 'UMEA' UNION ALL
    SELECT 'Estonia', 'UMEA' UNION ALL
    SELECT 'Fiji', 'APAC' UNION ALL
    SELECT 'Finland', 'UMEA' UNION ALL
    SELECT 'France', 'UMEA' UNION ALL
    SELECT 'Georgia', 'UMEA' UNION ALL
    SELECT 'Germany', 'UMEA' UNION ALL
    SELECT 'Gibraltar', 'UMEA' UNION ALL
    SELECT 'Greece', 'UMEA' UNION ALL
    SELECT 'Guernsey', 'UMEA' UNION ALL
    SELECT 'Hong Kong', 'APAC' UNION ALL
    SELECT 'Hungary', 'UMEA' UNION ALL
    SELECT 'Iceland', 'UMEA' UNION ALL
    SELECT 'India', 'APAC' UNION ALL
    SELECT 'Indonesia', 'APAC' UNION ALL
    SELECT 'Ireland', 'UMEA' UNION ALL
    SELECT 'Isle of Man', 'UMEA' UNION ALL
    SELECT 'Israel', 'UMEA' UNION ALL
    SELECT 'Italy', 'UMEA' UNION ALL
    SELECT 'Japan', 'APAC' UNION ALL
    SELECT 'Jersey', 'UMEA' UNION ALL
    SELECT 'Jordan', 'UMEA' UNION ALL
    SELECT 'Kazakhstan', 'UMEA' UNION ALL
    SELECT 'Kuwait', 'UMEA' UNION ALL
    SELECT 'Kyrgyzstan', 'UMEA' UNION ALL
    SELECT 'Latvia', 'UMEA' UNION ALL
    SELECT 'Liechtenstein', 'UMEA' UNION ALL
    SELECT 'Lithuania', 'UMEA' UNION ALL
    SELECT 'Luxembourg', 'UMEA' UNION ALL
    SELECT 'Malaysia', 'APAC' UNION ALL
    SELECT 'Malta', 'UMEA' UNION ALL
    SELECT 'Mauritius', 'UMEA' UNION ALL
    SELECT 'Mexico', 'America' UNION ALL
    SELECT 'Monaco', 'UMEA' UNION ALL
    SELECT 'Mongolia', 'APAC' UNION ALL
    SELECT 'Morocco', 'UMEA' UNION ALL
    SELECT 'Myanmar', 'APAC' UNION ALL
    SELECT 'Nepal', 'APAC' UNION ALL
    SELECT 'Netherlands', 'UMEA' UNION ALL
    SELECT 'New Zealand', 'APAC' UNION ALL
    SELECT 'Nigeria', 'UMEA' UNION ALL
    SELECT 'Norway', 'UMEA' UNION ALL
    SELECT 'Pakistan', 'APAC' UNION ALL
    SELECT 'Panama', 'America' UNION ALL
    SELECT 'Papua New Guinea', 'APAC' UNION ALL
    SELECT 'Peru', 'America' UNION ALL
    SELECT 'Philippines', 'APAC' UNION ALL
    SELECT 'Poland', 'UMEA' UNION ALL
    SELECT 'Portugal', 'UMEA' UNION ALL
    SELECT 'Puerto Rico', 'America' UNION ALL
    SELECT 'Qatar', 'UMEA' UNION ALL
    SELECT 'Romania', 'UMEA' UNION ALL
    SELECT 'Russian Federation', 'UMEA' UNION ALL
    SELECT 'Saudi Arabia', 'UMEA' UNION ALL
    SELECT 'Serbia', 'UMEA' UNION ALL
    SELECT 'Singapore', 'APAC' UNION ALL
    SELECT 'Slovakia', 'UMEA' UNION ALL
    SELECT 'Slovenia', 'UMEA' UNION ALL
    SELECT 'South Africa', 'UMEA' UNION ALL
    SELECT 'South Korea', 'APAC' UNION ALL
    SELECT 'Spain', 'UMEA' UNION ALL
    SELECT 'Sri Lanka', 'APAC' UNION ALL
    SELECT 'Sweden', 'UMEA' UNION ALL
    SELECT 'Switzerland', 'UMEA' UNION ALL
    SELECT 'Thailand', 'APAC' UNION ALL
    SELECT 'Timor-Leste', 'APAC' UNION ALL
    SELECT 'Turkey', 'UMEA' UNION ALL
    SELECT 'Ukraine', 'UMEA' UNION ALL
    SELECT 'United Arab Emirates', 'UMEA' UNION ALL
    SELECT 'United Kingdom', 'UMEA' UNION ALL
    SELECT 'United States', 'America' UNION ALL
    SELECT 'Uruguay', 'America' UNION ALL
    SELECT 'Vietnam', 'APAC'
)
SELECT distinct sfa.billingcountry
    ,map.region
FROM sf_account sfa LEFT JOIN country_region_mapping map on sfa.billingcountry = map.billingcountry
where sfa.billingcountry is not null