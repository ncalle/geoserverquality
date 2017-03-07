package service;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import entity.MeasurableObject;
import dao.DAOException;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;


@ManagedBean(name="measurableObjectBean")
@RequestScoped
public class MeasurableObjectBeanAdd {
	
    private String description;
    private String url;
    private String type;
    
    private final String GET_CAPABILITIES = "REQUEST=GetCapabilities";
    private final String GET_SERVICE = "SERVICE=";
    //private final String GET_VERSION_WFS = "VERSION=1.1.0";
    
	@EJB
    private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	
	
	@PostConstruct
	private void init()
	{
	}
    
    public String getDescription() {
		return description;
	}
    
    public void setDescription(String description) {
		this.description = description;
	}
    
    public String getUrl() {
		return url;
	}
    
    public void setUrl(String url) {
		this.url = url;
	}
    
    public String getType() {
		return type;
	}
    
    public void setType(String type) {
		this.type = type;
	}
    
    public void save() {
    	
    	if(url.length()==0){
    		FacesContext context = FacesContext.getCurrentInstance();
    		context.addMessage(null, new FacesMessage("Debe ingresar una url"));
    		return;
    	}
    	
    	parametersRequestUrl();
    	
    	MeasurableObject object = new MeasurableObject();
    	object.setMeasurableObjectDescription(description);
    	object.setMeasurableObjectURL(url);
    	object.setMeasurableObjectServicesType(type);
    	
    	System.out.println("save.. " + object);
    	
    	try{
            moDao.create(object, 1); //TODO: parametrizar NodeID, cuando se amplíe el prototipo
            
            FacesContext context = FacesContext.getCurrentInstance();
        	context.addMessage(null, new FacesMessage("El objeto de evaluación fue guardado correctamente"));
        		
    	} catch(DAOException e) {
    		
    		FacesContext context = FacesContext.getCurrentInstance();
    		context.addMessage(null, new FacesMessage("Error al guardar el objeto de evaluación"));
    		
    		e.printStackTrace();
    	} 

	}
    
    
    public void parametersRequestUrl() {
   	
    	//Se agrega el pedido de servicio
    	if(url.indexOf(GET_SERVICE)==-1){
    		if(url.indexOf("?")==-1){
    			url = url + "?";
    		} else if(!url.substring(url.length()-1, url.length()).equals("?")){
    			url = url + "&";
    		}
    		url = url + GET_SERVICE + type;
    	}
    	
    	//Se agrega el pedido de capabilities
    	if(url.indexOf(GET_CAPABILITIES)==-1){
    		if(url.indexOf("?")==-1){
    			url = url + "?";
    		} else if(!url.substring(url.length()-1, url.length()).equals("&")){
    			url = url + "&";
    		}
    		url = url + GET_CAPABILITIES;
    	} 
    	
    }
}
