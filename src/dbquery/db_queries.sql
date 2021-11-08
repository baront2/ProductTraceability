#Table drops
DROP TABLE measure_unit;
DROP TABLE delivery_company;
DROP TABLE courier;
DROP TABLE employee_position;
DROP TABLE qa_engineer;
DROP TABLE quality_check;
DROP TABLE raw_material;
DROP TABLE semi_component;

# Measuer Unit table
CREATE TABLE measure_unit(
	measure_unit_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    measure_unit_name VARCHAR(50) NOT NULL,
    measure_unit_symbol VARCHAR(10) NOT NULL
);

INSERT INTO measure_unit (measure_unit_name, measure_unit_symbol) VALUES ("kilogramm", "kg");
INSERT INTO measure_unit (measure_unit_name, measure_unit_symbol) VALUES ("litre", "l");
INSERT INTO measure_unit (measure_unit_name, measure_unit_symbol) VALUES ("piece", "pcs");

SELECT * FROM measure_unit;

#Delivery Company Table
CREATE TABLE delivery_company(
	delivery_company_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	delivery_company_name VARCHAR(50) NOT NULL,
	delivery_company_address VARCHAR(100) NOT NULL,
	delivery_company_phone VARCHAR(20) NOT NULL,
	delivery_company_email VARCHAR(50) NOT NULL
);

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

INSERT INTO courier (courier_name, courier_phone) VALUES ("John Doe", "0740525712");
INSERT INTO courier (courier_name, courier_phone) VALUES ("William Doe", "0702505912");

SELECT * FROM courier;

#Employee Position Table
CREATE TABLE employee_position(
	employee_position_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	employee_position VARCHAR(70) NOT NULL
);

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
    employee_position_id INT,
    CONSTRAINT fk_employee_position_id
    FOREIGN KEY (employee_position_id) 
        REFERENCES employee_position(employee_position_id),
	qa_engineer_superior_id INT
);

INSERT INTO qa_engineer(qa_engineer_name, qa_engineer_hire_date, qa_engineer_email, qa_engineer_phone, qa_engineer_superior_id)
VALUES ("John Doe", '2010-10-12', "john.doe@gmail.com", "0740512346", null);
INSERT INTO qa_engineer(qa_engineer_name, qa_engineer_hire_date, qa_engineer_email, qa_engineer_phone, qa_engineer_superior_id)
VALUES ("William Doe", '2012-07-03', "william.doe@gmail.com", "0721599316", 1);

SELECT * FROM qa_engineer;

#Quality Check Table
CREATE TABLE quality_check(
	quality_check_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	quality_check_start_date DATETIME NOT NULL,
	quality_check_end_date DATETIME NOT NULL,
	quality_check_is_acceppted BOOL NOT NULL,
	quality_check_notes VARCHAR(100) NOT NULL,
    qa_engineer_id INT NOT NULL,
	CONSTRAINT fk_qa_engineer_id
    FOREIGN KEY (qa_engineer_id) 
        REFERENCES qa_engineer(qa_engineer_id)
);

INSERT INTO quality_check(quality_check_start_date, quality_check_end_date, quality_check_is_acceppted, quality_check_notes, qa_engineer_id)
VALUES (str_to_date('2021-10-11 12:12:05', '%Y-%m-%d %H:%i:%s'), str_to_date('2021-10-11 12:47:12', '%Y-%m-%d %H:%i:%s'), true, 'iron is in good condition', 1);
INSERT INTO quality_check(quality_check_start_date, quality_check_end_date, quality_check_is_acceppted, quality_check_notes, qa_engineer_id)
VALUES (str_to_date('2021-11-02 15:10:05', '%Y-%m-%d %H:%i:%s'), str_to_date('2021-11-02 15:50:12', '%Y-%m-%d %H:%i:%s'), true, 'rubber is in good condition', 2);

SELECT * FROM quality_check;

#Raw Material Table
CREATE TABLE raw_material(
	raw_material_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	raw_material_name VARCHAR(50) NOT NULL,
	raw_material_origin VARCHAR(50) NOT NULL,
	raw_material_arrival_date DATETIME NOT NULL,
	raw_material_lot_number VARCHAR(50) NOT NULL,
    measure_unit_id INT NOT NULL,
	CONSTRAINT fk_measure_unit_id
    FOREIGN KEY (measure_unit_id) 
        REFERENCES measure_unit(measure_unit_id),
	delivery_company_id INT NOT NULL,
	CONSTRAINT fk_delivery_company_id
    FOREIGN KEY (delivery_company_id) 
        REFERENCES delivery_company(delivery_company_id),
	courier_id INT NOT NULL,
	CONSTRAINT fk_courier_id
    FOREIGN KEY (courier_id) 
        REFERENCES courier(courier_id),
	quality_check_id INT NOT NULL,
	CONSTRAINT fk_quality_check_id
    FOREIGN KEY (quality_check_id) 
        REFERENCES quality_check(quality_check_id)
);

INSERT INTO raw_material(raw_material_name, raw_material_origin, raw_material_arrival_date, raw_material_lot_number,
measure_unit_id, delivery_company_id, courier_id, quality_check_id)
VALUES ("rubber", "Germany", str_to_date('2021-02-14 13:12:01', '%Y-%m-%d %H:%i:%s'), "nr12345", 1, 1, 1, 1);

SELECT rm.raw_material_name, rm.raw_material_origin, rm.raw_material_arrival_date, rm.raw_material_lot_number,
mu.measure_unit_name, dc.delivery_company_name, c.courier_name, qa.qa_engineer_name
FROM raw_material rm JOIN measure_unit mu ON rm.measure_unit_id = mu.measure_unit_id
JOIN delivery_company dc ON rm.delivery_company_id = dc.delivery_company_id
JOIN courier c ON rm.courier_id = c.courier_id
JOIN quality_check qc ON rm.quality_check_id = qc.quality_check_id
JOIN qa_engineer qa ON qa.qa_engineer_id = qc.qa_engineer_id;

#Semi Component Table
CREATE TABLE semi_component(
	component_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	component_name VARCHAR(70) NOT NULL,
    component_arrival_date DATETIME,
	component_lot_number VARCHAR(50) NOT NULL,
    measure_unit_id INT NOT NULL,
	CONSTRAINT fkk_measure_unit_id
    FOREIGN KEY (measure_unit_id) 
        REFERENCES measure_unit(measure_unit_id),
	delivery_company_id INT,
	CONSTRAINT fkk_delivery_company_id
    FOREIGN KEY (delivery_company_id) 
        REFERENCES delivery_company(delivery_company_id),
	courier_id INT,
	CONSTRAINT fkk_courier_id
    FOREIGN KEY (courier_id) 
        REFERENCES courier(courier_id),
	quality_check_id INT,
	CONSTRAINT fkk_quality_check_id
    FOREIGN KEY (quality_check_id) 
        REFERENCES quality_check(quality_check_id)
);

INSERT INTO semi_component(component_name, component_arrival_date, component_lot_number, measure_unit_id, delivery_company_id, courier_id,
quality_check_id)
VALUES ("Transistor", str_to_date('2021-07-21 17:40:09', '%Y-%m-%d %H:%i:%s'), "nr3321ff", (select measure_unit_id from measure_unit where measure_unit_name = 'piece'),
(select delivery_company_id from delivery_company where delivery_company_name = 'FAN Courier'),
(select courier_id from courier where courier_name = 'John Doe'), 1);

SELECT * FROM semi_component;


