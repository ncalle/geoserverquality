package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import entity.Profile;
import dao.DAOException;
import dao.ProfileBean;
import dao.ProfileBeanRemote;


@ManagedBean(name="profileBeanList")
@RequestScoped
public class ProfileBeanList {
	
    
	private List<Profile> list;
	
	@EJB
    private ProfileBeanRemote profileDao = new ProfileBean();
	
	
	@PostConstruct
	private void init()	{
		try {
			
            list = profileDao.list();
            System.out.println("list size: "+ list.size());
	            
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<Profile> getList() {
		return list;
	}
	
	public void setList(List<Profile> list) {
		this.list = list;
	}

}