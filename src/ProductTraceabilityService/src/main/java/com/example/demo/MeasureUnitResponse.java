package com.example.demo;

import java.util.Objects;

public class MeasureUnitResponse {
	private String status;
	private MeasureUnit measureUnit;
	
	public MeasureUnitResponse() {
		
	}
	
	public MeasureUnitResponse(String status, MeasureUnit measureUnit) {
		super();
		this.status = status;
		this.measureUnit = measureUnit;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public MeasureUnit getMeasureUnit() {
		return measureUnit;
	}

	public void setMeasureUnit(MeasureUnit measureUnit) {
		this.measureUnit = measureUnit;
	}

	@Override
	public int hashCode() {
		return Objects.hash(measureUnit, status);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MeasureUnitResponse other = (MeasureUnitResponse) obj;
		return Objects.equals(measureUnit, other.measureUnit) && Objects.equals(status, other.status);
	}

	@Override
	public String toString() {
		return "MeasureUnitResponse [status=" + status + ", measureUnit=" + measureUnit + "]";
	}
	
	
}
