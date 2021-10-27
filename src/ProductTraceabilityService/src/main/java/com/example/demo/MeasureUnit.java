package com.example.demo;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "measure_unit")
public class MeasureUnit {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long measureUnitId;
	private String measureUnitName;
	private String measureUnitSymbol;

	MeasureUnit() {
	}

	MeasureUnit(Long measureUnitId, String measureUnitName, String measureUnitSymbol) {
		this.measureUnitId = measureUnitId;
		this.measureUnitName = measureUnitName;
		this.measureUnitSymbol = measureUnitSymbol;
	}

	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public Long getMeasureUnitId() {
		return this.measureUnitId;
	}

	public String getMeasureUnitName() {
		return this.measureUnitName;
	}

	public String getMeasureUnitSymbol() {
		return this.measureUnitSymbol;
	}

	public void setMeasureUnitId(Long id) {
		this.measureUnitId = id;
	}

	public void setMeasureUnitName(String name) {
		this.measureUnitName = name;
	}

	public void setMeasureUnitSymbol(String symbol) {
		this.measureUnitSymbol = symbol;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (!(o instanceof MeasureUnit))
			return false;
		MeasureUnit measureUnit = (MeasureUnit) o;
		return Objects.equals(this.measureUnitId, measureUnit.measureUnitId)
				&& Objects.equals(this.measureUnitName, measureUnit.measureUnitName)
				&& Objects.equals(this.measureUnitSymbol, measureUnit.measureUnitSymbol);
	}

	@Override
	public int hashCode() {
		return Objects.hash(this.measureUnitId, this.measureUnitName, this.measureUnitSymbol);
	}

	@Override
	public String toString() {
		return "MeasureUnit [measureUnitId=" + measureUnitId + ", measureUnitName=" + measureUnitName
				+ ", measureUnitSymbol=" + measureUnitSymbol + "]";
	}
}
