-- HireTrack ATS: business questions
-- Each query has the question it answers and the decision it helps with.


-- Q1. How many candidates are in each stage, per job? (FR-12)
-- Decision: the HR Manager sees where the pipeline is stuck.
SELECT j.title,
       a.stage,
       COUNT(*) AS candidates
FROM applications a
JOIN jobs j ON j.job_id = a.job_id
GROUP BY j.title, a.stage
ORDER BY j.title,
         CASE a.stage
             WHEN 'Applied'   THEN 1
             WHEN 'Screening' THEN 2
             WHEN 'Interview' THEN 3
             WHEN 'Offer'     THEN 4
             WHEN 'Hired'     THEN 5
             WHEN 'Rejected'  THEN 6
         END;


-- Q2. Target vs Actual: how many people did we hire compared to the target? (FR-13)
-- Decision: the HR Manager knows which jobs are still behind.
SELECT j.title,
       j.hiring_target                                      AS target,
       SUM(CASE WHEN a.stage = 'Hired' THEN 1 ELSE 0 END)   AS hired,
       j.hiring_target
         - SUM(CASE WHEN a.stage = 'Hired' THEN 1 ELSE 0 END) AS still_needed
FROM jobs j
LEFT JOIN applications a ON a.job_id = j.job_id
GROUP BY j.job_id;


-- Q3. How many days does it take to hire, per job? (FR-14)
-- Decision: the HR Manager spots jobs that take too long.
SELECT j.title,
       COUNT(*) AS hires,
       ROUND(AVG(julianday(a.hired_date) - julianday(a.applied_date)), 1) AS avg_days_to_hire
FROM applications a
JOIN jobs j ON j.job_id = a.job_id
WHERE a.stage = 'Hired'
GROUP BY j.job_id;


-- Q4. What are the hire and rejection rates per job? (FR-15)
-- Decision: the HR Manager checks if screening is too strict or too loose.
SELECT j.title,
       COUNT(*) AS applications,
       SUM(CASE WHEN a.stage = 'Hired'    THEN 1 ELSE 0 END) AS hired,
       SUM(CASE WHEN a.stage = 'Rejected' THEN 1 ELSE 0 END) AS rejected,
       ROUND(100.0 * SUM(CASE WHEN a.stage = 'Hired'    THEN 1 ELSE 0 END) / COUNT(*), 1) AS hire_rate_pct,
       ROUND(100.0 * SUM(CASE WHEN a.stage = 'Rejected' THEN 1 ELSE 0 END) / COUNT(*), 1) AS rejection_rate_pct
FROM applications a
JOIN jobs j ON j.job_id = a.job_id
GROUP BY j.job_id;


-- Q5. Which interviews have no feedback? (BR-02)
-- Decision: HR follows up with the interviewer before moving the candidate on.
SELECT c.full_name,
       j.title,
       i.interview_datetime,
       i.interviewer,
       a.stage
FROM interviews i
JOIN applications a ON a.application_id = i.application_id
JOIN candidates c   ON c.candidate_id   = a.candidate_id
JOIN jobs j         ON j.job_id         = a.job_id
WHERE i.attended = 1
  AND i.feedback IS NULL
ORDER BY i.interview_datetime;


-- Q6. Which candidates were interviewed more than once for the same job? (FR-04)
-- Decision: check if the second interview was really needed or just poor coordination.
SELECT c.full_name,
       j.title,
       COUNT(*) AS interviews
FROM interviews i
JOIN applications a ON a.application_id = i.application_id
JOIN candidates c   ON c.candidate_id   = a.candidate_id
JOIN jobs j         ON j.job_id         = a.job_id
GROUP BY a.application_id
HAVING COUNT(*) > 1;
