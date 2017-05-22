package service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;

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

    private Boolean metricIsAggregation;
    private Boolean metricIsManual;
    private Integer metricUnitID;
    private String metricGranularity;
    private String metricName;
    private String metricDescription;
    
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
	
	public Boolean getMetricIsAggregation() {
		return metricIsAggregation;
	}

	public void setMetricIsAggregation(Boolean metricIsAggregation) {
		this.metricIsAggregation = metricIsAggregation;
	}

	public Boolean getMetricIsManual() {
		return metricIsManual;
	}

	public void setMetricIsManual(Boolean metricIsManual) {
		this.metricIsManual = metricIsManual;
	}

	public Integer getMetricUnitID() {
		return metricUnitID;
	}

	public void setMetricUnitID(Integer metricUnitID) {
		this.metricUnitID = metricUnitID;
	}

	public String getMetricGranularity() {
		return metricGranularity;
	}

	public void setMetricGranularity(String metricGranularity) {
		this.metricGranularity = metricGranularity;
	}

	public String getMetricDescription() {
		return metricDescription;
	}

	public void setMetricDescription(String metricDescription) {
		this.metricDescription = metricDescription;
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
    
    public void save() {
    	
    	QualityModelTreeStructure element = new QualityModelTreeStructure();
    	
    	switch(entityType){
	    	case "Model":
	    		element.setElementName(modelName);
	    		element.setElementType("Q");
	    		element.setFatherElementyID(null);
	    		element.setAggregationFlag(null);
	    		element.setGranularity(null);
	    		element.setUnit(null);
	        	break;
	    	case "Dimension":
	    		element.setElementName(dimensionName);
	    		element.setElementType("D");
	    		element.setFatherElementyID(dimensionModel.getElementID());
	    		element.setAggregationFlag(null);
	    		element.setGranularity(null);
	    		element.setUnit(null);
	        	break;
	    	case "Factor":
	    		element.setElementName(factorName);
	    		element.setElementType("F");
	    		element.setFatherElementyID(factorDimension.getElementID());
	    		element.setAggregationFlag(null);
	    		element.setGranularity(null);
	    		element.setUnit(null);
	        	break;	
	    	case "Metric":
	    		element.setElementName(metricName);
	    		element.setElementType("M");
	    		element.setFatherElementyID(metricFactor.getElementID());
	    		element.setAggregationFlag(metricIsAggregation);
	    		element.setGranularity(metricGranularity);
	    		element.setUnit(null);
	        	break;
			default:
				break;	
    	}
    	    	    	
    	try{
    		qmDao.create(element, metricUnitID, metricIsManual, metricDescription);
            
            FacesContext context = FacesContext.getCurrentInstance();
        	context.addMessage(null, new FacesMessage("La entidad del modelo de calidad fue guardada correctamente."));
        		
    	} catch(DAOException e) {
    		
    		FacesContext context = FacesContext.getCurrentInstance();
    		context.addMessage(null, new FacesMessage("Error al guardar la entidad."));
    		
    		e.printStackTrace();
    	}

	}
    
    public void handleFileUpload(FileUploadEvent event) {
        try {	
	        InputStream in = (event.getFile()).getInputstream();
	        String fileName = "Copy_" + event.getFile().getFileName();
	
	        // inputStream a FileOutputStream
	        File file = new File("C:/GeoServiceQualityJARs/" + fileName);
	        OutputStream out = new FileOutputStream(file);
	        int read = 0;
	        byte[] bytes = new byte[1024];
	
	        while ((read = in.read(bytes)) != -1) {
	            out.write(bytes, 0, read);
	        }
	        in.close();
	        out.flush();
	        out.close();
	        System.out.println("Archivo subido!");
	        
	       

	        URL url = file.toURI().toURL();  
	        URL[] urls = new URL[]{url};

	        ClassLoader cl = new URLClassLoader(urls);
	        try {
				Class cls = cl.loadClass("service.QualityModelBeanAdd");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
	        
	        /* otra forma
	        URLClassLoader child = new URLClassLoader (file.toURL(), this.getClass().getClassLoader());
	        Class classToLoad = Class.forName ("service.QualityModelBeanAdd", true, child);
	        Method method = classToLoad.getDeclaredMethod ("myMethod");
	        Object instance = classToLoad.newInstance ();
	        Object result = method.invoke (instance);*/
	        
	        
	        
	    } catch (IOException e) {
	        System.out.println(e.getMessage());
	    }
    	
    	

    	
        FacesMessage message = new FacesMessage("Éxito", event.getFile().getFileName() + " método agregado.");
        FacesContext.getCurrentInstance().addMessage(null, message);
    }
}
