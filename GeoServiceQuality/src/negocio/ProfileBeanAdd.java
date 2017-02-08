package negocio;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import Model.Metric;
import Model.Profile;
import daos.DAOException;
import daos.ProfileBean;
import daos.ProfileBeanRemote;


@ManagedBean(name="profileBean")
@RequestScoped
public class ProfileBeanAdd {
	
    private String name;
    private String granularity;
    private boolean message;
    private List<Metric> listMetrics, listMetricsAdd;
    
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
	
	public void setMessage(boolean message) {
		this.message = message;
	}
	
	public boolean isMessage() {
		return message;
	}
	
	public List<Metric> getListMetrics() {
		return listMetrics;
	}
	
	public void setListMetrics(List<Metric> listMetrics) {
		this.listMetrics = listMetrics;
	}
	
	public void setListMetricsAdd(List<Metric> listMetricsAdd) {
		this.listMetricsAdd = listMetricsAdd;
	}
	
	public List<Metric> getListMetricsAdd() {
		return listMetricsAdd;
	}
    
    public void save() throws DAOException{
    	
    	Profile object = new Profile();
    	object.setName(name);
    	object.setGranurality(granularity);
    	object.setIsWeightedFlag(false);
    	
    	System.out.println("save.. " + object);
    	
    	try{
            moDao.create(object);
            
            FacesContext context = FacesContext.getCurrentInstance();
    		context.addMessage(null, new FacesMessage("El perfil fue guardado correctamente"));
    		
    	} catch(DAOException e) {
    		
    		FacesContext context = FacesContext.getCurrentInstance();
    		context.addMessage(null, new FacesMessage("Error al guardar el perfil"));
    		
    		e.printStackTrace();
    	} 

	}
    

}
