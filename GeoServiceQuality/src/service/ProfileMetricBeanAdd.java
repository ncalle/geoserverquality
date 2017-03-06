package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.omnifaces.util.Faces;

import dao.DAOException;
import dao.MetricBean;
import dao.MetricBeanRemote;
import dao.ProfileMetricBean;
import dao.ProfileMetricBeanRemote;
import entity.Metric;


@ManagedBean(name="profileMetricBeanAdd")
@ViewScoped
public class ProfileMetricBeanAdd {

	private List<Metric> listProfileMetrics;
	private Metric profileMetric;
	private Integer profileID;
    
	@EJB
	private ProfileMetricBeanRemote pmDao = new ProfileMetricBean();
	private MetricBeanRemote mDao = new MetricBean();
	
	@PostConstruct
	private void init()	{
		Metric selectedMetric = (Metric) Faces.getRequestAttribute("selectedMetric");
		this.setProfileID(1); //this.setProfileID(selectedProfile.getProdileId());
		//System.out.println("selectedMetric.. " + selectedMetric);
		listProfileMetrics = mDao.profileMetricsToAddGet(1); //profileID
		//TODO: Parametrizar llamada una vez que se pueda pasar el profileID como parametro entre las vistas
	}
	
	public List<Metric> getListProfileMetrics() {
		return listProfileMetrics;
	}


	public void setListProfileMetrics(List<Metric> listProfileMetrics) {
		this.listProfileMetrics = listProfileMetrics;
	}


	public Metric getProfileMetric() {
		return profileMetric;
	}


	public void setProfileMetric(Metric profileMetric) {
		this.profileMetric = profileMetric;
	}


	public Integer getProfileID() {
		return profileID;
	}


	public void setProfileID(Integer profileID) {
		this.profileID = profileID;
	}
		
	public void save() {
    	FacesMessage msg;

    	try{
    		pmDao.profileAddMetric(profileID, profileMetric);
    		msg = new FacesMessage("La Metrica fue asociado al Perfil de manera correcta.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
    	} catch(DAOException e) {   		
    		msg = new FacesMessage("Error al asociar la Metrica con el Perfil.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
    	}
	}
}
