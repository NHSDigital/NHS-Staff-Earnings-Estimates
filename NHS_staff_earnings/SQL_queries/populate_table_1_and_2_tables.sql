insert into TMP_EARNINGS_TABLE1_AND_2_STAGING_{AREA}_{YEAR}{MONTH}{USER}
-- Calculate earnings measures for all staff groups 
select
[TM_END_DATE]
,'{AREA}'
,'Table 1 & 2'
,'1'
,'All staff'
,'{PAYMENT_TYPE}'
,round(sum([{PAYMENT_TYPE}])/(count(distinct([UNIQUE_NHS_IDENTIFIER]))),2,0),
count(distinct([UNIQUE_NHS_IDENTIFIER]))
from TMP_CUTDOWN_EARNINGS_{AREA}_{YEAR}{MONTH}{USER} a
group by [TM_END_DATE]

insert into TMP_EARNINGS_TABLE1_AND_2_STAGING_{AREA}_{YEAR}{MONTH}{USER}
-- Calculate earnings measures by Main Staff Group
select
[TM_END_DATE]
,'{AREA}'
,'Table 1 & 2'
,'2'
,[MAIN_STAFF_GROUP_NAME]
,'{PAYMENT_TYPE}'
,round(sum([{PAYMENT_TYPE}])/(count(distinct([UNIQUE_NHS_IDENTIFIER]))),2,0),
count(distinct([UNIQUE_NHS_IDENTIFIER]))
from TMP_CUTDOWN_EARNINGS_{AREA}_{YEAR}{MONTH}{USER} a
group by [TM_END_DATE],[MAIN_STAFF_GROUP_NAME]

insert into TMP_EARNINGS_TABLE1_AND_2_STAGING_{AREA}_{YEAR}{MONTH}{USER}
-- Calculate earnings measures by Staff Group
select
[TM_END_DATE]
,'{AREA}'
,'Table 1 & 2'
,'3'
,[STAFF_GROUP_1_NAME]
,'{PAYMENT_TYPE}'
,round(sum([{PAYMENT_TYPE}])/(count(distinct([UNIQUE_NHS_IDENTIFIER]))),2,0),
count(distinct([UNIQUE_NHS_IDENTIFIER]))
from TMP_CUTDOWN_EARNINGS_{AREA}_{YEAR}{MONTH}{USER} a
where [MAIN_STAFF_GROUP_NAME] not like 'Other staff or those with unknown classification'
group by [TM_END_DATE],[STAFF_GROUP_1_NAME]

insert into TMP_EARNINGS_TABLE1_AND_2_STAGING_{AREA}_{YEAR}{MONTH}{USER}
-- Calculate earnings measures by grade (HCHS doctors only)
select
[TM_END_DATE]
,'{AREA}'
,'Table 1 & 2'
,'4'
,[Grade]
,'{PAYMENT_TYPE}'
,round(sum([{PAYMENT_TYPE}])/(count(distinct([UNIQUE_NHS_IDENTIFIER]))),2,0),
count(distinct([UNIQUE_NHS_IDENTIFIER]))
from TMP_CUTDOWN_EARNINGS_{AREA}_{YEAR}{MONTH}{USER} a
where [BREED] like 'Med'
group by [TM_END_DATE],[Grade]

update TMP_EARNINGS_TABLE1_AND_2_STAGING_{AREA}_{YEAR}{MONTH}{USER}
-- Update Staff Group Order column
set [STAFF_GROUP_ORDER] =
case
when [STAFF_GROUP] = 'All Staff' then '01'
when [STAFF_GROUP] = 'Professionally qualified clinical staff' then '02'
when [STAFF_GROUP] = 'HCHS doctors' then '03'
when [STAFF_GROUP] = 'Consultant' then '04'
when [STAFF_GROUP] = 'Associate Specialist' then '05'
when [STAFF_GROUP] = 'Specialty Doctor' then '06'
when [STAFF_GROUP] = 'Staff Grade' then '07'
when [STAFF_GROUP] = 'Specialty Registrar' then '08'
when [STAFF_GROUP] = 'Core Training' then '09'
when [STAFF_GROUP] = 'Foundation Doctor Year 2' then '10'
when [STAFF_GROUP] = 'Foundation Doctor Year 1' then '11'
when [STAFF_GROUP] = 'Hospital Practitioner / Clinical Assistant' then '12'
when [STAFF_GROUP] = 'Other and Local HCHS Doctor Grades' then '13'
when [STAFF_GROUP] = 'Nurses & health visitors' then '14'
when [STAFF_GROUP] = 'Midwives' then '15'
when [STAFF_GROUP] = 'Ambulance staff' then '16'
when [STAFF_GROUP] = 'Scientific, therapeutic & technical staff' then '17'
when [STAFF_GROUP] = 'Support to clinical staff' then '18'
when [STAFF_GROUP] = 'Support to doctors, nurses & midwives' then '19'
when [STAFF_GROUP] = 'Support to ambulance staff' then '20'
when [STAFF_GROUP] = 'Support to ST&T staff' then '21'
when [STAFF_GROUP] = 'NHS infrastructure support' then '22'
when [STAFF_GROUP] = 'Central functions' then '23'
when [STAFF_GROUP] = 'Hotel, property & estates' then '24'
when [STAFF_GROUP] = 'Senior managers' then '25'
when [STAFF_GROUP] = 'Managers' then '26'
when [STAFF_GROUP] = 'Other staff or those with unknown classification' then '27'
end