package Model;

import java.io.Serializable;

public class Metric implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer MetricID;
    private Integer FactorID;
    private String Name; 
    private Boolean AgrgegationFlag;
    private Integer UnitID;
    private String Description; 
    private String Granurality; //'Ide', 'Institución', 'Nodo', 'Capa', 'Servicio'


	public Integer getMetricID() {
		return MetricID;
	}


	public void setMetricID(Integer metricID) {
		MetricID = metricID;
	}


	public Integer getFactorID() {
		return FactorID;
	}


	public void setFactorID(Integer factorID) {
		FactorID = factorID;
	}


	public String getName() {
		return Name;
	}


	public void setName(String name) {
		Name = name;
	}


	public Boolean getAgrgegationFlag() {
		return AgrgegationFlag;
	}


	public void setAgrgegationFlag(Boolean agrgegationFlag) {
		AgrgegationFlag = agrgegationFlag;
	}


	public Integer getUnitID() {
		return UnitID;
	}


	public void setUnitID(Integer unitID) {
		UnitID = unitID;
	}


	public String getDescription() {
		return Description;
	}


	public void setDescription(String description) {
		Description = description;
	}


	public String getGranurality() {
		return Granurality;
	}


	public void setGranurality(String granurality) {
		Granurality = granurality;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}



    

    @Override
    public String toString() {
        return String.format("Metric[MetricID=%d, Name=%s, Granularity=%s, Description=%s, FactorID=%d, UnitID=%d, AgrgegationFlag=%s]",
        		getMetricID(), getName(), getGranurality(), getDescription(), getFactorID(), getUnitID(), getAgrgegationFlag());
    }

}
