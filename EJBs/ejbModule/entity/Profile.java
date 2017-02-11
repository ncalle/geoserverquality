package entity;

import java.io.Serializable;
import java.util.List;

/**
 * Modelo de Perfiles. 
 * Puede ser usada a travez de todas las capas, capa de datos, controlador o vista
 */
public class Profile implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer ProfileId;
    private String Name;
    private String Granurality; //'Ide', 'Institución', 'Nodo', 'Capa', 'Servicio'
    private Boolean IsWeightedFlag;
    private List<Integer> MetricKeys; // Lista de enteros separada por coma, que representa los IDs de las metricas
    private String MetricIds; 


	public Integer getProfileId() {
		return ProfileId;
	}


	public void setProfileId(Integer profileId) {
		ProfileId = profileId;
	}


	public String getName() {
		return Name;
	}


	public void setName(String name) {
		Name = name;
	}


	public String getGranurality() {
		return Granurality;
	}


	public void setGranurality(String granurality) {
		Granurality = granurality;
	}


	public Boolean getIsWeightedFlag() {
		return IsWeightedFlag;
	}


	public void setIsWeightedFlag(Boolean isWeightedFlag) {
		IsWeightedFlag = isWeightedFlag;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public void setMetricKeys(List<Integer> metricKeys) {
		MetricKeys = metricKeys;
	}
	
	public List<Integer> getMetricKeys() {
		return MetricKeys;
	}

	public String getMetricIds() {
		return MetricIds;
	}
	
	public void setMetricIds(String metricIds) {
		MetricIds = metricIds;
	}

	@Override
    public boolean equals(Object other) {
        return (other instanceof Profile) && (getProfileId() != null)
             ? (
            		 getProfileId().equals(((Profile) other).getProfileId())
            		 && getName().equals(((Profile) other).getName())
            	)
             : (other == this);
    }


    @Override
    public int hashCode() {
        return (getProfileId() != null) 
             ? (this.getClass().hashCode() + getProfileId().hashCode()) 
             : super.hashCode();
    }
    

    @Override
    public String toString() {
        return String.format("Profile[ProfileId=%d, Name=%s, Granularity=%s, Weighted=%s, MetricKeys=%s]",
        		getProfileId(), getName(), getGranurality(), getIsWeightedFlag(), getMetricKeys());
    }

}
