package service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import org.primefaces.model.DualListModel;

import entity.Metric;
import entity.Profile;
import dao.DAOException;
import dao.MetricBean;
import dao.MetricBeanRemote;
import dao.ProfileBean;
import dao.ProfileBeanRemote;


@ManagedBean(name="profileBeanAdd")
@RequestScoped
public class ProfileBeanAdd {
	
    private String name;
    private String granularity;
	private List<Metric> listMetrics;
    private DualListModel<Metric> dualListMetrics;
    
	@EJB
    private ProfileBeanRemote pDao = new ProfileBean();
    private MetricBeanRemote mDao = new MetricBean();
	
    
	@PostConstruct
	private void init()
	{
		listMetrics = mDao.list();
		dualListMetrics = new DualListModel<>(new ArrayList<>(listMetrics), new ArrayList<Metric>()); 
	}
	

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
	public String getGranularity() {
		return granularity;
	}
	
	public void setGranularity(String granularity) {
		this.granularity = granularity;
	}
				
	public DualListModel<Metric> getDualListMetrics() {
		return dualListMetrics;
	}

	public void setDualListMetrics(DualListModel<Metric> dualListMetrics) {
		this.dualListMetrics = dualListMetrics;
	}
	    
    public List<Metric> getListMetrics() {
		return listMetrics;
	}


	public void save() {
    	FacesMessage msg;
    	
    	if(name.length()==0){
    		msg = new FacesMessage("Debe ingresar un nombre.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
    		return;
    	}
    	
    	Profile profile = new Profile();
    	profile.setName(name);
    	profile.setGranurality(granularity);
    	profile.setIsWeightedFlag(false);
    	    	
    	try{
            pDao.create(profile, dualListMetrics.getTarget());
            
    		msg = new FacesMessage("El Perfil fue creado correctamente.");
            FacesContext.getCurrentInstance().addMessage(null, msg);    		
    	} catch(DAOException e) {
    		msg = new FacesMessage("Error al crear el Perfil.");
            FacesContext.getCurrentInstance().addMessage(null, msg);       		
    	}
	}
}
