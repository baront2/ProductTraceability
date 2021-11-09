#Table drops
DROP TABLE measure_unit;
DROP TABLE delivery_company;
DROP TABLE courier;
DROP TABLE employee_position;
DROP TABLE qa_engineer;
DROP TABLE quality_check;
DROP TABLE raw_material;
DROP TABLE semi_component;
DROP TABLE product_quality;
DROP TABLE product;
DROP TABLE process_type;
DROP TABLE component_process;
DROP TABLE processing;
DROP TABLE process_raw_material;
DROP TABLE process_component;
DROP TABLE machine;
DROP TABLE machine_operator;

#Measuer Unit table
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
VALUES ("rubber", "Germany", str_to_date('2021-02-14 13:12:01', '%Y-%m-%d %H:%i:%s'), "nr12345", 
(SELECT measure_unit_id FROM measure_unit WHERE measure_unit_name = 'kilogramm'), 
(SELECT delivery_company_id FROM delivery_company WHERE delivery_company_name = 'FAN Courier'), 
(SELECT courier_id FROM courier WHERE courier_name = 'John Doe'), 
1);

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
VALUES ("Transistor", str_to_date('2021-07-21 17:40:09', '%Y-%m-%d %H:%i:%s'), "nr3321ff", (SELECT measure_unit_id FROM measure_unit WHERE measure_unit_name = 'piece'),
(SELECT delivery_company_id FROM delivery_company WHERE delivery_company_name = 'FAN Courier'),
(SELECT courier_id FROM courier WHERE courier_name = 'John Doe'), 1);

INSERT INTO semi_component(component_name, component_arrival_date, component_lot_number, measure_unit_id, delivery_company_id, courier_id,
quality_check_id)
VALUES ("Melted Rubber", null, "nr3322ff", (SELECT measure_unit_id FROM measure_unit WHERE measure_unit_name = 'piece'),
null, null, null);

SELECT * FROM semi_component;

#Product Quality Table
CREATE TABLE product_quality(
	product_quality_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	product_quality_type VARCHAR(50) NOT NULL
);

INSERT INTO product_quality(product_quality_type) VALUE ("EXCELLENT");
INSERT INTO product_quality(product_quality_type) VALUE ("GOOD");
INSERT INTO product_quality(product_quality_type) VALUE ("ACCEPTABLE");
INSERT INTO product_quality(product_quality_type) VALUE ("BAD");

SELECT * FROM product_quality;

#Product Table
CREATE TABLE product(
	product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	product_warranty_start DATETIME NOT NULL,
	product_warranty_end DATETIME NOT NULL,
	product_quality_id INT NOT NULL,
	CONSTRAINT fkkk_quality_check_id
    FOREIGN KEY (product_quality_id) 
        REFERENCES product_quality(product_quality_id),
	measure_unit_id INT NOT NULL,
	CONSTRAINT fk_measure_unit
    FOREIGN KEY (measure_unit_id) 
        REFERENCES measure_unit(measure_unit_id)
);

INSERT INTO product(product_name, product_warranty_start, product_warranty_end, product_quality_id, measure_unit_id)
VALUES ("Laptop Dell Vostro 3510", str_to_date('2021-07-21 17:40:09', '%Y-%m-%d %H:%i:%s'), str_to_date('2023-07-21 17:40:09', '%Y-%m-%d %H:%i:%s'),
(SELECT product_quality_id FROM product_quality WHERE product_quality_type = 'EXCELLENT'),
(SELECT measure_unit_id FROM measure_unit WHERE measure_unit_name = 'piece'));

SELECT * FROM product;

#Process Type Table
CREATE TABLE process_type(
	process_type_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	process_type VARCHAR(50) NOT NULL
);

INSERT INTO process_type(process_type) VALUE ("COMPONENT ASSEMBLY");
INSERT INTO process_type(process_type) VALUE ("WRAPPING");
INSERT INTO process_type(process_type) VALUE ("MELTING");

SELECT * FROM process_type;

#Component Process Table
CREATE TABLE component_process(
	component_process_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	component_process_name VARCHAR(50) NOT NULL,
	process_type_id INT,
	CONSTRAINT fk_process_type_id
    FOREIGN KEY (process_type_id) 
        REFERENCES process_type(process_type_id),
    component_process_parameters VARCHAR(50) NOT NULL
);

INSERT INTO component_process(component_process_name, process_type_id, component_process_parameters)
VALUES ("Rubber preprocessing", (SELECT process_type_id FROM process_type WHERE process_type = 'MELTING'), "Degree: 400°C");

SELECT * FROM component_process;

