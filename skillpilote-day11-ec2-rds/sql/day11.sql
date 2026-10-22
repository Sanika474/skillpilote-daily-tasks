-- SkillPilote Day 11: EC2 to Amazon RDS MySQL
-- Run these statements after connecting to your RDS MySQL instance.

CREATE DATABASE IF NOT EXISTS skillpilote_test;

CREATE TABLE IF NOT EXISTS skillpilote_test.sample_records (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    note VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO skillpilote_test.sample_records (name, note)
VALUES ('Day 11 Sample', 'EC2 to RDS connection verified');

SELECT id, name, note, created_at
FROM skillpilote_test.sample_records
ORDER BY id DESC
LIMIT 5;
