from db import get_connection
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()
# API FORMS
class AssignmentCreate(BaseModel):
    block_id: int
    carer_id: int
    assigned_start_time: str
    assigned_end_time: str



# GET FUNCTION
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


@app.get("/assignments")
def list_assignments(block_id: int):
    with get_connection() as connection:
        rows = connection.execute(""" SELECT * FROM assignments WHERE block_id = %s  """, (block_id,)).fetchall()
        return rows


# POST FUNCTION 
@app.post("/assignments")
def create_assignments():
    pass