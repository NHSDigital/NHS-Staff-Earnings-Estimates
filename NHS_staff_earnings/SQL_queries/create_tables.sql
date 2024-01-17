CREATE TABLE [dbo].TMP_CUTDOWN_EARNINGS_CORE_{YEAR}{MONTH}{USER} 
-- Creates an empty cutdown table of the Earnings file for CORE NHS organisations to enable quicker querying for the specified month
(   [TM_END_DATE] [date] NULL,
	[BREED] [varchar](50) NULL,
	[VALID_PUBLICATION_EARNINGS] [varchar](25) NULL,
	[MAIN_STAFF_GROUP_NAME] [varchar](255) NULL,
	[STAFF_GROUP_1_NAME] [varchar](255) NULL,
	[UNIQUE_NHS_IDENTIFIER] [varchar](255) NULL,
	[REPORTING_ORG_CODE] [varchar](255) NULL,
	[REPORTING_ORG_NAME] [varchar](255) NULL,
	[NHSE_REGION_CODE] [varchar](255) NULL,
	[NHSE_REGION_NAME] [varchar](255) NULL,
	[OCCUPATION_CODE] [varchar](255) NULL,
	[GRADE] [varchar](255) NULL,
	[PUBGRP_010_BASIC_PAY_PER_FTE] [decimal](18, 3) NULL,
	[PUBGRP_020_EARNINGS] [decimal](18, 3) NULL,
	[PUBGRP_030_BASIC_PAY] [decimal](18, 3) NULL,
	[PUBGRP_040_NON_BASIC_PAY_PER_ROLE] [decimal](18, 3) NULL,
	[PUBGRP_100_ADDITIONAL_ACTIVITY] [decimal](18, 3) NULL,
	[PUBGRP_110_BAND_SUPPLEMENT] [decimal](18, 3) NULL,
	[PUBGRP_120_MEDICAL_AWARDS] [decimal](18, 3) NULL,
	[PUBGRP_130_GEOGRAPHIC_ALLOWANCE] [decimal](18, 3) NULL,
	[PUBGRP_140_LOCAL] [decimal](18, 3) NULL,
	[PUBGRP_150_ON_CALL_STANDBY] [decimal](18, 3) NULL,
	[PUBGRP_160_OVERTIME_ADH] [decimal](18, 3) NULL,
	[PUBGRP_170_RRP] [decimal](18, 3) NULL,
	[PUBGRP_180_SHIFT_WORKING] [decimal](18, 3) NULL,
	[PUBGRP_190_OTHER_PAYMENTS] [decimal](18, 3) NULL,
	[PUBGRP_101_ADDITIONAL_STANDARD_TIME] [decimal](18, 3) NULL,
	[PUBGRP_102_ADDITIONAL_PA] [decimal](18, 3) NULL,
	[PUBGRP_121_CLINICAL_EXCELLENCE_AWARDS] [decimal](18, 3) NULL,
	[PUBGRP_122_DISCRETIONARY_POINTS] [decimal](18, 3) NULL,
	[PUBGRP_123_DISTINCTION_AWARDS] [decimal](18, 3) NULL,
	[PUBGRP_171_RRP_GENERAL] [decimal](18, 3) NULL,
	[PUBGRP_172_RRP_LONG_TERM] [decimal](18, 3) NULL,
	[PUBGRP_191_BONUS_PRP] [decimal](18, 3) NULL,
	[PUBGRP_192_DIRECTORS_OF_PUBLIC_HEALTH_SUPPLEMENT] [decimal](18, 3) NULL,
	[PUBGRP_193_OCCUPATIONAL_ABSENCE] [decimal](18, 3) NULL,
	[PUBGRP_194_OTHER] [decimal](18, 3) NULL,
	[PUBGRP_195_PROTECTED_PAY] [decimal](18, 3) NULL);