#Processing Table
CREATE TABLE processing(
	processing_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	processing_start_date DATETIME NOT NULL,
	processing_end_date DATETIME NOT NULL,
	component_process_id INT NOT NULL,
	CONSTRAINT fk_component_process_id
    FOREIGN KEY (component_process_id) 
        REFERENCES component_process(component_process_id),
	semi_component_id INT,
    CONSTRAINT fk_semi_component_id
    FOREIGN KEY (semi_component_id) 
        REFERENCES semi_component(component_id),
	product_id INT,
    CONSTRAINT fk_product_id
    FOREIGN KEY (product_id) 
        REFERENCES product(product_id)
);

INSERT INTO processing(processing_start_date, processing_end_date, component_process_id, semi_component_id, product_id)
VALUES (str_to_date('2021-08-12 12:31:09', '%Y-%m-%d %H:%i:%s'), str_to_date('2021-08-14 17:40:09', '%Y-%m-%d %H:%i:%s'),
(SELECT component_process_id FROM component_process WHERE component_process_name = 'Rubber preprocessing'),
(SELECT component_id FROM semi_component WHERE component_name = 'Melted Rubber'),
null);

SELECT * FROM processing;

#Process's Raw Materials
CREATE TABLE process_raw_material(
	process_raw_material_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    raw_material_id INT NOT NULL,
    CONSTRAINT fk_raw_material_id
    FOREIGN KEY (raw_material_id) 
        REFERENCES raw_material(raw_material_id),
	processing_id INT NOT NULL,
    CONSTRAINT fk_processing_id
    FOREIGN KEY (processing_id) 
        REFERENCES processing(processing_id)
);

INSERT INTO process_raw_material(raw_material_id, processing_id)
VALUES ((SELECT raw_material_id FROM raw_material WHERE raw_material_name = 'Rubber'), 1)

SELECT * FROM process_raw_material;

#Test query for raw materiall preprocessing
SELECT pr.processing_id, sc.component_name, rm.raw_material_name, cp.component_process_name, pt.process_type
FROM processing pr JOIN process_raw_material prw
ON pr.processing_id = prw.processing_id
JOIN raw_material rm ON rm.raw_material_id = prw.raw_material_id
JOIN semi_component sc ON sc.component_id = pr.semi_component_id
JOIN component_process cp ON cp.component_process_id = pr.component_process_id
JOIN process_type pt ON pt.process_type_id = cp.process_type_id;

#Process's Components
CREATE TABLE process_component(
	process_component_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    component_id INT NOT NULL,
    CONSTRAINT fk_component_id
    FOREIGN KEY (component_id) 
        REFERENCES semi_component(component_id),
	processing_id INT NOT NULL,
    CONSTRAINT fkk_processing_id
    FOREIGN KEY (processing_id) 
        REFERENCES processing(processing_id)
);

#Machine Table
CREATE TABLE machine(
	machine_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	machine_name VARCHAR(50) NOT NULL,
	machine_capacity LONG NOT NULL,
	machine_last_revisioned DATETIME NOT NULL,
	machine_warranty_start DATETIME NOT NULL,
	machine_warranty_end DATETIME NOT NULL
);

INSERT INTO machine(machine_name, machine_capacity, machine_last_revisioned, machine_warranty_start, machine_warranty_end)
VALUE ("Gold Melting Furnance", 10000, str_to_date('2020-01-23 10:00:00', '%Y-%m-%d %H:%i:%s'),
str_to_date('2005-04-10 10:00:00', '%Y-%m-%d %H:%i:%s'), str_to_date('2009-04-10 10:00:00', '%Y-%m-%d %H:%i:%s'));

SELECT * FROM machine;

#Machine Operator Table
CREATE TABLE machine_operator(
	machine_operator_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	machine_operator_name VARCHAR(50) NOT NULL,
	machine_operator_hire_date DATETIME NOT NULL,
	machine_operator_email  VARCHAR(50) NOT NULL,
	machine_operator_phone  VARCHAR(20) NOT NULL,
	machine_operator_superior_id  INT
);

INSERT INTO machine_operator(machine_operator_name, machine_operator_hire_date, machine_operator_email, machine_operator_phone,
machine_operator_superior_id)
VALUES ("John Doe", str_to_date('2010-07-12 09:00:00', '%Y-%m-%d %H:%i:%s'), "jdoe@gmail.com", "07402111111", null);

INSERT INTO machine_operator(machine_operator_name, machine_operator_hire_date, machine_operator_email, machine_operator_phone,
machine_operator_superior_id)
VALUES ("William Doe", str_to_date('2012-08-02 09:00:00', '%Y-%m-%d %H:%i:%s'), "wdoe@gmail.com", "07402333311", 1);

SELECT * FROM machine_operator;


