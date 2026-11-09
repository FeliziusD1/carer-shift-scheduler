from db import get_connection
from fastapi import FastAPI

app = FastAPI()

@app.get("/carers") 
def list_carers():
    with get_connection() as connection:
       rows = connection.execute(""" SELECT * FROM carers """).fetchall()
       return rows


## Needs fixing
@app.get("/coverage-blocks?date=yyyy=mm-dd")
def load_coverage_block(date):
    with get_connection() as connection:
        rows = connection.execute(""" SELECT * FROM coverage_blocks """).fetchall()
        return rows