CREATE TABLE [dbo].TMP_CUTDOWN_EARNINGS_WIDER_{YEAR}{MONTH}{USER} 
-- Creates an empty cutdown table of the Earnings file for WIDER NHS organisations to enable quicker querying for the specified month
(   [TM_END_DATE] [date] NULL,
	[BREED] [varchar](50) NULL,
	[VALID_PUBLICATION_EARNINGS] [varchar](25) NULL,
	[MAIN_STAFF_GROUP_NAME] [varchar](255) NULL,
	[STAFF_GROUP_1_NAME] [varchar](255) NULL,
	[UNIQUE_NHS_IDENTIFIER] [varchar](255) NULL,
	[REPORTING_ORG_CODE] [varchar](255) NULL,
	[REPORTING_ORG_NAME] [varchar](255) NULL,
	[NHSE_REGION_CODE] [varchar](255) NULL,
	[NHSE_REGION_NAME] [varchar](255) NULL,
	[OCCUPATION_CODE] [varchar](255) NULL,
	[GRADE] [varchar](255) NULL,
	[PUBGRP_010_BASIC_PAY_PER_FTE] [decimal](18, 3) NULL,
	[PUBGRP_020_EARNINGS] [decimal](18, 3) NULL,
	[PUBGRP_030_BASIC_PAY] [decimal](18, 3) NULL,
	[PUBGRP_040_NON_BASIC_PAY_PER_ROLE] [decimal](18, 3) NULL,
	[PUBGRP_100_ADDITIONAL_ACTIVITY] [decimal](18, 3) NULL,
	[PUBGRP_110_BAND_SUPPLEMENT] [decimal](18, 3) NULL,
	[PUBGRP_120_MEDICAL_AWARDS] [decimal](18, 3) NULL,
	[PUBGRP_130_GEOGRAPHIC_ALLOWANCE] [decimal](18, 3) NULL,
	[PUBGRP_140_LOCAL] [decimal](18, 3) NULL,
	[PUBGRP_150_ON_CALL_STANDBY] [decimal](18, 3) NULL,
	[PUBGRP_160_OVERTIME_ADH] [decimal](18, 3) NULL,
	[PUBGRP_170_RRP] [decimal](18, 3) NULL,
	[PUBGRP_180_SHIFT_WORKING] [decimal](18, 3) NULL,
	[PUBGRP_190_OTHER_PAYMENTS] [decimal](18, 3) NULL,
	[PUBGRP_101_ADDITIONAL_STANDARD_TIME] [decimal](18, 3) NULL,
	[PUBGRP_102_ADDITIONAL_PA] [decimal](18, 3) NULL,
	[PUBGRP_121_CLINICAL_EXCELLENCE_AWARDS] [decimal](18, 3) NULL,
	[PUBGRP_122_DISCRETIONARY_POINTS] [decimal](18, 3) NULL,
	[PUBGRP_123_DISTINCTION_AWARDS] [decimal](18, 3) NULL,
	[PUBGRP_171_RRP_GENERAL] [decimal](18, 3) NULL,
	[PUBGRP_172_RRP_LONG_TERM] [decimal](18, 3) NULL,
	[PUBGRP_191_BONUS_PRP] [decimal](18, 3) NULL,
	[PUBGRP_192_DIRECTORS_OF_PUBLIC_HEALTH_SUPPLEMENT] [decimal](18, 3) NULL,
	[PUBGRP_193_OCCUPATIONAL_ABSENCE] [decimal](18, 3) NULL,
	[PUBGRP_194_OTHER] [decimal](18, 3) NULL,
	[PUBGRP_195_PROTECTED_PAY] [decimal](18, 3) NULL);

CREATE TABLE dbo.TMP_EARNINGS_TABLE1_AND_2_STAGING_CORE_{YEAR}{MONTH}{USER} 
-- Creates an empty staging table for Tables 1 and 2 for CORE NHS organisations for the specified month
(	[TM_END_DATE] date NULL,
	[ORG_TYPE] [nvarchar](255) NULL,
	[TABLE_NUMBER] [nvarchar](255) NULL,
	[STAFF_GROUP_ORDER] [nvarchar](255) NULL, 
	[STAFF_GROUP] [varchar](70) NOT NULL, 
	[PAYMENT_TYPE] [varchar](255) NOT NULL, 
	[AMOUNT] [decimal](18,3) NULL, 
	[SAMPLE_SIZE] [int] NULL);

