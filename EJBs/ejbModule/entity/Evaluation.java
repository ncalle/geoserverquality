package entity;

import java.io.Serializable;
import java.sql.Date;


public class Evaluation implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer EvaluationID;
    private Integer UserID;
    private Integer ProfileID; 
    private Date StartDate;
    private Date EndDate; 
    private Boolean IsEvaluationCompleted;
    private Boolean Success;



	public Integer getEvaluationID() {
		return EvaluationID;
	}


	public void setEvaluationID(Integer evaluationID) {
		EvaluationID = evaluationID;
	}


	public Integer getUserID() {
		return UserID;
	}


	public void setUserID(Integer userID) {
		UserID = userID;
	}


	public Integer getProfileID() {
		return ProfileID;
	}


	public void setProfileID(Integer profileID) {
		ProfileID = profileID;
	}


	public Date getStartDate() {
		return StartDate;
	}


	public void setStartDate(Date startDate) {
		StartDate = startDate;
	}


	public Date getEndDate() {
		return EndDate;
	}


	public void setEndDate(Date endDate) {
		EndDate = endDate;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	
	public void setIsEvaluationCompleted(Boolean isEvaluationCompleted) {
		IsEvaluationCompleted = isEvaluationCompleted;
	}
	
	public Boolean getIsEvaluationCompleted() {
		return IsEvaluationCompleted;
	}
	
	public void setSuccess(Boolean success) {
		Success = success;
	}
	
	public Boolean getSuccess() {
		return Success;
	}

	@Override
    public boolean equals(Object other) {
        return (other instanceof Evaluation) && (getEvaluationID() != null)
             ? (
            		 getEvaluationID().equals(((Evaluation) other).getEvaluationID())
            	)
             : (other == this);
    }


    @Override
    public int hashCode() {
        return (getEvaluationID() != null) 
             ? (this.getClass().hashCode() + getEvaluationID().hashCode()) 
             : super.hashCode();
    }
    

    @Override
    public String toString() {
        return String.format("Evaluation[EvaluationID=%d, UserID=%d, ProfileID=%d, StartDate=%s, EndDate=%s, IsEvaluationCompleted=%s, Success=%s]",
        		getEvaluationID(), getUserID(), getProfileID(), getStartDate().toString(), getEndDate().toString(), getIsEvaluationCompleted(), getSuccess());
    }

}
