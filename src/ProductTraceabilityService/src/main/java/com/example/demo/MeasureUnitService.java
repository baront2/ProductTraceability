package com.example.demo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MeasureUnitService {
	@Autowired
	private MeasureUnitRepository repository;

	public List<MeasureUnit> listAllMeasureUnit() {
		return repository.findAll();
	}

	public void addMeasureUnit(MeasureUnit measureUnit) {
		repository.save(measureUnit);
	}

	public MeasureUnit getMeasureUnit(Long id) {
		return repository.findById(id).get();
	}

	public void deleteMeasureUnit(Long id) {
		repository.deleteById(id);
	}
}
