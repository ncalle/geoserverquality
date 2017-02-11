package service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import entity.Metric;
import entity.Profile;
import dao.DAOException;
import dao.MetricBean;
import dao.MetricBeanRemote;
import dao.ProfileBean;
import dao.ProfileBeanRemote;


@ManagedBean(name="profileBean")
@RequestScoped
public class ProfileBeanAdd {
	
    private String name;
    private String granularity;
    private boolean message;
    private Integer selectedMetricId=-1;
    private List<Metric> listMetrics, listMetricsAdd = new ArrayList<>();
    
	@EJB
    private ProfileBeanRemote moDao = new ProfileBean();
	
	@EJB
    private MetricBeanRemote metricsDao = new MetricBean();
	

	public ProfileBeanAdd() {
		listMetricsAdd = new ArrayList<>();
		listMetrics = metricsDao.list();
		System.out.println("ProfileBeanAdd.. ");
	}
	
	
	private void init()
	{
		listMetricsAdd = new ArrayList<>();
		listMetrics = metricsDao.list();
		System.out.println("init.. ");
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
		System.out.println("setListMetrics: " + listMetrics);
		this.listMetrics = listMetrics;
	}
	
	public void setListMetricsAdd(List<Metric> listMetricsAdd) {
		System.out.println("setListMetricsAdd: " + listMetricsAdd);
		this.listMetricsAdd = listMetricsAdd;
	}
	
	public List<Metric> getListMetricsAdd() {
		return listMetricsAdd;
	}
	
	public void setSelectedMetricId(Integer selectedMetricId) {
		System.out.println("setSelectedMetricId: " + selectedMetricId);
		this.selectedMetricId = selectedMetricId;
	}
	
	public Integer getSelectedMetricId() {
		return selectedMetricId;
	}

    
    public void save() throws DAOException{
    	
    	Profile object = new Profile();
    	object.setName(name);
    	object.setGranurality(granularity);
    	object.setIsWeightedFlag(false);
    	
    	/*String listId = "";
     	for(int i=0; i<listMetricsAdd.size(); i++){
			int id = listMetricsAdd.get(i).getMetricID();
			listId += id + ",";
		}*/
     	
     	object.setMetricIds(""+selectedMetricId);
    	
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
    
    public void addMetric() throws DAOException{
    	
    	if(selectedMetricId!=-1){
    		for(int i=0; i<listMetrics.size(); i++){
    			if(listMetrics.get(i).getMetricID()==selectedMetricId){
    				Metric selectedMetric = new Metric();
    				selectedMetric.setMetricID(listMetrics.get(i).getMetricID());
    				selectedMetric.setName(listMetrics.get(i).getName());
    				listMetricsAdd.add(selectedMetric);
    			}
    		}
    	}
    	
	}
    

}
