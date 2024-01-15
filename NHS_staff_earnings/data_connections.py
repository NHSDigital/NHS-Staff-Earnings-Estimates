import sqlalchemy as sa
import pandas as pd
import logging
from helpers import get_config
from pathlib import Path
from sqlalchemy import text

logger = logging.getLogger(__name__)

def make_connection (server, database):
    """
    Use sqlalchemy to make a connection to the SQL server and database with the help
    of mssql and pyodbc packages

    Inputs:
        server: server to connect to
        database: database to connect to
    
    Output:
        None
    """
    conn = sa.create_engine(f"mssql+pyodbc://{server}/{database}?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes", fast_executemany=True)
    conn.execution_options(autocommit=True)

    return conn

def make_wesr_conn ():

    config = get_config()

    WESR_conn = make_connection(server = config['server'], database = config['database'])

    return WESR_conn

    
def check_table_exists(table_name):
    """
    Use sql alchemy inspect to check if a specified table exists in a database

    Inputs:
        table_name: name of the SQL table you want to check exists
 
    Outputs:
        Prints 'True' if exists and 'False' if doesn't exist
    """
    wesr_conn = make_wesr_conn()
    insp = sa.inspect(wesr_conn)
    
    print(insp.has_table(table_name=table_name, schema="dbo")) 

def get_df_from_sql(query, conn) -> pd.DataFrame:
    """
    Use sqlalchemy to connect to the NHSD server and database with the help
    of mssql and pyodbc packages, and execute the SQL query to get a pandas dataframe.

    Inputs:
        query: string containing a sql query
        conn: SQLAlchemy engine connection to the SQL database - defaults to WESR database unless specified

    Output:
        pandas Dataframe
    """
    df = pd.read_sql_query(query,conn) 

    return df

def read_in_sql_query(sql_file_path: str) -> str:
    
    """Reads in a SQL query file with parameters and fills them with the values provided in the sql_parameters dictionary

    Inputs:
        sql_file_path: the path to the file with query 
        
    Output:
        SQL query loaded up with parameters for the publication
    """

    with open(sql_file_path,'r') as sql_file:
            sql_query = sql_file.read()

    return sql_query

def execute_sql(query, conn):
    """
    Use sqlalchemy to connect to the SQL server and database with the help
    of mssql and pyodbc packages to execute a SQL query

    Inputs:
        query: string containing a sql query
        conn: SQLAlchemy engine connection to the SQL database - defaults to WESR database unless specified

    Output:
        None
    """
    with conn.connect() as connection:
        connection.execute(text(query))
        #connection.commit()

    print("SQL query run successfully.")

def write_df_to_sql_table(df, table_name, conn):
    """
    Use pandas to_sql method to write the dataframe to the specified SQL table

    Inputs:
        df: pandas dataframe containing the data to be written
        table_name: name of the SQL table to write the data to
        conn: SQLAlchemy engine connection to the SQL database - defaults to WESR database unless specified
        """
    df.to_sql(table_name, conn, if_exists='replace', index=False)
