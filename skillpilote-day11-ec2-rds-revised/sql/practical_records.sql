-- SkillPilote Day 11: EC2 to Amazon RDS MySQL
USE skillpilote_db;

CREATE TABLE IF NOT EXISTS practical_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100),
    practical_name VARCHAR(150)
);

-- Execute this INSERT only once if you want exactly one sample row.
INSERT INTO practical_records (student_name, practical_name)
VALUES ('Student', 'EC2 to RDS Connection');

SELECT * FROM practical_records;
