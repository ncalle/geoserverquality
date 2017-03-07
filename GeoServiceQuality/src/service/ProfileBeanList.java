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
	private List<ProfileMetric> listBooleanProfileMetric;
	private List<ProfileMetric> listPercentageProfileMetric;
	private List<ProfileMetric> listIntegerProfileMetric;
	private List<ProfileMetric> listEnumeratedProfileMetric;
	private ProfileMetric selectedProfileMetric;
	private ProfileMetric selectedBooleanProfileMetric;
	private ProfileMetric selectedPercentageProfileMetric;
	private ProfileMetric selectedIntegerProfileMetric;
	private ProfileMetric selectedEnumeratedProfileMetric;
	
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
	
	public List<ProfileMetric> getListBooleanProfileMetric() {
		return listBooleanProfileMetric;
	}

	public void setListBooleanProfileMetric(List<ProfileMetric> listBooleanProfileMetric) {
		this.listBooleanProfileMetric = listBooleanProfileMetric;
	}

	public ProfileMetric getSelectedProfileMetric() {
		return selectedProfileMetric;
	}

	public void setSelectedProfileMetric(ProfileMetric selectedProfileMetric) {
		this.selectedProfileMetric = selectedProfileMetric;
	}
	
	public List<ProfileMetric> getListPercentageProfileMetric() {
		return listPercentageProfileMetric;
	}

	public void setListPercentageProfileMetric(List<ProfileMetric> listPercentageProfileMetric) {
		this.listPercentageProfileMetric = listPercentageProfileMetric;
	}
	
	public ProfileMetric getSelectedBooleanProfileMetric() {
		return selectedBooleanProfileMetric;
	}

	public void setSelectedBooleanProfileMetric(ProfileMetric selectedBooleanProfileMetric) {
		this.selectedBooleanProfileMetric = selectedBooleanProfileMetric;
	}

	public ProfileMetric getSelectedPercentageProfileMetric() {
		return selectedPercentageProfileMetric;
	}

	public void setSelectedPercentageProfileMetric(ProfileMetric selectedPercentageProfileMetric) {
		this.selectedPercentageProfileMetric = selectedPercentageProfileMetric;
	}
	
	public List<ProfileMetric> getListIntegerProfileMetric() {
		return listIntegerProfileMetric;
	}

	public void setListIntegerProfileMetric(List<ProfileMetric> listIntegerProfileMetric) {
		this.listIntegerProfileMetric = listIntegerProfileMetric;
	}

	public ProfileMetric getSelectedIntegerProfileMetric() {
		return selectedIntegerProfileMetric;
	}

	public void setSelectedIntegerProfileMetric(ProfileMetric selectedIntegerProfileMetric) {
		this.selectedIntegerProfileMetric = selectedIntegerProfileMetric;
	}
	
	public List<ProfileMetric> getListEnumeratedProfileMetric() {
		return listEnumeratedProfileMetric;
	}

	public void setListEnumeratedProfileMetric(List<ProfileMetric> listEnumeratedProfileMetric) {
		this.listEnumeratedProfileMetric = listEnumeratedProfileMetric;
	}

	public ProfileMetric getSelectedEnumeratedProfileMetric() {
		return selectedEnumeratedProfileMetric;
	}

	public void setSelectedEnumeratedProfileMetric(ProfileMetric selectedEnumeratedProfileMetric) {
		this.selectedEnumeratedProfileMetric = selectedEnumeratedProfileMetric;
	}	
			
	public void deleteProfile() {
		pDao.delete(selectedProfile);    	
    	listProfile = pDao.list();
    	selectedProfile = null;

    	//limpiar todas las listas de metricas de perfil
    	listBooleanProfileMetric = null;
    	listPercentageProfileMetric = null;
    	listIntegerProfileMetric = null;
    	listEnumeratedProfileMetric = null;
    	
		FacesMessage msg = new FacesMessage("Perfil eliminado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
    
    public void onRowSelect(SelectEvent event) {
    	listBooleanProfileMetric = pmDao.profileMetricList(selectedProfile, 1); //UnitID = Booleano

    	listPercentageProfileMetric = pmDao.profileMetricList(selectedProfile, 2); //UnitID = Porcentaje

    	listIntegerProfileMetric = pmDao.profileMetricList(selectedProfile, 3); //UnitID = Milisegundos
    	listIntegerProfileMetric.addAll(pmDao.profileMetricList(selectedProfile, 5)); //UnitID = Entero
    	
    	listEnumeratedProfileMetric = pmDao.profileMetricList(selectedProfile, 4); //UnitID = Basico-Intermedio-Completo
    }
       	
	public void onRowEditProfile(RowEditEvent event) {    	
		Profile p = ((Profile) event.getObject());

		pDao.update(p);
		FacesMessage msg = new FacesMessage("Perfil editado correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
    public void onRowSelectBoolean(SelectEvent event) {
    	selectedProfileMetric = selectedBooleanProfileMetric;

    	selectedPercentageProfileMetric = null;
    	selectedIntegerProfileMetric = null;
    	selectedEnumeratedProfileMetric = null;
    }
    
    public void onRowSelectPercentage(SelectEvent event) {
    	selectedProfileMetric = selectedPercentageProfileMetric;

    	selectedBooleanProfileMetric = null;
    	selectedIntegerProfileMetric = null;
    	selectedEnumeratedProfileMetric = null;
    }
    
    public void onRowSelectInteger(SelectEvent event) {
    	selectedProfileMetric = selectedIntegerProfileMetric;

    	selectedBooleanProfileMetric = null;
    	selectedPercentageProfileMetric = null;
    	selectedEnumeratedProfileMetric = null;
    }
    
    public void onRowSelectEnumerated(SelectEvent event) {
    	selectedProfileMetric = selectedEnumeratedProfileMetric;

    	selectedBooleanProfileMetric = null;
    	selectedPercentageProfileMetric = null;
    	selectedIntegerProfileMetric = null;
    }
	
	public void onRowEditBooleanProfileMetrics(RowEditEvent event) {    	
		ProfileMetric pm = ((ProfileMetric) event.getObject());

		pmDao.update(pm);
		FacesMessage msg = new FacesMessage("Rango de Metrica Booleana editada correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
	public void onRowEditPercentageProfileMetrics(RowEditEvent event) {    	
		ProfileMetric pm = ((ProfileMetric) event.getObject());

		pmDao.update(pm);
		FacesMessage msg = new FacesMessage("Rango de Metrica Porcentaje editado correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
	public void onRowEditIntegerProfileMetrics(RowEditEvent event) {    	
		ProfileMetric pm = ((ProfileMetric) event.getObject());

		pmDao.update(pm);
		FacesMessage msg = new FacesMessage("Rango de Metrica Entera editado correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
	public void onRowEditEnumeratedProfileMetrics(RowEditEvent event) {    	
		ProfileMetric pm = ((ProfileMetric) event.getObject());

		pmDao.update(pm);
		FacesMessage msg = new FacesMessage("Rango de Metrica Enumerada editado correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
	public void removeProfileMetric() {
		pmDao.removeProfileMetric(selectedProfile, selectedProfileMetric);
		
		if (listBooleanProfileMetric.contains(selectedProfileMetric)){
			listBooleanProfileMetric.remove(selectedProfileMetric);			
		}
		
		if (listPercentageProfileMetric.contains(selectedProfileMetric)){
			listPercentageProfileMetric.remove(selectedProfileMetric);			
		}
		
		if (listIntegerProfileMetric.contains(selectedProfileMetric)){
			listIntegerProfileMetric.remove(selectedProfileMetric);			
		}
		
		if (listEnumeratedProfileMetric.contains(selectedProfileMetric)){
			listEnumeratedProfileMetric.remove(selectedProfileMetric);			
		}

		selectedProfileMetric = null;
        
		FacesMessage msg = new FacesMessage("Metrica removida correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
}
