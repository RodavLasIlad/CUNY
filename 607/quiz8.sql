DROP TABLE IF EXISTS quizeight;

CREATE TABLE quizeight(
id				INT 			PRIMARY KEY,
employee		VARCHAR(255)	NOT NULL,
title			VARCHAR(255)	NOT NULL,
employer_id		INT				NOT NULL
);

INSERT INTO quizeight (id, employee, title, employer_id) 
VALUES (1, 'Steve Jobs', 'CEO', 1),
(2, 'Scott Forstall', 'SVP, IOS SOFTWARE', 1),
(3, 'Isabel Ge Mahe', 'VP IOS WIRELESS SOFTWARE', 2),
(4, 'Kim Vorrath', 'VP PROGRAM MANAGEMENT', 2),
(5, 'Peter Oppenheimer', 'SVP, CHIEF FINANCIAL OFFICER', 1),
(6, 'Betsy Rafael', 'VP CONTROLLER', 5),
(7, 'Gary Wipfler', 'VP TREASURER', 5),
(8, 'Henri Lamiraux', 'VP ENGINEERING IOS APPS', 2);

DELETE FROM quizeight
WHERE employee = 'Steve Jobs';

UPDATE quizeight
SET employer_id = 9
WHERE employer_id = 1;

INSERT INTO quizeight (id, employee, title, employer_id)
VALUES (9, 'Tim Cook', 'CEO', 9),
(10, 'Susan Wojcicki', 'CHIEF OPERATIONS OFFICER', 9),
(11, 'John Brandon', 'VP CHANNEL SALES', 10),
(12, 'Michael Fenger', 'VP IPHONE SALES', 10),
(13, 'Douglas Beck', 'VP APPLE JAPAN', 10);

SELECT * FROM quizeight;

SELECT t1.employee AS name, t2.employee AS boss
FROM quizeight t1, quizeight t2
WHERE t1.employer_id = t2.id;