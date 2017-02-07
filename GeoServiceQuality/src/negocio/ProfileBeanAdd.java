package negocio;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import Model.Profile;
import daos.DAOException;
import daos.ProfileBean;
import daos.ProfileBeanRemote;


@ManagedBean(name="profileBean")
@RequestScoped
public class ProfileBeanAdd {
	
    private String name;
    private String granularity;
    
	@EJB
    private ProfileBeanRemote moDao = new ProfileBean();
	
	
	@PostConstruct
	private void init()
	{
	}
	

    public String getName() {
        return name;
    }

    public void setName(String name) {
    	System.out.println("setName: " + name);
        this.name = name;
    }
    
	public String getGranularity() {
		return granularity;
	}
	
	public void setGranularity(String granularity) {
		System.out.println("setGranularity: " + granularity);
		this.granularity = granularity;
	}
    
    public void save() {
    	
    	Profile object = new Profile();
    	object.setName(name);
    	object.setGranurality(granularity);
    	object.setIsWeightedFlag(false);
    	
    	System.out.println("save.. " + object);
    	
    	try{
            moDao.create(object);
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 

	}
}
