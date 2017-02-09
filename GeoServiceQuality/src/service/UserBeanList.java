package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import entity.User;
import dao.DAOException;
import dao.UserBean;
import dao.UserBeanRemote;


@ManagedBean(name="userBeanList")
@RequestScoped
public class UserBeanList {
	    
	private List<User> listUsers;
	
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

}
