insert into TMP_CUTDOWN_EARNINGS_CORE_{YEAR}{MONTH}{USER}
-- Populates TMP_CUTDOWN_EARNINGS_CORE with relevant CORE NHS organisation data for the month from the Final_SIP_and_Earnings_ENGLAND table
      select [tm End Date]
	,[Breed]
	,[valid_publication_earnings]
	,[MAIN_STAFF_GROUP_NAME]
      ,[STAFF_GROUP_1_NAME]
	,[unique Nhs identifier]
	,[Reporting Org code]
	,[Reporting Org name]
	,[NHSE_Region_Code]
	,[NHSE_Region_Name]
	,[Occupation Code]
	,[grade]
	,[PUBGRP_010_BASIC_PAY_PER_FTE]
      ,[PUBGRP_020_EARNINGS]
      ,[PUBGRP_030_BASIC_PAY]
      ,[PUBGRP_040_NON_BASIC_PAY_PER_ROLE]
      ,[PUBGRP_100_ADDITIONAL_ACTIVITY]
      ,[PUBGRP_110_Band Supplement]
      ,[PUBGRP_120_MEDICAL_AWARDS]
      ,[PUBGRP_130_Geographic Allowance]
      ,[PUBGRP_140_Local]
      ,[PUBGRP_150_On Call Standby]
      ,[PUBGRP_160_Overtime ADH]
      ,[PUBGRP_170_RRP]
      ,[PUBGRP_180_Shift Working]
      ,[PUBGRP_190_OTHER_PAYMENTS]
      ,[PUBGRP_101_Additional Standard Time]
      ,[PUBGRP_102_Additional PA]
      ,[PUBGRP_121_Clinical Excellence Awards]
      ,[PUBGRP_122_Discretionary Points]
      ,[PUBGRP_123_Distinction Awards]
      ,[PUBGRP_171_RRP General]
      ,[PUBGRP_172_RRP Long Term]
      ,[PUBGRP_191_Bonus PRP]
      ,[PUBGRP_192_Directors of Public Health Supplement]
      ,[PUBGRP_193_Occupational Absence]
      ,[PUBGRP_194_Other]
      ,[PUBGRP_195_Protected Pay]
      from [Final_SIP_and_Earnings_ENGLAND_{YEAR}{MONTH}] a
      inner join [REF_org_master] b
      on b.[Current Org Code] = [Standard Organisation]
      inner join [REF_CORP_WKFC_OCCUPATION_V01] c
      on a.[Occupation Code] = c.[OCC_CODE]
      where ((b.[End Date] >= [Tm End Date]
      or b.[End Date] is null)
      and b.[Start Date] < [Tm End Date]
      and b.[EnglandWales] not like 'W')
      and a.[Valid_Publication_Earnings] in ('Monthly')
      and [Flag_Contracted] = 'Contracted'
      and a.[Breed] in ('Med','Nonmed')
      and [publication_flag] in ('ALL','EARNINGS')
      and (c.[END_DATE_PUBLICATION] >= [Tm End Date]
      or c.[END_DATE_PUBLICATION] is null)
      and c.[START_DATE_PUBLICATION] < [Tm End Date]

insert into TMP_CUTDOWN_EARNINGS_WIDER_{YEAR}{MONTH}{USER}
-- Populates TMP_CUTDOWN_EARNINGS_WIDER with relevant WIDER NHS organisation data for the month from the Final_SIP_and_Earnings_ENGLAND table
select [tm End Date]
	,[Breed]
	,[valid_publication_earnings]
	,[MAIN_STAFF_GROUP_NAME]
      ,[STAFF_GROUP_1_NAME]
	,[unique Nhs identifier]
	,[Reporting Org code]
	,[Reporting Org name]
	,[HEE_Region_Code]
	,[HEE_Region_Name]
	,[Occupation Code]
	,[grade]
	,[PUBGRP_010_BASIC_PAY_PER_FTE]
      ,[PUBGRP_020_EARNINGS]
      ,[PUBGRP_030_BASIC_PAY]
      ,[PUBGRP_040_NON_BASIC_PAY_PER_ROLE]
      ,[PUBGRP_100_ADDITIONAL_ACTIVITY]
      ,[PUBGRP_110_Band Supplement]
      ,[PUBGRP_120_MEDICAL_AWARDS]
      ,[PUBGRP_130_Geographic Allowance]
      ,[PUBGRP_140_Local]
      ,[PUBGRP_150_On Call Standby]
      ,[PUBGRP_160_Overtime ADH]
      ,[PUBGRP_170_RRP]
      ,[PUBGRP_180_Shift Working]
      ,[PUBGRP_190_OTHER_PAYMENTS]
      ,[PUBGRP_101_Additional Standard Time]
      ,[PUBGRP_102_Additional PA]
      ,[PUBGRP_121_Clinical Excellence Awards]
      ,[PUBGRP_122_Discretionary Points]
      ,[PUBGRP_123_Distinction Awards]
      ,[PUBGRP_171_RRP General]
      ,[PUBGRP_172_RRP Long Term]
      ,[PUBGRP_191_Bonus PRP]
      ,[PUBGRP_192_Directors of Public Health Supplement]
      ,[PUBGRP_193_Occupational Absence]
      ,[PUBGRP_194_Other]
      ,[PUBGRP_195_Protected Pay]
      from [Final_SIP_and_Earnings_ENGLAND_{YEAR}{MONTH}] a
      inner join [REF_org_master] b
      on b.[Current Org Code] = [Standard Organisation]
      inner join [REF_CORP_WKFC_OCCUPATION_V01] c
      on a.[Occupation Code] = c.[OCC_CODE]
      where ((b.[End Date] >= [Tm End Date]
      or b.[End Date] is null)
      and b.[Start Date] < [Tm End Date]
      and b.[EnglandWales] not like 'W')
      and a.[Valid_Publication_Earnings] in ('Quarterly - Wider NHS')
      and [Flag_Contracted] = 'Contracted'
      and a.[Breed] in ('Med','Nonmed')
      and [publication_flag] in ('ALL','EARNINGS')
      and (c.[END_DATE_PUBLICATION] >= [Tm End Date]
      or c.[END_DATE_PUBLICATION] is null)
      and c.[START_DATE_PUBLICATION] < [Tm End Date]