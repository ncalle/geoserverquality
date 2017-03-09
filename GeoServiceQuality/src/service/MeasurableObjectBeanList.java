package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import org.primefaces.event.RowEditEvent;
import org.primefaces.event.SelectEvent;

import entity.MeasurableObject;
import dao.DAOException;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;


@ManagedBean(name="measurableObjectBeanList")
@RequestScoped
public class MeasurableObjectBeanList {
	
    
	private List<MeasurableObject> listObjects;
	private MeasurableObject selectedMeasurableObject;
	
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

	public MeasurableObject getSelectedMeasurableObject() {
		return selectedMeasurableObject;
	}

	public void setSelectedMeasurableObject(MeasurableObject selectedMeasurableObject) {
		this.selectedMeasurableObject = selectedMeasurableObject;
	}
	
    public void onRowSelect(SelectEvent event) {
    	//agregar codigo de ser necesario
    }
       	
	public void onRowEdit(RowEditEvent event) {    	
		MeasurableObject mo = ((MeasurableObject) event.getObject());

		System.out.println("mo : " + mo);
		
		moDao.update(mo);
		FacesMessage msg = new FacesMessage("Objeto Medible editado correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }	
	
	public void deleteMeasurableObject() {
		moDao.delete(selectedMeasurableObject);    	
    	listObjects = moDao.list();
        selectedMeasurableObject = null;
        
		FacesMessage msg = new FacesMessage("El Objecto Medible fue eliminado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
}
