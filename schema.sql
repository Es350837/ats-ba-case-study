-- HireTrack ATS: database schema
-- Simulated BA case study. Written for SQLite
-- (works in DB Browser for SQLite or any online SQLite editor).

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS interviews;
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS candidates;
DROP TABLE IF EXISTS jobs;

-- Jobs the company is hiring for (FR-08)
CREATE TABLE jobs (
    job_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    title           TEXT    NOT NULL,
    department      TEXT    NOT NULL,
    hiring_manager  TEXT    NOT NULL,   -- used for NFR-03: a manager only sees his own jobs
    hiring_target   INTEGER NOT NULL CHECK (hiring_target > 0),   -- how many people we need (FR-13)
    status          TEXT    NOT NULL DEFAULT 'Open' CHECK (status IN ('Open', 'Closed')),
    opened_date     DATE    NOT NULL
);

-- People who applied. One row per person, even if they apply to more than one job.
CREATE TABLE candidates (
    candidate_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name       TEXT    NOT NULL,
    email           TEXT    UNIQUE,
    phone           TEXT    UNIQUE,
    cv_link         TEXT,
    is_archived     INTEGER NOT NULL DEFAULT 0 CHECK (is_archived IN (0, 1)),   -- archive instead of delete (FR-17)
    -- Assumption: every candidate has an email or a phone number
    CHECK (email IS NOT NULL OR phone IS NOT NULL)
);

-- A candidate applying to a job, and the stage he is in now (FR-09)
CREATE TABLE applications (
    application_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    candidate_id      INTEGER NOT NULL REFERENCES candidates (candidate_id),
    job_id            INTEGER NOT NULL REFERENCES jobs (job_id),
    stage             TEXT    NOT NULL DEFAULT 'Applied'
                      CHECK (stage IN ('Applied', 'Screening', 'Interview', 'Offer', 'Hired', 'Rejected')),
    rejection_reason  TEXT,
    applied_date      DATE    NOT NULL,
    hired_date        DATE,             -- used to calculate Time to Hire (FR-14)

    -- BR-01: the same candidate can't apply to the same job twice
    UNIQUE (candidate_id, job_id),
    -- BR-03 / FR-10: a rejection must have a reason
    -- (an offer that was declined is saved as Rejected with the reason "Offer declined")
    CHECK (stage <> 'Rejected' OR rejection_reason IS NOT NULL),
    -- hired_date is filled only when the stage is Hired
    CHECK ((stage = 'Hired') = (hired_date IS NOT NULL))
);

-- Interviews, with attendance (FR-11) and feedback (FR-05)
CREATE TABLE interviews (
    interview_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    application_id      INTEGER  NOT NULL REFERENCES applications (application_id),
    interview_datetime  DATETIME NOT NULL,
    interviewer         TEXT,
    attended            INTEGER  CHECK (attended IN (0, 1)),   -- empty until the interview happens, 1 = came, 0 = no-show
    feedback            TEXT,

    -- FR-04: no two interviews at the same time for the same application
    UNIQUE (application_id, interview_datetime),
    -- no feedback for someone who didn't come
    CHECK (feedback IS NULL OR attended = 1)
);

-- BR-02 (move to the next stage only after feedback) is checked by the application,
-- because it depends on the stage change and not on one row.
