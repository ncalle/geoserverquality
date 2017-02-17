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
import entity.User;
import dao.DAOException;
import dao.UserBean;
import dao.UserBeanRemote;


@ManagedBean(name="userBeanList")
@RequestScoped 
public class UserBeanList {
	    
	private List<User> listUsers;	
	private User selectedUser;
	private MeasurableObject listUserMeasurableObjects;
	
	@EJB
    private UserBeanRemote uDao = new UserBean();
		
	@PostConstruct
	private void init()	{
		try {
			
            listUsers = uDao.list();
            System.out.println("user list size: "+ listUsers.size());
	            
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<User> getListUsers() {
		return listUsers;
	}
	
	public void setListUsers(List<User> listUsers) {
		this.listUsers = listUsers;
	}
	
    public User getSelectedUser() {
        return selectedUser;
    }
     
	public MeasurableObject getListUserMeasurableObjects() {
		return listUserMeasurableObjects;
	}

	public void setListUserMeasurableObjects(MeasurableObject listUserMeasurableObjects) {
		this.listUserMeasurableObjects = listUserMeasurableObjects;
	}      
    
    public void setSelectedUser(User selectedUser) {   	
    	this.selectedUser = selectedUser;
    }
	
	public void deleteUser() {   	
    	uDao.delete(selectedUser);    	
    	listUsers.remove(selectedUser);
        selectedUser = null;
        
		FacesMessage msg = new FacesMessage("Usuario eliminado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
    
    public void onRowSelect(SelectEvent event) {
        // actualizar objetos medibles del usuario
    }
       	
	public void onRowEdit(RowEditEvent event) {    	
		uDao.update(((User) event.getObject()));
		FacesMessage msg = new FacesMessage("Usuario editado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
        selectedUser = null;
    }

}
