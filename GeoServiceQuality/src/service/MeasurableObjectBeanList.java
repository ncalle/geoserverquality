package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import entity.MeasurableObject;
import dao.DAOException;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;


@ManagedBean(name="measurableObjectBeanList")
@RequestScoped
public class MeasurableObjectBeanList {
	
    
	private List<MeasurableObject> listObjects;
	
	@EJB
    private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	
	
	@PostConstruct
	private void init()	{
		try {
			
            listObjects = moDao.list();
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
