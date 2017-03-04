package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.primefaces.event.RowEditEvent;
import org.primefaces.event.SelectEvent;

import entity.Profile;
import entity.ProfileMetric;
import dao.DAOException;
import dao.ProfileBean;
import dao.ProfileBeanRemote;
import dao.ProfileMetricBean;
import dao.ProfileMetricBeanRemote;


@ManagedBean(name="profileBeanList")
@ViewScoped
public class ProfileBeanList {
	
	private List<Profile> listProfile;
	private Profile selectedProfile;
	private List<ProfileMetric> listProfileMetric;
	private ProfileMetric selectedProfileMetric;
	
	@EJB
    private ProfileBeanRemote pDao = new ProfileBean();
	private ProfileMetricBeanRemote pmDao = new ProfileMetricBean();
	
	
	@PostConstruct
	private void init()	{
		try {		
			listProfile = pDao.list();
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<Profile> getListProfile() {
		return listProfile;
	}
	
	public void setListProfile(List<Profile> listProfile) {
		this.listProfile = listProfile;
	}

	public Profile getSelectedProfile() {
		return selectedProfile;
	}

	public void setSelectedProfile(Profile selectedProfile) {
		this.selectedProfile = selectedProfile;
	}
	
	public List<ProfileMetric> getListProfileMetric() {
		return listProfileMetric;
	}

	public void setListProfileMetric(List<ProfileMetric> listProfileMetric) {
		this.listProfileMetric = listProfileMetric;
	}

	public ProfileMetric getSelectedProfileMetric() {
		return selectedProfileMetric;
	}

	public void setSelectedProfileMetric(ProfileMetric selectedProfileMetric) {
		this.selectedProfileMetric = selectedProfileMetric;
	}
			
	public void deleteProfile() {
		pDao.delete(selectedProfile);    	
    	listProfile = pDao.list();
    	selectedProfile = null;
        
		FacesMessage msg = new FacesMessage("Perfil eliminado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
    
    public void onRowSelect(SelectEvent event) {
    	listProfileMetric = pmDao.profileMetricList(selectedProfile);
    }
       	
	public void onRowEdit(RowEditEvent event) {    	
		Profile p = ((Profile) event.getObject());

		pDao.update(p);
		FacesMessage msg = new FacesMessage("Perfil editado correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
	public void removeProfileMetric() {
		//TODO: Terminar
		//pDao.removeProfileMetric(selectedProfile, selectedMetric);    	
		listProfileMetric.remove(selectedProfileMetric);
		selectedProfileMetric = null;
        
		FacesMessage msg = new FacesMessage("Metrica removida correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
}
