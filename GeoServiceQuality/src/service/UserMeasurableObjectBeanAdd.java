package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.omnifaces.util.Faces;

import entity.MeasurableObject;
import entity.User;
import dao.UserBeanRemote;
import dao.UserBean;
import dao.DAOException;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;


@ManagedBean(name="userMeasurableObjectBeanAdd")
@ViewScoped
public class UserMeasurableObjectBeanAdd {

	private List<MeasurableObject> listUserMeasurableObjects;
	private MeasurableObject userMeasurableObject;
	private Integer userID;
    
	@EJB
	private UserBeanRemote uDao = new UserBean();
	private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	
	@PostConstruct
	private void init()	{
		User selectedUser = (User) Faces.getRequestAttribute("selectedUser");
		this.setUserID(1); //this.setUserID(selectedUser.getUserId());
		//System.out.println("selectedUser.. " + selectedUser);
		listUserMeasurableObjects = moDao.userMeasurableObjectsToAddGet(1); //userID
		//TODO: Parametrizar llamada una vez que se pueda pasar el userID como parametro entre las vistas
	}
	
	public Integer getUserID() {
		return userID;
	}

	public void setUserID(Integer userID) {
		this.userID = userID;
	}
		
	public List<MeasurableObject> getListUserMeasurableObjects() {
		return listUserMeasurableObjects;
	}

	public void setListUserMeasurableObjects(List<MeasurableObject> listUserMeasurableObjects) {
		this.listUserMeasurableObjects = listUserMeasurableObjects;
	}

	public MeasurableObject getUserMeasurableObject() {
		return userMeasurableObject;
	}

	public void setUserMeasurableObject(MeasurableObject userMeasurableObject) {
		this.userMeasurableObject = userMeasurableObject;
	}
		
	public void save() {
    	FacesMessage msg;

    	try{
    		uDao.userAddMeasurableObject(userID, userMeasurableObject);
    		msg = new FacesMessage("El objeto medible fue asociado al usuario de manera correcta.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
    	} catch(DAOException e) {   		
    		msg = new FacesMessage("Error al asociar el objeto medible con el usuario.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
    	}
	}
}
