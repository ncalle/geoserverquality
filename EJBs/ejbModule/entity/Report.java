package entity;

import java.io.Serializable;


/**
 * Modelo de Reportes en general.
 * Puede ser usada a travez de todas las capas, capa de datos, controlador o vista
 */
public class Report implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer InstitutionID;
    private String InstitutionName;
    private Integer GeographicServicesCount;
    private Integer GeographicServicesPercentage;
    
    private Integer SuccessCount;
    private Integer FailCount;
    private Integer SuccessPercentage;
    private Integer FailPercentage;
    private Integer TotalEvaluationCount;
	
    private Integer MetricID;
    private String MetricName;
    private Integer EvaluationPerMetricCount;
    private Integer EvaluationPerMetricPercentage;
    
    private Integer ProfileID;
    private String ProfileName;
    private Integer ProfileCount;
    private Integer ProfilePercentage;
    private Integer ProfileSuccessPercentage;
    
    private Integer InstitutionCount;
    private Integer InstitutionPercentage;
    private Integer InstitutionSuccessPercentage;
    
    public Integer getInstitutionID() {
		return InstitutionID;
	}
    
	public void setInstitutionID(Integer institutionID) {
		InstitutionID = institutionID;
	}
	
	public String getInstitutionName() {
		return InstitutionName;
	}
	
	public void setInstitutionName(String institutionName) {
		InstitutionName = institutionName;
	}
	
	public Integer getGeographicServicesCount() {
		return GeographicServicesCount;
	}
	
	public void setGeographicServicesCount(Integer geographicServicesCount) {
		GeographicServicesCount = geographicServicesCount;
	}
	
	public Integer getGeographicServicesPercentage() {
		return GeographicServicesPercentage;
	}
	
	public void setGeographicServicesPercentage(Integer geographicServicesPercentage) {
		GeographicServicesPercentage = geographicServicesPercentage;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public Integer getSuccessCount() {
		return SuccessCount;
	}
	
	public void setSuccessCount(Integer successCount) {
		SuccessCount = successCount;
	}
	
	public Integer getFailCount() {
		return FailCount;
	}
	
	public void setFailCount(Integer failCount) {
		FailCount = failCount;
	}
	
	public Integer getSuccessPercentage() {
		return SuccessPercentage;
	}
	
	public void setSuccessPercentage(Integer successPercentage) {
		SuccessPercentage = successPercentage;
	}
	
	public Integer getFailPercentage() {
		return FailPercentage;
	}
	
	public void setFailPercentage(Integer failPercentage) {
		FailPercentage = failPercentage;
	}
	
	public Integer getTotalEvaluationCount() {
		return TotalEvaluationCount;
	}
	
	public void setTotalEvaluationCount(Integer totalEvaluationCount) {
		TotalEvaluationCount = totalEvaluationCount;
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

	public Integer getEvaluationPerMetricCount() {
		return EvaluationPerMetricCount;
	}

	public void setEvaluationPerMetricCount(Integer evaluationPerMetricCount) {
		EvaluationPerMetricCount = evaluationPerMetricCount;
	}

	public Integer getEvaluationPerMetricPercentage() {
		return EvaluationPerMetricPercentage;
	}

	public void setEvaluationPerMetricPercentage(Integer evaluationPerMetricPercentage) {
		EvaluationPerMetricPercentage = evaluationPerMetricPercentage;
	}

	public Integer getProfileID() {
		return ProfileID;
	}

	public void setProfileID(Integer profileID) {
		ProfileID = profileID;
	}

	public String getProfileName() {
		return ProfileName;
	}

	public void setProfileName(String profileName) {
		ProfileName = profileName;
	}

	public Integer getProfileCount() {
		return ProfileCount;
	}

	public void setProfileCount(Integer profileCount) {
		ProfileCount = profileCount;
	}

	public Integer getProfilePercentage() {
		return ProfilePercentage;
	}

	public void setProfilePercentage(Integer profilePercentage) {
		ProfilePercentage = profilePercentage;
	}

	public Integer getProfileSuccessPercentage() {
		return ProfileSuccessPercentage;
	}

	public void setProfileSuccessPercentage(Integer profileSuccessPercentage) {
		ProfileSuccessPercentage = profileSuccessPercentage;
	}

	public Integer getInstitutionCount() {
		return InstitutionCount;
	}

	public void setInstitutionCount(Integer institutionCount) {
		InstitutionCount = institutionCount;
	}

	public Integer getInstitutionPercentage() {
		return InstitutionPercentage;
	}

	public void setInstitutionPercentage(Integer institutionPercentage) {
		InstitutionPercentage = institutionPercentage;
	}

	public Integer getInstitutionSuccessPercentage() {
		return InstitutionSuccessPercentage;
	}

	public void setInstitutionSuccessPercentage(Integer institutionSuccessPercentage) {
		InstitutionSuccessPercentage = institutionSuccessPercentage;
	}
}
