DROP TABLE IF EXISTS carers CASCADE;

CREATE TABLE carers (
    carer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    carer_role VARCHAR(15) NOT NULL CHECK(carer_role IN('carer','senior carer')),
    maximum_hours INTEGER NOT NULL CHECK(maximum_hours BETWEEN 1 AND 60)
);

CREATE TABLE availability (
    availability_id SERIAL PRIMARY KEY,
    carer_id INTEGER NOT NULL REFERENCES carers (carer_id),
    carer_available_day VARCHAR(9) NOT NULL CHECK(carer_available_day IN('monday','tuesday','wednesday','thursday','friday', 'saturday', 'sunday')) , 
    carer_start_time TIME NOT NULL ,
    carer_end_time TIME NOT NULL  CHECK (carer_end_time > carer_start_time),
    UNIQUE(carer_id, carer_available_day, carer_start_time, carer_end_time)
);

