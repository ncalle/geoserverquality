package entity;

import java.io.Serializable;

/**
 * Modelo de Objetos medibles. 
 * Puede ser usada a travez de todas las capas, capa de datos, controlador o vista
 */
public class MeasurableObject implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer MeasurableObjectID;
    private String MeasurableObjectType;
    private String MeasurableObjectName;
    private String MeasurableObjectDescription;
    private String MeasurableObjectURL;
    private String MeasurableObjectServicesType;

	
    public Integer getMeasurableObjectID() {
		return MeasurableObjectID;
	}


	public void setMeasurableObjectID(Integer measurableObjectID) {
		MeasurableObjectID = measurableObjectID;
	}

	public String getMeasurableObjectType() {
		return MeasurableObjectType;
	}


	public void setMeasurableObjectType(String measurableObjectType) {
		MeasurableObjectType = measurableObjectType;
	}


	public String getMeasurableObjectName() {
		return MeasurableObjectName;
	}


	public void setMeasurableObjectName(String measurableObjectName) {
		MeasurableObjectName = measurableObjectName;
	}


	public String getMeasurableObjectDescription() {
		return MeasurableObjectDescription;
	}


	public void setMeasurableObjectDescription(String measurableObjectDescription) {
		MeasurableObjectDescription = measurableObjectDescription;
	}


	public String getMeasurableObjectURL() {
		return MeasurableObjectURL;
	}


	public void setMeasurableObjectURL(String measurableObjectURL) {
		MeasurableObjectURL = measurableObjectURL;
	}


	public String getMeasurableObjectServicesType() {
		return MeasurableObjectServicesType;
	}


	public void setMeasurableObjectServicesType(String measurableObjectServicesType) {
		MeasurableObjectServicesType = measurableObjectServicesType;
	}


	@Override
    public boolean equals(Object other) {
        return (other instanceof MeasurableObject) && (getMeasurableObjectID() != null)
             ? (
            		 getMeasurableObjectID().equals(((MeasurableObject) other).getMeasurableObjectID())
            		 && getMeasurableObjectType().equals(((MeasurableObject) other).getMeasurableObjectType())
            	)
             : (other == this);
    }


    @Override
    public int hashCode() {
        return (getMeasurableObjectID() != null) 
             ? (this.getClass().hashCode() + getMeasurableObjectID().hashCode() + getMeasurableObjectType().hashCode()) 
             : super.hashCode();
    }
    
    /**
     * Devuelve los datos de objetos medibles en formato string
     * Usado como log para debugear
     */
    @Override
    public String toString() {
        return String.format("MeasurableObject[MeasurableObjectID=%d, MeasurableObjectType=%s, MeasurableObjectName=%s, MeasurableObjectDescription=%s, MeasurableObjectURL=%s, MeasurableObjectServicesType=%s]",
        		getMeasurableObjectID(), getMeasurableObjectType(), getMeasurableObjectName(), getMeasurableObjectDescription(), getMeasurableObjectURL(), getMeasurableObjectServicesType());
    }

}
