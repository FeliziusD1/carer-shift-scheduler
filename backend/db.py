import os 
from dotenv import load_dotenv 

load_dotenv()

def get_connection(host ,port ,dbname ,user, password):
    host = os.getenv(DB_HOST)