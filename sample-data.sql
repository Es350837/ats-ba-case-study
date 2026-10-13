-- HireTrack ATS: sample data
-- All names and contacts are made up (simulated case study).
-- A few gaps are on purpose (repeated interviews, missing feedback),
-- because these are the problems found in the research.

PRAGMA foreign_keys = ON;

INSERT INTO jobs (job_id, title, department, hiring_manager, hiring_target, status, opened_date) VALUES
(1, 'Accountant',      'Finance', 'Khaled', 3, 'Open',   '2026-09-01'),
(2, 'Account Manager', 'Sales',   'Hany',   1, 'Closed', '2026-09-01');

INSERT INTO candidates (candidate_id, full_name, email, phone, cv_link) VALUES
(1,  'Omar Hassan',     'omar.hassan@example.com',     '01000000001', 'cv/omar-hassan.pdf'),
(2,  'Nour Ibrahim',    'nour.ibrahim@example.com',    '01000000002', 'cv/nour-ibrahim.pdf'),
(3,  'Youssef Adel',    'youssef.adel@example.com',    '01000000003', 'cv/youssef-adel.pdf'),
(4,  'Salma Mahmoud',   'salma.mahmoud@example.com',   '01000000004', 'cv/salma-mahmoud.pdf'),
(5,  'Karim Samir',     'karim.samir@example.com',     '01000000005', 'cv/karim-samir.pdf'),
(6,  'Mariam Tarek',    'mariam.tarek@example.com',    '01000000006', 'cv/mariam-tarek.pdf'),
(7,  'Ahmed Fathy',     'ahmed.fathy@example.com',     '01000000007', 'cv/ahmed-fathy.pdf'),
(8,  'Laila Sherif',    'laila.sherif@example.com',    '01000000008', 'cv/laila-sherif.pdf'),
(9,  'Tamer Nabil',     'tamer.nabil@example.com',     '01000000009', 'cv/tamer-nabil.pdf'),
(10, 'Rana Khaled',     'rana.khaled@example.com',     '01000000010', 'cv/rana-khaled.pdf'),
(11, 'Mostafa Gamal',   'mostafa.gamal@example.com',   '01000000011', 'cv/mostafa-gamal.pdf'),
(12, 'Dina Ashraf',     'dina.ashraf@example.com',     '01000000012', 'cv/dina-ashraf.pdf'),
(13, 'Hossam Wael',     'hossam.wael@example.com',     '01000000013', 'cv/hossam-wael.pdf'),
(14, 'Farah Essam',     'farah.essam@example.com',     '01000000014', 'cv/farah-essam.pdf'),
(15, 'Bassem Osama',    'bassem.osama@example.com',    '01000000015', 'cv/bassem-osama.pdf');

-- Applications: 8 for Accountant, 7 for Account Manager
INSERT INTO applications (application_id, candidate_id, job_id, stage, rejection_reason, applied_date, hired_date) VALUES
(1,  1,  1, 'Hired',     NULL,                                   '2026-09-02', '2026-09-24'),
(2,  2,  1, 'Hired',     NULL,                                   '2026-09-03', '2026-09-28'),
(3,  3,  1, 'Offer',     NULL,                                   '2026-09-03', NULL),
(4,  4,  1, 'Rejected',  'Weak technical interview',             '2026-09-04', NULL),
(5,  5,  1, 'Rejected',  'Does not meet minimum experience',     '2026-09-05', NULL),
(6,  6,  1, 'Rejected',  'Salary expectations too high',         '2026-09-06', NULL),
(7,  7,  1, 'Interview', NULL,                                   '2026-09-18', NULL),
(8,  8,  1, 'Screening', NULL,                                   '2026-09-20', NULL),
(9,  9,  2, 'Hired',     NULL,                                   '2026-09-04', '2026-09-30'),
(10, 10, 2, 'Offer',     NULL,                                   '2026-09-05', NULL),
(11, 11, 2, 'Rejected',  'Did not attend the interview',         '2026-09-06', NULL),
(12, 12, 2, 'Rejected',  'Does not meet minimum experience',     '2026-09-07', NULL),
(13, 13, 2, 'Rejected',  'Relocation not possible',              '2026-09-08', NULL),
(14, 14, 2, 'Interview', NULL,                                   '2026-09-19', NULL),
(15, 15, 2, 'Applied',   NULL,                                   '2026-09-21', NULL);

-- Interviews
-- Applications 1, 3 and 9 had two interviews (repeated because of poor coordination).
-- Applications 3, 4, 7, 10 and 14 attended an interview but have no feedback.
INSERT INTO interviews (application_id, interview_datetime, interviewer, attended, feedback) VALUES
(1,  '2026-09-10 10:00', 'Khaled', 1, 'Strong technical answers, good fit'),
(1,  '2026-09-17 11:00', 'Khaled', 1, 'Second round, confirmed the first impression'),
(2,  '2026-09-11 12:00', 'Khaled', 1, 'Good experience, communicates clearly'),
(3,  '2026-09-12 10:00', 'Khaled', 1, NULL),
(3,  '2026-09-19 10:00', 'Khaled', 1, NULL),
(4,  '2026-09-12 13:00', 'Khaled', 1, NULL),
(7,  '2026-09-30 11:00', 'Khaled', 1, NULL),
(9,  '2026-09-14 10:00', 'Hany',   1, 'Good client skills'),
(9,  '2026-09-21 10:00', 'Hany',   1, 'Final round, strong answers'),
(10, '2026-09-15 14:00', 'Hany',   1, NULL),
(11, '2026-09-15 11:00', 'Hany',   0, NULL),
(14, '2026-10-01 10:00', 'Hany',   1, NULL);
