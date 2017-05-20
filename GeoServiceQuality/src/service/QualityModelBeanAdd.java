package service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import dao.DAOException;
import dao.QualityModelTreeStructureBean;
import dao.QualityModelTreeStructureBeanRemote;
import entity.QualityModelTreeStructure;

@ManagedBean(name="qualityModelBeanAdd")
@ViewScoped
public class QualityModelBeanAdd {
	
	private List<QualityModelTreeStructure> listQualityModels;
    private List <QualityModelTreeStructure> listModel;
    private List <QualityModelTreeStructure> listDimension;
    private List <QualityModelTreeStructure> listFactor;
    private List <QualityModelTreeStructure> listMetric;
	
	private String entityType;
    private String modelName;
    private QualityModelTreeStructure dimensionModel;
    private String dimensionName;
    private QualityModelTreeStructure factorDimension;
    private String factorName;
    private QualityModelTreeStructure metricFactor;
    private String metricName;
    
	@EJB
	private QualityModelTreeStructureBeanRemote qmDao = new QualityModelTreeStructureBean();

	@PostConstruct
	private void init()
	{
		try {
			listQualityModels = qmDao.list();
			createQualityModelLists();
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<QualityModelTreeStructure> getListQualityModels() {
		return listQualityModels;
	}
	
	public void setListQualityModels(List<QualityModelTreeStructure> listQualityModels) {
		this.listQualityModels = listQualityModels;
	}

	public String getEntityType() {
		return entityType;
	}

	public void setEntityType(String entityType) {
		this.entityType = entityType;
	}
    
    public List<QualityModelTreeStructure> getListModel() {
		return listModel;
	}

	public void setListModel(List<QualityModelTreeStructure> listModel) {
		this.listModel = listModel;
	}

	public List<QualityModelTreeStructure> getListDimension() {
		return listDimension;
	}

	public void setListDimension(List<QualityModelTreeStructure> listDimension) {
		this.listDimension = listDimension;
	}

	public List<QualityModelTreeStructure> getListFactor() {
		return listFactor;
	}

	public void setListFactor(List<QualityModelTreeStructure> listFactor) {
		this.listFactor = listFactor;
	}

	public List<QualityModelTreeStructure> getListMetric() {
		return listMetric;
	}

	public void setListMetric(List<QualityModelTreeStructure> listMetric) {
		this.listMetric = listMetric;
	}

	public String getModelName() {
		return modelName;
	}

	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

	public QualityModelTreeStructure getDimensionModel() {
		return dimensionModel;
	}

	public void setDimensionModel(QualityModelTreeStructure dimensionModel) {
		this.dimensionModel = dimensionModel;
	}

	public String getDimensionName() {
		return dimensionName;
	}

	public void setDimensionName(String dimensionName) {
		this.dimensionName = dimensionName;
	}

	public QualityModelTreeStructure getFactorDimension() {
		return factorDimension;
	}

	public void setFactorDimension(QualityModelTreeStructure factorDimension) {
		this.factorDimension = factorDimension;
	}

	public String getFactorName() {
		return factorName;
	}

	public void setFactorName(String factorName) {
		this.factorName = factorName;
	}

	public QualityModelTreeStructure getMetricFactor() {
		return metricFactor;
	}

	public void setMetricFactor(QualityModelTreeStructure metricFactor) {
		this.metricFactor = metricFactor;
	}

	public String getMetricName() {
		return metricName;
	}

	public void setMetricName(String metricName) {
		this.metricName = metricName;
	}

	public void createQualityModelLists(){
	    listModel = new ArrayList<>();
        List <Integer> listModelIDs = new ArrayList<>();
        listDimension = new ArrayList<>();
        List <Integer> listDimensionIDs = new ArrayList<>();
        listFactor = new ArrayList<>();
        List <Integer> listFactorIDs = new ArrayList<>();
        
        if (listQualityModels != null){
        	System.out.println("TREE: " + listQualityModels);
        				
			for (QualityModelTreeStructure qualityModelsElement : listQualityModels) {
				if ((!listModelIDs.contains(qualityModelsElement.getElementID()) && qualityModelsElement.getElementType().equals("Q"))){
					listModel.add(qualityModelsElement);
					listModelIDs.add(qualityModelsElement.getElementID());
				}
				
				if ((!listDimensionIDs.contains(qualityModelsElement.getElementID()) && qualityModelsElement.getElementType().equals("D"))){
					listDimension.add(qualityModelsElement);
					listDimensionIDs.add(qualityModelsElement.getElementID());
				}
							
				if ((!listFactorIDs.contains(qualityModelsElement.getElementID()) && qualityModelsElement.getElementType().equals("F"))){
					listFactor.add(qualityModelsElement);
					listFactorIDs.add(qualityModelsElement.getElementID());
				}
			}
        }
    }
}
