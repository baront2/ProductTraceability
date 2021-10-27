package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/traceability")
public class MeasureUnitController {
	@Autowired
	MeasureUnitService service;

	@GetMapping("/measureUnits")
	public List<MeasureUnit> list() {
		return service.listAllMeasureUnit();
	}

	@GetMapping("measureUnit/{id}")
	public ResponseEntity<MeasureUnit> get(@PathVariable Long id) {
		try {
			MeasureUnit unit = service.getMeasureUnit(id);
			return new ResponseEntity<MeasureUnit>(unit, HttpStatus.OK);
		} catch (NoSuchElementException e) {
			return new ResponseEntity<MeasureUnit>(HttpStatus.NOT_FOUND);
		}
	}

	@PostMapping("/measureUnit")
	public void add(@RequestBody MeasureUnit unit) {
		service.addMeasureUnit(unit);
	}

	@PutMapping("/measureUnit/{id}")
	public ResponseEntity<?> update(@RequestBody MeasureUnit unit, @PathVariable Long id) {
		try {
			MeasureUnit existUnit = service.getMeasureUnit(id);
			unit.setMeasureUnitId(id);
			service.addMeasureUnit(unit);
			return new ResponseEntity<>(HttpStatus.OK);
		} catch (NoSuchElementException e) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
	}

	@DeleteMapping("/measureUnit/{id}")
	public void delete(@PathVariable Long id) {
		service.deleteMeasureUnit(id);
	}
}
