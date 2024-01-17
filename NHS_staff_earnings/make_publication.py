
import sqlalchemy as sa # read in sqlalchemy package
import pandas as pd # read in pandas
import openpyxl
import logging
import shutil
from helpers import (get_config, get_excel_template_dir)
from data_connections import (make_connection,make_wesr_conn,execute_sql,write_df_to_sql_table,get_df_from_sql,read_in_sql_query)
import write_excel

logger = logging.getLogger(__name__)

config = get_config()
START_YEAR = config['START_YEAR']
YEAR = config['YEAR']
MONTHS = config['MONTHS']
END_MONTH = config['END_MONTH']
USER = config['USER']
OUTPUT_PATH = config['OUTPUT_PATH']
TEMPLATE_PATH = get_excel_template_dir()

for MONTH in MONTHS:
    wesr_conn = make_wesr_conn()

    # Create empty temp tables to paste earnings data into
    query_description = f"Creating earnings cutdown tables for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/create_tables.sql'
    sql_query_create_tables_raw = read_in_sql_query(sql_file_path)
    sql_query_create_tables = sql_query_create_tables_raw.format(YEAR=YEAR,MONTH=MONTH,USER=USER)
    execute_sql(sql_query_create_tables, wesr_conn)

    # Populate empty temp tables with earnings data
    query_description = f"Populating earnings cutdown tables with data for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_earnings_cutdown_tables.sql'
    sql_query_populate_cutdown_tables_raw = read_in_sql_query(sql_file_path)
    sql_query_populate_cutdown_tables = sql_query_populate_cutdown_tables_raw.format(YEAR=YEAR,MONTH=MONTH,USER=USER)
    execute_sql(sql_query_populate_cutdown_tables, wesr_conn)

    # Populate BPPFTE data for Table 1 and 2 for CORE NHS organisations
    AREA = 'CORE'
    PAYMENT_TYPE = 'PUBGRP_010_BASIC_PAY_PER_FTE'
    query_description = f"Populating table_1_and_2_{AREA} NHS tables with PUBGRP_010_BASIC_PAY_PER_FTE data for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_table_1_and_2_tables_BPPFTE.sql'
    sql_query_populate_t1_t2_core_raw = read_in_sql_query(sql_file_path)
    sql_query_populate_t1_t2_core_tables = sql_query_populate_t1_t2_core_raw.format(AREA=AREA,YEAR=YEAR,MONTH=MONTH,USER=USER,PAYMENT_TYPE=PAYMENT_TYPE)
    execute_sql(sql_query_populate_t1_t2_core_tables, wesr_conn)

    # Populate BPPFTE data for Table 1 and 2 for WIDER NHS organisations
    AREA = 'WIDER'
    PAYMENT_TYPE = 'PUBGRP_010_BASIC_PAY_PER_FTE'
    query_description = f"Populating table_1_and_2_{AREA} NHS tables with PUBGRP_010_BASIC_PAY_PER_FTE data for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_table_1_and_2_tables_BPPFTE.sql'
    sql_query_populate_t1_t2_wider_raw = read_in_sql_query(sql_file_path)
    sql_query_populate_t1_t2_wider_tables = sql_query_populate_t1_t2_wider_raw.format(AREA=AREA,YEAR=YEAR,MONTH=MONTH,USER=USER,PAYMENT_TYPE=PAYMENT_TYPE)
    execute_sql(sql_query_populate_t1_t2_wider_tables, wesr_conn)

    # Populate earnings data for Table 1 and 2 for CORE NHS organisations
    AREA = 'CORE'
    PAYMENT_TYPES = ['PUBGRP_020_EARNINGS','PUBGRP_030_BASIC_PAY','PUBGRP_040_NON_BASIC_PAY_PER_ROLE','PUBGRP_100_ADDITIONAL_ACTIVITY','PUBGRP_110_BAND_SUPPLEMENT','PUBGRP_120_MEDICAL_AWARDS','PUBGRP_130_GEOGRAPHIC_ALLOWANCE','PUBGRP_140_LOCAL','PUBGRP_150_ON_CALL_STANDBY','PUBGRP_160_OVERTIME_ADH','PUBGRP_170_RRP','PUBGRP_180_SHIFT_WORKING','PUBGRP_190_OTHER_PAYMENTS']
    query_description = f"Populating table_1_and_2_{AREA} NHS tables with all remaining payment type data for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_table_1_and_2_tables.sql'
    sql_query_populate_t1_t2_core_raw = read_in_sql_query(sql_file_path)
    for PAYMENT_TYPE in PAYMENT_TYPES:
        sql_query_populate_t1_t2_core_tables = sql_query_populate_t1_t2_core_raw.format(AREA=AREA,YEAR=YEAR,MONTH=MONTH,USER=USER,PAYMENT_TYPE=PAYMENT_TYPE)
        execute_sql(sql_query_populate_t1_t2_core_tables, wesr_conn)

    # Populate earnings data for Table 1 and 2 for WIDER NHS organisations
    AREA = 'WIDER'
    PAYMENT_TYPES = ['PUBGRP_020_EARNINGS','PUBGRP_030_BASIC_PAY','PUBGRP_040_NON_BASIC_PAY_PER_ROLE','PUBGRP_100_ADDITIONAL_ACTIVITY','PUBGRP_110_BAND_SUPPLEMENT','PUBGRP_120_MEDICAL_AWARDS','PUBGRP_130_GEOGRAPHIC_ALLOWANCE','PUBGRP_140_LOCAL','PUBGRP_150_ON_CALL_STANDBY','PUBGRP_160_OVERTIME_ADH','PUBGRP_170_RRP','PUBGRP_180_SHIFT_WORKING','PUBGRP_190_OTHER_PAYMENTS']
    query_description = f"Populating table_1_and_2_{AREA} NHS tables with all remaining payment type data for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_table_1_and_2_tables.sql'
    sql_query_populate_t1_t2_wider_raw = read_in_sql_query(sql_file_path)
    for PAYMENT_TYPE in PAYMENT_TYPES:
        sql_query_populate_t1_t2_wider_tables = sql_query_populate_t1_t2_wider_raw.format(AREA=AREA,YEAR=YEAR,MONTH=MONTH,USER=USER,PAYMENT_TYPE=PAYMENT_TYPE)
        execute_sql(sql_query_populate_t1_t2_wider_tables, wesr_conn)

    # Populate earnings data for Table 3 for CORE NHS organisations
    AREA = 'CORE'
    PAYMENT_TYPES = ['PUBGRP_100_ADDITIONAL_ACTIVITY','PUBGRP_110_BAND_SUPPLEMENT','PUBGRP_120_MEDICAL_AWARDS','PUBGRP_130_GEOGRAPHIC_ALLOWANCE','PUBGRP_140_LOCAL','PUBGRP_150_ON_CALL_STANDBY','PUBGRP_160_OVERTIME_ADH','PUBGRP_170_RRP','PUBGRP_180_SHIFT_WORKING','PUBGRP_190_OTHER_PAYMENTS']
    query_description = f"Populating table_3_{AREA} NHS tables with data for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_table_3.sql'
    sql_query_populate_t3_core_raw = read_in_sql_query(sql_file_path)
    for PAYMENT_TYPE in PAYMENT_TYPES:
        sql_query_populate_t3_core_tables = sql_query_populate_t3_core_raw.format(AREA=AREA,YEAR=YEAR,MONTH=MONTH,USER=USER,PAYMENT_TYPE=PAYMENT_TYPE)
        execute_sql(sql_query_populate_t3_core_tables, wesr_conn)

    # Populate earnings data for Table 3 for WIDER NHS organisations
    AREA = 'WIDER'
    PAYMENT_TYPES = ['PUBGRP_100_ADDITIONAL_ACTIVITY','PUBGRP_110_BAND_SUPPLEMENT','PUBGRP_120_MEDICAL_AWARDS','PUBGRP_130_GEOGRAPHIC_ALLOWANCE','PUBGRP_140_LOCAL','PUBGRP_150_ON_CALL_STANDBY','PUBGRP_160_OVERTIME_ADH','PUBGRP_170_RRP','PUBGRP_180_SHIFT_WORKING','PUBGRP_190_OTHER_PAYMENTS']
    query_description = f"Populating table_3_{AREA} NHS tables with data for {YEAR}{MONTH}{USER}...."
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_table_3.sql'
    sql_query_populate_t3_wider_raw = read_in_sql_query(sql_file_path)
    for PAYMENT_TYPE in PAYMENT_TYPES:
        sql_query_populate_t3_wider_tables = sql_query_populate_t3_wider_raw.format(AREA=AREA,YEAR=YEAR,MONTH=MONTH,USER=USER,PAYMENT_TYPE=PAYMENT_TYPE)
        execute_sql(sql_query_populate_t3_wider_tables, wesr_conn)

    # Populate final earnings table used for publication production
    query_description = f"Populating final earnings table used for publication"
    print(query_description)
    sql_file_path = 'NHS_staff_earnings/SQL_queries/populate_final_earnings_table.sql'
    sql_query_populate_final_table_raw = read_in_sql_query(sql_file_path)
    sql_query_populate_final_table = sql_query_populate_final_table_raw.format(YEAR=YEAR,MONTH=MONTH,USER=USER)
    execute_sql(sql_query_populate_final_table, wesr_conn)

