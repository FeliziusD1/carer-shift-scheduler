from db import get_connection
from fastapi import FastAPI

app = FastAPI()

@app.get("/carers") 
def list_carers():
    with get_connection() as connection:
       rows = connection.execute(""" SELECT * FROM carers """).fetchall()
       return rows


@app.get("/coverage_blocks")
def list_coverage_blocks(date: str):
     with get_connection() as connection:
         rows = connection.execute(""" SELECT * FROM coverage_blocks WHERE block_date = %s """, (date,)).fetchall()
         return rows
