# NHS Earnings

To view the packages needed to run the NHS Earnings process, please view the requirements.txt file in the repository.


## Producing the publication
These are the steps to follow in order to produce the quarterly NHS Staff Earnings publication:

1. Update the excel data table templates if necessary
2. Update dates in the config.toml file to the quarter you are running data for
3. Run the make_publication.py script, details on what this code does are below
4. Check the excel output and confirm the expected months have been populated within the source data tabs

Note: if there are ever any new staff groups or doctor grades these will need adding to the excel templates/ python scripts. This is not a regular occurrence but can happen, and we will be made aware of any additions needed by the data standards team.

The process produces the following outputs:

- NHS Staff Annual Earnings in NHS Trusts and other core organisations in England, Excel tables
- NHS Staff Annual Earnings in NHS Support Organisations and Central Bodies in England, Excel tables
- NHS Staff Annual Earnings in NHS Trusts and other core organisations in England, CSV text file
- NHS Staff Annual Earnings in NHS Support Organisations and Central Bodies in England, CSV text file


## High level walkthrough of the project structure
This section explains how the code runs from a narrative perspective. You can find out more by looking in each module and reading the docstrings that go along with each function.

The pipeline includes:
* [Loading the input parameters from the config.toml file](#import-the-config)
* [Creating and populating temporary SQL tables to paste earnings data into](#create-cutdown-tables)
* [Populating temporary SQL cutdown earnings tables to speed up processing and as a basis for excel tables in publication](#Populate-cutdown-earnings-tables-to-speed-up-processing)
* [Running the various publication table production SQL scripts](Running-the-various-publication-table-production-SQL-scripts)
* [Populating final earnings table used for publication production within SQL](Populate-final-earnings-table-used-for-publication-production)
* [Populating the final earnings CSV text files](Populate-final-earnings-csv-text-files)
* [Creating a set of dataframes which hold 12 months of data](Create-set-of-dataframes-which-hold-12-months-of-data)
* [Populating publication tables in excel templates](#Writing-data-into-final-excel-files-for-publication)

### Repository structure
```
NHS_staff_earnings
├── .gitignore
├── README.md
├── config.toml
├───NHS_staff_earnings
│   ├──SQL_queries    
│   │  ├──create_tables.sql
│   │  ├──populate_earnings_cutdown_tables.sql
│   │  ├──populate_final_earnings_table.sql
│   │  ├──populate_table_1_and_2_tables_BPPFTE.sql
│   │  ├──populate_table_1_and_2_tables.sql
│   │  ├──populate_table_3
├── data_connections.py
├── make_publication.py
├── write_excel.py
├── helpers.py     
│            
├───excel_templates
│   ├───Earnings_CORE_template.xlsx
│   ├───Earnings_WIDER_template.xlsx    
```
- _More on Project structure (including setup.py and other standard repository files): [Guide](https://github.com/NHSDigital/rap-community-of-practice/blob/main/python/project-structure-and-packaging.md)_

### config.toml file
The config.toml file contains the publication parameters. Depending on the reporting months, tables, dates and any other parameters that require updating need to reflect the desired publication configuration. e.g. START_YEAR will change to the year prior to th one you are producing, YEAR will change to the year for the reporting publication, MONTHS will be the 3 months of data in the quarter the publication relates to, END_MONTH will be the last month in the quarterly period.

## Making the publication.
Running the SQL queries and table outputs can be achieved in a single step by using the `make_publication.py` code. This top-level script runs each of the sub-processes one at a time.

You can run this file by calling in Windows Powershell:
~~~
python .\NHS_staff_earnings\make_publication.py
~~~

Listed below are the sub-processes in the make_publication.py script alongside a brief explanation:

#### Import the config
When you run this code the first function to call is `get_config()`. This looks in our folder directory for the config.toml file and stores this information into a dictionary. We are then going to take out `database`, `server` etc, from the config dictionary and store them in variables (with the same name) to use later. Ensure that the parameters related to the current publication are changed e.g. `MONTHS` etc.

#### Create cutdown tables
The next step in the process runs the create_tables.sql script which produces empty temporary tables to populate with various cuts of data used throughout the process. e.g. TMP_CUTDOWN_EARNINGS_CORE_202306 which will later be populated with a subset of fields required from Earnings data for that month.

### Populate cutdown earnings tables to speed up processing
The next step in the process runs the populate_earnings_cutdown_tables.sql script which populates temporary subset tables created in the previous step with fields of data required for the publication.  

### Running the various publication table production SQL scripts
The following steps run the scripts to populate each of the temporary tables with data required for each table in the excel output. These are 'populate_table_1_and_2_tables_BPPFTE.sql', 'populate_table_1_and_2_tables.sql' and 'populate_table_3.sql'. The process cycles through each month in the quarter and organisation area (i.e. CORE NHS which refers to NHS Trusts and other core organisations, WIDER NHS which refers to NHS Support Organisations and Central Bodies).

#### Populate final earnings table used for publication production
The final SQL script run by the process populates FINAL_EARNINGS_PUBLICATION_TABLE which is stored on the SQL server. This contains data from all temporary tables produced in the previous steps which are queried to produce the 12 month averages required in the publication output. This step also drops all temporary tables as these are no longer required following this stage.

#### Populate final earnings csv text files
This step produces a dataframe containing suppressed data required for the CSV text file output. An output is printed to say how many months there are for each month which can be used as a check to ensure the file has populated correctly i.e. we would expect a similar number for each month. The dataframe is then output to a CSV text file. This process is repeated for both the CORE and WIDER NHS areas.

### Create set of dataframes which hold 12 months of data
The following steps query the FINAL_EARNINGS_PUBLICATION_TABLE and produce dataframes for the relevant annual periods needed to populate the publication tables. For example, if running the quarterly publication for June, three annual dataframes would be produced. These would be for May to April, June to May and July to June. This process is repeated for both the CORE and WIDER NHS areas.   

### Writing data into final excel files for publication
The process then uses the write_excel.py function to take a copy of the excel templates and add them to the target output folder. Each of the dataframes produced in the previous step are then written to a specified sheet. e.g. raw_dataset1_wider will be written to the Table 1 raw 1 sheet in the WIDER NHS templates. The excel templates have been set up to automatically pivot the data into the required format for publication.

