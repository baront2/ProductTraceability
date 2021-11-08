# Measuer Unit table
CREATE TABLE measure_unit(
	measure_unit_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    measure_unit_name VARCHAR(50) NOT NULL,
    measure_unit_symbol VARCHAR(10) NOT NULL
);

DROP TABLE measure_unit;

INSERT INTO measure_unit (measure_unit_name, measure_unit_symbol) VALUES ("kilogramm", "kg");
INSERT INTO measure_unit (measure_unit_name, measure_unit_symbol) VALUES ("litre", "l");

SELECT * FROM measure_unit;

#Delivery Company Table
CREATE TABLE delivery_company(
	delivery_company_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	delivery_company_name VARCHAR(50) NOT NULL,
	delivery_company_address VARCHAR(100) NOT NULL,
	delivery_company_phone VARCHAR(20) NOT NULL,
	delivery_company_email VARCHAR(50) NOT NULL
);

DROP TABLE delivery_company;

INSERT INTO delivery_company (delivery_company_name, delivery_company_address, delivery_company_phone, delivery_company_email)
VALUES ("FAN Courier", "Str Praidului 108, Sovata, Mures, 545500", "0732119212", "fan.courier@gmail.com");
INSERT INTO delivery_company (delivery_company_name, delivery_company_address, delivery_company_phone, delivery_company_email)
VALUES ("DPDgroup", "Str Lunga 36, Albesti, Mures, 5477025", "0722699733", "dpd.group@gmail.com");

SELECT * FROM delivery_company;

#Courier Table
CREATE TABLE courier(
	courier_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	courier_name VARCHAR(50) NOT NULL,
	courier_phone VARCHAR(20) NOT NULL
);

DROP TABLE courier;

INSERT INTO courier (courier_name, courier_phone) VALUES ("John Doe", "0740525712");
INSERT INTO courier (courier_name, courier_phone) VALUES ("William Doe", "0702505912");

SELECT * FROM courier;

#Employee Position Table
CREATE TABLE employee_position(
	employee_position_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	employee_position VARCHAR(70) NOT NULL
);

DROP TABLE employee_position;

INSERT INTO employee_position(employee_position) VALUES ("Senior QA Engineer");
INSERT INTO employee_position(employee_position) VALUES ("QA Analist");

SELECT * FROM employee_position;

#QA Engineer Table
CREATE TABLE qa_engineer(
	qa_engineer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	qa_engineer_name VARCHAR(50) NOT NULL,
	qa_engineer_hire_date DATE NOT NULL,
	qa_engineer_email VARCHAR(70) NOT NULL,
	qa_engineer_phone VARCHAR(20) NOT NULL,
	qa_engineer_superior_id INT
);

DROP TABLE qa_engineer;

INSERT INTO qa_engineer(qa_engineer_name, qa_engineer_hire_date, qa_engineer_email, qa_engineer_phone, qa_engineer_superior_id)
VALUES ("John Doe", '2010-10-12', "john.doe@gmail.com", "0740512346", null);
INSERT INTO qa_engineer(qa_engineer_name, qa_engineer_hire_date, qa_engineer_email, qa_engineer_phone, qa_engineer_superior_id)
VALUES ("William Doe", '2012-07-03', "william.doe@gmail.com", "0721599316", 1);

SELECT * FROM qa_engineer;

#Quality Check Table

