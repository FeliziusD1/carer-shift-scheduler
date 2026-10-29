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

/* 
    -ON DELETE CASCADE means deleting a carer also deletes their availability rows. 
    That makes sense if availability has no use without its carer.

    -You drop carer_availability before carers, which is the right order. Because of that, CASCADE on DROP TABLE carers isn't needed right now. 
    What might it accidentally remove if you later add other tables that reference carers?

    -Your UNIQUE constraint blocks an exact duplicate slot for the same carer, but still allows overlapping slots. 
    For example, Monday 08:00–16:00 and Monday 08:00–12:00 are both allowed.

    -The time check disallows overnight availability, such as 22:00–06:00. That's fine if you don't need overnight shifts yet.

*/