# Populate final earnings csv
wesr_conn = make_wesr_conn()

core_csv_query = f"""
                select [TM_END_DATE] AS [DATE],
                [STAFF_GROUP_ORDER],
                [STAFF_GROUP],
                [PAYMENT_TYPE],
                [AMOUNT],
                [SAMPLE_SIZE] 
                from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER} 
                where [SAMPLE_SIZE] >= 10 
                and TABLE_NUMBER like 'TABLE 1 & 2'
                and ORG_TYPE like 'CORE' 
                order by [TM_END_DATE],
	            [STAFF_GROUP_ORDER], 
                [STAFF_GROUP], 
                [PAYMENT_TYPE], 
                [AMOUNT], 
                [SAMPLE_SIZE]
                """
print(f"Running query CORE csv output query:")
print(core_csv_query)

core_csv_data = pd.read_sql(core_csv_query, wesr_conn)
print("Core row counts by date:")
print(core_csv_data["DATE"].value_counts().sort_index(ascending=False))
    
core_csv_path = OUTPUT_PATH + f"Final_Earnings_csv_core.csv"
print(f"Saving to {core_csv_path}")
core_csv_data.to_csv(core_csv_path, index=False)

wider_csv_query = f"""
                select [TM_END_DATE] AS [DATE],
                [STAFF_GROUP_ORDER],
                [STAFF_GROUP],
                [PAYMENT_TYPE],
                [AMOUNT],
                [SAMPLE_SIZE] 
                from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER} 
                where [SAMPLE_SIZE] >= 10 
                and TABLE_NUMBER like 'TABLE 1 & 2'
                and ORG_TYPE like 'WIDER' 
                order by [TM_END_DATE],
	            [STAFF_GROUP_ORDER], 
                [STAFF_GROUP], 
                [PAYMENT_TYPE], 
                [AMOUNT], 
                [SAMPLE_SIZE]
                """
