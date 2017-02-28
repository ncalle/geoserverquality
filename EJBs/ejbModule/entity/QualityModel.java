package entity;

import java.io.Serializable;

/**
 * Modelo que representa el Modelo de Calidad.
 * Puede ser usada a travez de todas las capas, capa de datos, controlador o vista
 */
public class QualityModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer QualityModelID;
    private String QualityModelName;
    private Integer DimensionID;
    private String DimensionName;
    private Integer FactorID;
    private String FactorName;
    private Integer MetricID;
    private String MetricName;
    private Boolean MetricAgrgegationFlag;
    private String MetricGranurality;
    private String MetricDescription;
    private Integer UnitID;
    private String UnitName;
    private String UnitDescription;

	public Integer getQualityModelID() {
		return QualityModelID;
	}

	public void setQualityModelID(Integer qualityModelID) {
		QualityModelID = qualityModelID;
	}

	public String getQualityModelName() {
		return QualityModelName;
	}

	public void setQualityModelName(String qualityModelName) {
		QualityModelName = qualityModelName;
	}

	public Integer getDimensionID() {
		return DimensionID;
	}

	public void setDimensionID(Integer dimensionID) {
		DimensionID = dimensionID;
	}

	public String getDimensionName() {
		return DimensionName;
	}

	public void setDimensionName(String dimensionName) {
		DimensionName = dimensionName;
	}

	public Integer getFactorID() {
		return FactorID;
	}

	public void setFactorID(Integer factorID) {
		FactorID = factorID;
	}

	public String getFactorName() {
		return FactorName;
	}

	public void setFactorName(String factorName) {
		FactorName = factorName;
	}

	public Integer getMetricID() {
		return MetricID;
	}

	public void setMetricID(Integer metricID) {
		MetricID = metricID;
	}

	public String getMetricName() {
		return MetricName;
	}

	public void setMetricName(String metricName) {
		MetricName = metricName;
	}

	public Boolean getMetricAgrgegationFlag() {
		return MetricAgrgegationFlag;
	}

	public void setMetricAgrgegationFlag(Boolean metricAgrgegationFlag) {
		MetricAgrgegationFlag = metricAgrgegationFlag;
	}

	public String getMetricGranurality() {
		return MetricGranurality;
	}

	public void setMetricGranurality(String metricGranurality) {
		MetricGranurality = metricGranurality;
	}

	public String getMetricDescription() {
		return MetricDescription;
	}

	public void setMetricDescription(String metricDescription) {
		MetricDescription = metricDescription;
	}

	public Integer getUnitID() {
		return UnitID;
	}

	public void setUnitID(Integer unitID) {
		UnitID = unitID;
	}

	public String getUnitName() {
		return UnitName;
	}

	public void setUnitName(String unitName) {
		UnitName = unitName;
	}

	public String getUnitDescription() {
		return UnitDescription;
	}

	public void setUnitDescription(String unitDescription) {
		UnitDescription = unitDescription;
	}
	
	@Override
    public boolean equals(Object other) {
        return (other instanceof QualityModel) && (QualityModelID != null) && (DimensionID != null) && (FactorID != null) && (MetricID != null)
             ? (
            		 QualityModelID.equals(((QualityModel) other).QualityModelID)
            		 && DimensionID.equals(((QualityModel) other).DimensionID)
            		 && FactorID.equals(((QualityModel) other).FactorID)
            		 && MetricID.equals(((QualityModel) other).MetricID)
            	)
             : (other == this);
    }

    @Override
    public int hashCode() {
        return (QualityModelID != null) 
             ? (
            		 this.getClass().hashCode() 
            		 + QualityModelID.hashCode()
            		 + DimensionID.hashCode()
            		 + FactorID.hashCode()
            		 + MetricID.hashCode()
            	) 
             : super.hashCode();
    }
    
    @Override
    public String toString() {
        return String.format("QualityModel[%d, %s, %d, %s, %d, %s, %d, %s, %s, %s, %s, %d, %s, %s]",
        		QualityModelID, QualityModelName, DimensionID, DimensionName, FactorID, FactorName, MetricID, MetricName, MetricAgrgegationFlag, MetricGranurality, MetricDescription, UnitID, UnitName, UnitDescription);
    }
}
