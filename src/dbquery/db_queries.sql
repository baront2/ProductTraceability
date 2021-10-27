CREATE TABLE measure_unit(
	measure_unit_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    measure_unit_name varchar(50) NOT NULL,
    measure_unit_symbol varchar(10) NOT NULL
);

DROP TABLE measure_unit;

INSERT INTO measure_unit (measure_unit_name, measure_unit_symbol) VALUES ("kilogramm", "kg");
INSERT INTO measure_unit (measure_unit_name, measure_unit_symbol) VALUES ("litre", "l");

SELECT * FROM measure_unit;