print(f"Running query WIDER csv output query:")
print(core_csv_query)

wider_csv_data = pd.read_sql(wider_csv_query, wesr_conn)
print("Wider row counts by date:")
print(wider_csv_data["DATE"].value_counts().sort_index(ascending=False))
    
wider_csv_path = OUTPUT_PATH + f"Final_Earnings_csv_wider.csv"
print(f"Saving to {wider_csv_path}")
wider_csv_data.to_csv(wider_csv_path, index=False)

# Create set of dataframes which hold 12 months of data for CORE organisations
raw_dataset1_core = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 1 & 2'
                    and ORG_TYPE like 'CORE'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', -1)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01', -2)
                    """
print(f"Running first raw dataset for CORE organisations:")
print(raw_dataset1_core)

raw_dataset2_core = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 1 & 2'
                    and ORG_TYPE like 'CORE'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', 0)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01', -1)
                    """
print(f"Running second raw dataset for CORE organisations:")
print(raw_dataset2_core)

raw_dataset3_core = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 1 & 2'
                    and ORG_TYPE like 'CORE'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', +1)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01')
                    """
print(f"Running third raw dataset for CORE organisations:")
print(raw_dataset3_core)

raw_dataset4_core = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 3'
                    and ORG_TYPE like 'CORE'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', +1)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01')
                    """
