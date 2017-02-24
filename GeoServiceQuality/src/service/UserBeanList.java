package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.omnifaces.util.Faces;
import org.primefaces.event.RowEditEvent;
import org.primefaces.event.SelectEvent;

import entity.Institution;
import entity.MeasurableObject;
import entity.User;
import entity.UserGroup;
import dao.DAOException;
import dao.InstitutionBean;
import dao.InstitutionBeanRemote;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;
import dao.UserBean;
import dao.UserBeanRemote;
import dao.UserGroupBean;
import dao.UserGroupBeanRemote;


@ManagedBean(name="userBeanList")
@ViewScoped
public class UserBeanList {
	
	private List<User> listUsers;	
	private User selectedUser;
	private List<UserGroup> listUserGroups;
	private UserGroup userGroup;
	private List<Institution> listInstitutions;
	private Institution institution;
	private List<MeasurableObject> listUserMeasurableObjects;
	private MeasurableObject selectedUserMeasurableObject;
	
	@EJB
	private UserBeanRemote uDao = new UserBean();
	private UserGroupBeanRemote ugDao = new UserGroupBean();
	private InstitutionBeanRemote insDao = new InstitutionBean();
	private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
		
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
    	Faces.setRequestAttribute("selectedUser", selectedUser);
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
	
	public List<MeasurableObject> getListUserMeasurableObjects() {
		return listUserMeasurableObjects;
	}

	public void setListUserMeasurableObjects(List<MeasurableObject> listUserMeasurableObjects) {
		this.listUserMeasurableObjects = listUserMeasurableObjects;
	}
	
	public MeasurableObject getSelectedUserMeasurableObject() {
		return selectedUserMeasurableObject;
	}

	public void setSelectedUserMeasurableObject(MeasurableObject selectedUserMeasurableObject) {
		this.selectedUserMeasurableObject = selectedUserMeasurableObject;
	}	
    	
	public void deleteUser() {   	
    	uDao.delete(selectedUser);    	
        listUsers = uDao.list();
        selectedUser = null;
        
		FacesMessage msg = new FacesMessage("Usuario eliminado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
    
    public void onRowSelect(SelectEvent event) {
    	listUserMeasurableObjects = moDao.list(selectedUser.getUserId());
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
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
	
	public void deleteUserMeasurableObject() {
		uDao.removeUserMeasurableObject(selectedUser, selectedUserMeasurableObject);    	
    	listUserMeasurableObjects.remove(selectedUserMeasurableObject);
    	selectedUserMeasurableObject = null;
        
		FacesMessage msg = new FacesMessage("Objeto medible eliminado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
}
