package negocio;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import Model.MeasurableObject;
import daos.DAOException;
import daos.DAOFactory;
import daos.MeasurableObjectBean;
import daos.MeasurableObjectBeanRemote;


@ManagedBean(name="evaluationObjectBean")
@RequestScoped
public class EvaluationObjectBean {
	
    private String name;
    private String description;
    private String url;
    private String type;
    
	@EJB
    private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	
	
	@PostConstruct
	private void init()
	{
	}
	

    public String getName() {
        return name;
    }

    public void setName(String name) {
    	System.out.println("setName: " + name);
        this.name = name;
    }
    
    public String getDescription() {
		return description;
	}
    
    public void setDescription(String description) {
    	System.out.println("setDescription: " + description);
		this.description = description;
	}
    
    public String getUrl() {
		return url;
	}
    
    public void setUrl(String url) {
    	System.out.println("setUrl: " + url);
		this.url = url;
	}
    
    public String getType() {
		return type;
	}
    
    public void setType(String type) {
    	System.out.println("setType: " + type);
		this.type = type;
	}
    
    public void save() {
    	
    	MeasurableObject object = new MeasurableObject();
    	object.setMeasurableObjectName(name);
    	object.setMeasurableObjectDescription(description);
    	object.setMeasurableObjectURL(url);
    	object.setMeasurableObjectServicesType(type);
    	
    	System.out.println("save.. " + object);
    	
    	try{
            DAOFactory javabase = DAOFactory.getInstance("geoservicequality.jdbc");
            MeasurableObjectBeanRemote mobr = javabase.geMeasurableObjectBeanRemote();
            mobr.create(object, 1, 1);
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 

	}
}