print(f"Running forth raw dataset for CORE organisations:")
print(raw_dataset4_core)

# Create a list of dataframes
dataframes_CORE = [
    pd.read_sql(raw_dataset1_core, wesr_conn),
    pd.read_sql(raw_dataset2_core, wesr_conn),
    pd.read_sql(raw_dataset3_core, wesr_conn),
    pd.read_sql(raw_dataset4_core, wesr_conn)
]
print(f"Creating list of dataframes for CORE organisations")

# Copy the excel templates to final file location for CORE organisations
excel_template_CORE = TEMPLATE_PATH / 'Earnings_CORE_template.xlsx'
excel_output_CORE = OUTPUT_PATH + f"Final_Earnings_CORE_Tables.xlsx"
print(f"Copying final earnings file for CORE organisations to output folder")
shutil.copy(excel_template_CORE, excel_output_CORE)

# Create a list of sheet names
sheet_name = ["Table 1 Raw 1", "Table 1 Raw 2", "Table 1 Raw 3", "Table 3 Raw"]

# Paste data into final excel file for CORE organisations
write_excel.write_data_to_excel_CORE(dataframes_CORE, excel_template_CORE, excel_output_CORE, sheet_name)
print(f"All data for CORE organisations complete")

# Create set of dataframes which hold 12 months of data for WIDER organisations
raw_dataset1_wider = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 1 & 2'
                    and ORG_TYPE like 'WIDER'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', -1)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01', -2)
                    """
print(f"Running first raw dataset for WIDER organisations:")
print(raw_dataset1_wider)

raw_dataset2_wider = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 1 & 2'
                    and ORG_TYPE like 'WIDER'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', 0)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01', -1)
                    """
print(f"Running second raw dataset for WIDER organisations:")
print(raw_dataset2_wider)

raw_dataset3_wider = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 1 & 2'
                    and ORG_TYPE like 'WIDER'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', +1)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01')
                    """
print(f"Running third raw dataset for WIDER organisations:")
print(raw_dataset3_wider)

raw_dataset4_wider = f"""
                    select [TM_END_DATE],
                    [STAFF_GROUP_ORDER],
                    [STAFF_GROUP],
                    [PAYMENT_TYPE],
                    [AMOUNT],
                    [SAMPLE_SIZE]
                    from TMP_FINAL_EARNINGS_PUBLICATION_TABLE{USER}
                    where TABLE_NUMBER like 'TABLE 3'
                    and ORG_TYPE like 'WIDER'
                    and [TM_END_DATE] >= eomonth('{START_YEAR}-{END_MONTH}-01', +1)
                    and [TM_END_DATE] <= eomonth('{YEAR}-{END_MONTH}-01')
                    """
print(f"Running forth raw dataset for WIDER organisations:")
print(raw_dataset4_wider)

# Create a list of dataframes
dataframes_WIDER = [
    pd.read_sql(raw_dataset1_wider, wesr_conn),
    pd.read_sql(raw_dataset2_wider, wesr_conn),
    pd.read_sql(raw_dataset3_wider, wesr_conn),
    pd.read_sql(raw_dataset4_wider, wesr_conn)
]
print(f"Creating list of dataframes for WIDER organisations")

# Copy the excel templates to final file location for WIDER organisations
excel_template_WIDER = TEMPLATE_PATH / 'Earnings_WIDER_template.xlsx'
excel_output_WIDER = OUTPUT_PATH + f"Final_Earnings_WIDER_Tables.xlsx"
print(f"Copying final earnings file for WIDER organisations to output folder")
shutil.copy(excel_template_WIDER, excel_output_WIDER)

# Paste data into final excel file for WIDER organisations
write_excel.write_data_to_excel_WIDER(dataframes_WIDER, excel_template_WIDER, excel_output_WIDER, sheet_name)
print(f"All data for WIDER organisations complete")
print(f"Publication process complete")