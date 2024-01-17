insert into TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
-- Populates the final earnings table with data for Table 1 and 2 for CORE NHS organisations
select
[TM_END_DATE]
,[ORG_TYPE]
,[TABLE_NUMBER]
,[STAFF_GROUP_ORDER]
,[STAFF_GROUP]
,[PAYMENT_TYPE]
,[AMOUNT]
,[SAMPLE_SIZE]
from TMP_EARNINGS_TABLE1_AND_2_STAGING_CORE_{YEAR}{MONTH}{USER}
where concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) not in (select concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER})

insert into TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
-- Populates the final earnings table with data for Table 3 for CORE NHS organisations
select
[TM_END_DATE]
,[ORG_TYPE]
,[TABLE_NUMBER]
,[STAFF_GROUP_ORDER]
,[STAFF_GROUP]
,[PAYMENT_TYPE]
,[AMOUNT]
,[SAMPLE_SIZE]
from TMP_EARNINGS_TABLE3_STAGING_CORE_{YEAR}{MONTH}{USER}
where concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) not in (select concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER})

insert into TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
-- Populates the final earnings table with data for Table 1 and 2 for WIDER NHS organisations
select
[TM_END_DATE]
,[ORG_TYPE]
,[TABLE_NUMBER]
,[STAFF_GROUP_ORDER]
,[STAFF_GROUP]
,[PAYMENT_TYPE]
,[AMOUNT]
,[SAMPLE_SIZE]
from TMP_EARNINGS_TABLE1_AND_2_STAGING_WIDER_{YEAR}{MONTH}{USER}
where concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) not in (select concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER})

insert into TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
-- Populates the final earnings table with data for Table 3 for WIDER NHS organisations
select
[TM_END_DATE]
,[ORG_TYPE]
,[TABLE_NUMBER]
,[STAFF_GROUP_ORDER]
,[STAFF_GROUP]
,[PAYMENT_TYPE]
,[AMOUNT]
,[SAMPLE_SIZE]
from TMP_EARNINGS_TABLE3_STAGING_WIDER_{YEAR}{MONTH}{USER}
where concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) not in (select concat([TM_END_DATE],[ORG_TYPE],[TABLE_NUMBER]) from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER})

drop table TMP_CUTDOWN_EARNINGS_CORE_{YEAR}{MONTH}{USER}
drop table TMP_CUTDOWN_EARNINGS_WIDER_{YEAR}{MONTH}{USER}
drop table TMP_EARNINGS_TABLE1_AND_2_STAGING_CORE_{YEAR}{MONTH}{USER}
drop table TMP_EARNINGS_TABLE1_AND_2_STAGING_WIDER_{YEAR}{MONTH}{USER}
drop table TMP_EARNINGS_TABLE3_STAGING_CORE_{YEAR}{MONTH}{USER}
drop table TMP_EARNINGS_TABLE3_STAGING_WIDER_{YEAR}{MONTH}{USER}