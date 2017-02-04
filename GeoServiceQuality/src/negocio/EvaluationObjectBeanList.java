package negocio;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import Model.MeasurableObject;
import daos.DAOException;
import daos.DAOFactory;
import daos.MeasurableObjectBeanRemote;


@ManagedBean(name="evaluationObjectBeanList")
@RequestScoped
public class EvaluationObjectBeanList {
	
    
	private List<MeasurableObject> listObjects;
	
	
	@PostConstruct
	private void init()
	{
		try {
			
            DAOFactory javabase = DAOFactory.getInstance("geoservicequality.jdbc");
            MeasurableObjectBeanRemote mobr = javabase.geMeasurableObjectBeanRemote();
            listObjects = mobr.list();
            
            System.out.println("list size: "+ listObjects.size());
	            
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<MeasurableObject> getListObjects() {
		return listObjects;
	}
	
	public void setListObjects(List<MeasurableObject> listObjects) {
		this.listObjects = listObjects;
	}

}
