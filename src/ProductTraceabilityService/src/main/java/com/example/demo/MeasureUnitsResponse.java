package com.example.demo;

import java.util.List;
import java.util.Objects;

public class MeasureUnitsResponse {
	private String status;
	private Long totalItems;
	private List<MeasureUnit> measureUnits;
	
	public MeasureUnitsResponse() {
		
	}
	
	public MeasureUnitsResponse(String status, Long totalItems, List<MeasureUnit> measureUnits) {
		super();
		this.status = status;
		this.totalItems = totalItems;
		this.measureUnits = measureUnits;
	}

	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Long getTotalItems() {
		return totalItems;
	}
	
	public void setTotalItems(Long totalItems) {
		this.totalItems = totalItems;
	}
	
	public List<MeasureUnit> getMeasureUnits() {
		return measureUnits;
	}
	
	public void setMeasureUnits(List<MeasureUnit> measureUnits) {
		this.measureUnits = measureUnits;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(measureUnits, status, totalItems);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		MeasureUnitsResponse other = (MeasureUnitsResponse) obj;
		return Objects.equals(measureUnits, other.measureUnits) && Objects.equals(status, other.status)
				&& Objects.equals(totalItems, other.totalItems);
	}

	@Override
	public String toString() {
		return "MeasureUnitResponse [status=" + status + ", totalItems=" + totalItems + ", measureUnits=" + measureUnits
				+ "]";
	}
}
