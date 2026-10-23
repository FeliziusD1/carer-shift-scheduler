DROP TABLE IF EXISTS carers CASCADE;

CREATE TABLE carers (
    carer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    carer_role VARCHAR(15) NOT NULL CHECK(carer_role IN('carer','senior carer')),
    maximum_hours INTEGER NOT NULL CHECK(maximum_hours BETWEEN 1 AND 60)
);

