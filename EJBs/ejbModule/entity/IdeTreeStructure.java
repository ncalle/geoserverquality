package entity;

import java.io.Serializable;

/**
 * Modelo que representa el Modelo de Calidad.
 * Puede ser usada a travez de todas las capas, capa de datos, controlador o vista
 */
public class IdeTreeStructure implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer MeasurableObjectID;
    private Integer IdeID;
    private String IdeName;
    private String IdeDescription;
    private Integer InstitutionID;
    private String InstitutionName;
    private String InstitutionDescription;
    private Integer NodeID;
    private String NodeName;
    private String NodeDescription;
   
	public Integer getMeasurableObjectID() {
		return MeasurableObjectID;
	}

	public void setMeasurableObjectID(Integer measurableObjectID) {
		MeasurableObjectID = measurableObjectID;
	}
    
    public Integer getIdeID() {
		return IdeID;
	}

	public void setIdeID(Integer ideID) {
		IdeID = ideID;
	}

	public String getIdeName() {
		return IdeName;
	}

	public void setIdeName(String ideName) {
		IdeName = ideName;
	}

	public String getIdeDescription() {
		return IdeDescription;
	}

	public void setIdeDescription(String ideDescription) {
		IdeDescription = ideDescription;
	}

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

	public String getInstitutionDescription() {
		return InstitutionDescription;
	}

	public void setInstitutionDescription(String institutionDescription) {
		InstitutionDescription = institutionDescription;
	}

	public Integer getNodeID() {
		return NodeID;
	}

	public void setNodeID(Integer nodeID) {
		NodeID = nodeID;
	}

	public String getNodeName() {
		return NodeName;
	}

	public void setNodeName(String nodeName) {
		NodeName = nodeName;
	}

	public String getNodeDescription() {
		return NodeDescription;
	}

	public void setNodeDescription(String nodeDescription) {
		NodeDescription = nodeDescription;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
    public boolean equals(Object other) {
        return (other instanceof IdeTreeStructure) && (MeasurableObjectID != null)
             ? (
            		 MeasurableObjectID.equals(((IdeTreeStructure) other).MeasurableObjectID)
            	)
             : (other == this);
    }

    @Override
    public int hashCode() {
        return (MeasurableObjectID != null) 
             ? (
            		 this.getClass().hashCode() 
            		 + MeasurableObjectID.hashCode()
            	) 
             : super.hashCode();
    }
    
    @Override
    public String toString() {
        return String.format("QualityModel[%d, %d, %s, %s, %d, %s, %s, %d, %s, %s]",
        MeasurableObjectID, IdeID, IdeName, IdeDescription, InstitutionID, InstitutionName, InstitutionDescription, NodeID, NodeName, NodeDescription);
    }
}
