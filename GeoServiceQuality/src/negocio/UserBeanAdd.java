package negocio;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import Model.User;
import daos.UserBeanRemote;
import daos.UserBean;
import daos.DAOException;


@ManagedBean(name="userBeanAdd")
@RequestScoped
public class UserBeanAdd {
	
    private String email;
    private String password;
    private Integer userGroupID;
    private String firstName;
    private String lastName;
    private Integer phoneNumber;
    private Integer institutionID;
    
	@EJB
    private UserBeanRemote uDao = new UserBean();
	
	@PostConstruct
	private void init()	{
	}	
  
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getUserGroupID() {
		return userGroupID;
	}

	public void setUserGroupID(Integer userGroupID) {
		this.userGroupID = userGroupID;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Integer getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(Integer phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Integer getInstitutionID() {
		return institutionID;
	}

	public void setInstitutionID(Integer institutionID) {
		this.institutionID = institutionID;
	}
		
	public void save() {
    	
		User user = new User();
		
        user.setEmail(email);
        user.setPassword(password);
        user.setUserGroupID(userGroupID);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhoneNumber(phoneNumber);
        user.setInstitutionID(institutionID);
        
    	System.out.println("save.. " + user);
    	
    	try{
    		uDao.create(user);
            
            FacesContext context = FacesContext.getCurrentInstance();
        	context.addMessage(null, new FacesMessage("El usuario fue guardado correctamente"));
        		
    	} catch(DAOException e) {
    		
    		FacesContext context = FacesContext.getCurrentInstance();
    		context.addMessage(null, new FacesMessage("Error al guardar el usuario"));
    		
    		e.printStackTrace();
    	} 

	}
	
}
