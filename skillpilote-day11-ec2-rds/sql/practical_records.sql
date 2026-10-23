-- SkillPilote: EC2 to Amazon RDS MySQL practical
-- Run after connecting to RDS as a user with database/table permissions.
-- The table name and sample values match the successful practical output.

USE skillpilote_db;

CREATE TABLE IF NOT EXISTS practical_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100),
    practical_name VARCHAR(150)
);

-- Run this INSERT once for the evidence row; rerunning adds another row.
INSERT INTO practical_records (student_name, practical_name)
VALUES ('Student', 'EC2 to RDS Connection');

SELECT * FROM practical_records;
