import os 
from typing import Any, cast
import psycopg
from dotenv import load_dotenv 
from psycopg.rows import dict_row

load_dotenv()

# Gets the values from the .env file  
# os allows for scripts to access the operating system and read files 

def get_connection():
    host = os.getenv("DB_HOST")
    port = os.getenv("DB_PORT")
    dbname = os.getenv("DB_NAME")
    user = os.getenv("DB_USER")
    password = os.getenv("DB_PASSWORD")

    if not host or not port or not dbname or not user or not password:
        raise ValueError("Database settings are missing from the environment.")

    return psycopg.connect(
        host=host,
        port=int(port),
        dbname=dbname,
        user=user,
        password=password,
        row_factory=cast(Any, dict_row)
    )
    