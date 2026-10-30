DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS coverage_blocks;
DROP TABLE IF EXISTS carer_availability;
DROP TABLE IF EXISTS carers;

CREATE TABLE carers (
    carer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    carer_role VARCHAR(15) NOT NULL CHECK(carer_role IN('carer','senior carer')),
    maximum_hours INTEGER NOT NULL CHECK(maximum_hours BETWEEN 1 AND 60)
);

CREATE TABLE carer_availability (
    availability_id SERIAL PRIMARY KEY,
    carer_id INTEGER NOT NULL REFERENCES carers (carer_id) ON DELETE CASCADE,
    carer_available_day VARCHAR(9) NOT NULL CHECK(carer_available_day IN('monday','tuesday','wednesday','thursday','friday', 'saturday', 'sunday')) , 
    carer_start_time TIME NOT NULL ,
    carer_end_time TIME NOT NULL  CHECK (carer_end_time > carer_start_time),
    UNIQUE(carer_id, carer_available_day, carer_start_time, carer_end_time)
);

CREATE TABLE coverage_blocks (
    block_id SERIAL PRIMARY KEY,
    block_date DATE NOT NULL,
    block_start_time TIME NOT NULL,
    block_end_time TIME NOT NULL CHECK(block_end_time > block_start_time), 
    carers_required INTEGER NOT NULL CHECK(carers_required > 0),
    senior_carer_required BOOLEAN NOT NULL,
    block_label VARCHAR(9) NULL CHECK(block_label IN ('morning', 'night'))

);

CREATE TABLE assignments (
    assignment_id SERIAL PRIMARY KEY, 
    block_id INTEGER NOT NULL REFERENCES coverage_blocks (block_id) ON DELETE CASCADE,
    carer_id INTEGER NOT NULL REFERENCES carers (carer_id) ON DELETE RESTRICT,
    assigned_start_time TIME NOT NULL,
    assigned_end_time TIME NOT NULL CHECK(assigned_end_time > assigned_start_time),
    manager_confirmed_overlap BOOLEAN NOT NULL DEFAULT FALSE

);

/*
    Notes
    - carer_availability: deleted with its carer (ON DELETE CASCADE).
    - assignments: deleting a carer is blocked (RESTRICT) to protect rota history;
      deleting a block removes its assignments.
    - Assigned times must fall within the block's times; enforced in the backend, not SQL.
    - Overnight availability/blocks are not supported (end must be after start).
    - Overlapping availability slots are not prevented by the UNIQUE constraint.
*/