CREATE TABLE dbo.TMP_EARNINGS_TABLE1_AND_2_STAGING_WIDER_{YEAR}{MONTH}{USER} 
-- Creates an empty staging table for Tables 1 and 2 for WIDER NHS organisations for the specified month
( 	[TM_END_DATE] date NULL,
	[ORG_TYPE] [nvarchar](255) NULL,
	[TABLE_NUMBER] [nvarchar](255) NULL, 
	[STAFF_GROUP_ORDER] [nvarchar](255) NULL, 
	[STAFF_GROUP] [varchar](70) NOT NULL, 
	[PAYMENT_TYPE] [varchar](255) NOT NULL, 
	[AMOUNT] [decimal](18,3) NULL, 
	[SAMPLE_SIZE] [int] NULL);

CREATE TABLE dbo.TMP_EARNINGS_TABLE3_STAGING_CORE_{YEAR}{MONTH}{USER} 
-- Creates an empty staging table for Table 3 for CORE NHS organisations for the specified month
( 	[TM_END_DATE] date NULL,
	[ORG_TYPE] [nvarchar](255) NULL,
	[TABLE_NUMBER] [nvarchar](255) NULL,
	[STAFF_GROUP_ORDER] [nvarchar](255) NULL, 
	[STAFF_GROUP] [varchar](70) NOT NULL, 
	[PAYMENT_TYPE] [varchar](255) NOT NULL, 
	[AMOUNT] [decimal](18,3) NULL, 
	[SAMPLE_SIZE] [int] NULL);

CREATE TABLE dbo.TMP_EARNINGS_TABLE3_STAGING_WIDER_{YEAR}{MONTH}{USER} 
-- Creates an empty staging table for Table 3 for WIDER NHS organisations for the specified month
( 	[TM_END_DATE] date NULL,
	[ORG_TYPE] [nvarchar](255) NULL,
	[TABLE_NUMBER] [nvarchar](255) NULL, 
	[STAFF_GROUP_ORDER] [nvarchar](255) NULL, 
	[STAFF_GROUP] [varchar](70) NOT NULL, 
	[PAYMENT_TYPE] [varchar](255) NOT NULL, 
	[AMOUNT] [decimal](18,3) NULL, 
	[SAMPLE_SIZE] [int] NULL);

IF OBJECT_ID ('TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}') IS NULL
CREATE TABLE dbo.TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
-- Creates an empty final table for CORE and WIDER NHS organisations which is used to produce the earnings publication
(	[TM_END_DATE] date NULL,
	[ORG_TYPE] [varchar](255) NULL,
	[TABLE_NUMBER] [varchar](255) NULL,
	[STAFF_GROUP_ORDER] [nvarchar](255) NULL, 
	[STAFF_GROUP] [varchar](70) NOT NULL, 
	[PAYMENT_TYPE] [varchar](255) NOT NULL, 
	[AMOUNT] [decimal](18,3) NULL, 
	[SAMPLE_SIZE] [int] NULL);

IF OBJECT_ID ('TMP_FINAL_EARNINGS_CSV_TABLE{USER}') IS NULL
CREATE TABLE dbo.TMP_FINAL_EARNINGS_CSV_TABLE{USER}
-- Creates an empty CSV table for CORE and WIDER NHS organisations which is used to populate the earnings publication
(	[TM_END_DATE] date NULL,
	[ORG_TYPE] [varchar](255) NULL,
	[STAFF_GROUP_ORDER] [nvarchar](255) NULL, 
	[STAFF_GROUP] [varchar](70) NOT NULL, 
	[PAYMENT_TYPE] [varchar](255) NOT NULL, 
	[AMOUNT] [decimal](18,3) NULL, 
	[SAMPLE_SIZE] [int] NULL);