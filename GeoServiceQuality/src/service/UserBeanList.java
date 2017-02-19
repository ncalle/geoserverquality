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

import entity.Institution;
import entity.MeasurableObject;
import entity.User;
import entity.UserGroup;
import dao.DAOException;
import dao.InstitutionBean;
import dao.InstitutionBeanRemote;
import dao.UserBean;
import dao.UserBeanRemote;
import dao.UserGroupBean;
import dao.UserGroupBeanRemote;


@ManagedBean(name="userBeanList")
@RequestScoped 
public class UserBeanList {
	    
	private List<User> listUsers;	
	private User selectedUser;
	private MeasurableObject listUserMeasurableObjects;
	private List<UserGroup> listUserGroups;
	private UserGroup userGroup;
	private List<Institution> listInstitutions;
	private Institution institution;
	
	@EJB
	private UserBeanRemote uDao = new UserBean();
	private UserGroupBeanRemote ugDao = new UserGroupBean();
	private InstitutionBeanRemote insDao = new InstitutionBean();
		
	@PostConstruct
	private void init()	{
		try {
            listUsers = uDao.list();
            listUserGroups = ugDao.list();
            listInstitutions = insDao.list();
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
    
    public void setSelectedUser(User selectedUser) {   	
    	this.selectedUser = selectedUser;
    }
     
	public MeasurableObject getListUserMeasurableObjects() {
		return listUserMeasurableObjects;
	}

	public void setListUserMeasurableObjects(MeasurableObject listUserMeasurableObjects) {
		this.listUserMeasurableObjects = listUserMeasurableObjects;
	}
	
	public List<UserGroup> getListUserGroups() {
		return listUserGroups;
	}
	
	public void setListUserGroups(List<UserGroup> listUserGroups) {
		this.listUserGroups = listUserGroups;
	}
    
	public UserGroup getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}
	
	public List<Institution> getListInstitutions() {
		return listInstitutions;
	}
	
	public void setListInstitutions(List<Institution> listInstitutions) {
		this.listInstitutions = listInstitutions;
	}
	
	public Institution getInstitution() {
		return institution;
	}

	public void setInstitution(Institution institution) {
		this.institution = institution;
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
		User u = ((User) event.getObject());
		
		if (userGroup != null){
			u.setUserGroupID(userGroup.getUserGroupID());
			u.setUserGroupName(userGroup.getName());			
		}

		if (institution != null){
			u.setInstitutionID(institution.getInstitutionID());
			u.setInstitutionName(institution.getName());			
		}
		
		uDao.update(u);
		FacesMessage msg = new FacesMessage("Usuario editado correctamente.");
		System.out.println("event: Grupo de Usuario: " + ((User) event.getObject()));
		System.out.println("userGroup: Grupo de Usuario: " + userGroup);
		System.out.println("institution: " + institution);
        FacesContext.getCurrentInstance().addMessage(null, msg);
        selectedUser = null;
    }
}
