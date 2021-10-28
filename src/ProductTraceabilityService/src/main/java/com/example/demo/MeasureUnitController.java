package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;

@RestController
@RequestMapping("/traceability")
public class MeasureUnitController {
	@Autowired
	MeasureUnitService service;

	@GetMapping("/measureUnits")
	public MeasureUnitsResponse list() {
		List<MeasureUnit> units = service.listAllMeasureUnit();
		return new MeasureUnitsResponse("succes", Long.valueOf(units.size()), units);
	}

	@GetMapping("measureUnit/{id}")
	public ResponseEntity<MeasureUnitResponse> get(@PathVariable Long id) {
		MeasureUnitResponse response = new MeasureUnitResponse();
		try {
			MeasureUnit unit = service.getMeasureUnit(id);
			response.setStatus("succes");
			response.setMeasureUnit(unit);
			return new ResponseEntity<MeasureUnitResponse>(response, HttpStatus.OK);
		} catch (NoSuchElementException e) {
			response.setStatus("failed");
			return new ResponseEntity<MeasureUnitResponse>(response, HttpStatus.NOT_FOUND);
		}
	}

	@PostMapping("/measureUnit")
	public MeasureUnitResponse add(@RequestBody MeasureUnit unit) {
		service.addMeasureUnit(unit);
		return new MeasureUnitResponse("succes", unit);
	}

	@PutMapping("/measureUnit/{id}")
	public ResponseEntity<MeasureUnitResponse>update(@RequestBody MeasureUnit unit, @PathVariable Long id) {
		MeasureUnitResponse response = new MeasureUnitResponse();
		try {
			MeasureUnit existUnit = service.getMeasureUnit(id);
			unit.setMeasureUnitId(id);
			service.addMeasureUnit(unit);
			response.setStatus("succes");
			response.setMeasureUnit(unit);
			return new ResponseEntity<MeasureUnitResponse>(response, HttpStatus.OK);
		} catch (NoSuchElementException e) {
			response.setStatus("failed");
			return new ResponseEntity<MeasureUnitResponse>(response, HttpStatus.NOT_FOUND);
		}
	}

	@DeleteMapping(value = "/measureUnit/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
	public Map<String, String> delete(@PathVariable Long id) {
		try {
			service.deleteMeasureUnit(id);
			String msg = "Measure unit with id: " + id + " was deleted succesfully";
			return Collections.singletonMap("message", msg);
		}
		catch (EmptyResultDataAccessException e){
			String msg = "Measure unit with the given id does not exists";
			return Collections.singletonMap("message", msg);
		}
	}
}
