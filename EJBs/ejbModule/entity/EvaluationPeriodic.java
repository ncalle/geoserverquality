package entity;

import java.io.Serializable;


public class EvaluationPeriodic implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer EvaluationSummaryID;
    private String MeasurableObjectUrl;
    private Integer SuccessPercentage;
    private Integer SuccessCount;
    private Integer EvaluatedCount;
    private Integer Periodic;
    
   
	public String getMeasurableObjectUrl() {
		return MeasurableObjectUrl;
	}


	public void setMeasurableObjectUrl(String measurableObjectUrl) {
		MeasurableObjectUrl = measurableObjectUrl;
	}


	public Integer getSuccessCount() {
		return SuccessCount;
	}


	public void setSuccessCount(Integer successCount) {
		SuccessCount = successCount;
	}


	public Integer getEvaluatedCount() {
		return EvaluatedCount;
	}


	public void setEvaluatedCount(Integer evaluatedCount) {
		EvaluatedCount = evaluatedCount;
	}


	public Integer getPeriodic() {
		return Periodic;
	}


	public void setPeriodic(Integer periodic) {
		Periodic = periodic;
	}


	public Integer getEvaluationSummaryID() {
		return EvaluationSummaryID;
	}


	public void setEvaluationSummaryID(Integer evaluationSummaryID) {
		EvaluationSummaryID = evaluationSummaryID;
	}

	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	public Integer getSuccessPercentage() {
		return SuccessPercentage;
	}


	public void setSuccessPercentage(Integer successPercentage) {
		SuccessPercentage = successPercentage;
	}
	

	@Override
    public boolean equals(Object other) {
        return (other instanceof EvaluationPeriodic) && (getEvaluationSummaryID() != null)
             ? (
            		 getEvaluationSummaryID().equals(((EvaluationPeriodic) other).getEvaluationSummaryID())
            	)
             : (other == this);
    }


    @Override
    public int hashCode() {
        return (getEvaluationSummaryID() != null) 
             ? (this.getClass().hashCode() + getEvaluationSummaryID().hashCode()) 
             : super.hashCode();
    }
    

    @Override
    public String toString() {
        return String.format("EvaluationPeriodic[EvaluationSummaryID=%d,  MeasurableObjectUrl=%s, EvaluatedCount=%d, SuccessCount=%d, SuccessPercentage=%d, Periodic=%d]",
        		getEvaluationSummaryID(), getMeasurableObjectUrl(), getEvaluatedCount(), getSuccessCount(), getSuccessPercentage(), getPeriodic());
    }
}
