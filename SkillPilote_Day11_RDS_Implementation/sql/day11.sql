-- Day 11 demonstration SQL. Run from the EC2 instance to the RDS endpoint.
CREATE DATABASE IF NOT EXISTS skillpilote_demo;
USE skillpilote_demo;

CREATE TABLE IF NOT EXISTS practical_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO practical_records (message)
VALUES ('Day 11 EC2 to RDS connection test');

SELECT id, message, created_at
FROM practical_records
ORDER BY id DESC
LIMIT 5;
