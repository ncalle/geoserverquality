package service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.omnifaces.util.Faces;
import org.primefaces.event.RowEditEvent;
import org.primefaces.event.SelectEvent;
import org.primefaces.model.DefaultTreeNode;
import org.primefaces.model.TreeNode;

import entity.Metric;
import entity.Profile;
import entity.ProfileMetric;
import dao.DAOException;
import dao.MetricBean;
import dao.MetricBeanRemote;
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
	
	private boolean showMore;
	private boolean showMoreWeighing;
	
	private List<Metric> listProfileMetrics;
	private Metric profileMetric;
	private Integer profileID;
	
    private TreeNode weighingRoot;
	
	@EJB
    private ProfileBeanRemote pDao = new ProfileBean();
	private ProfileMetricBeanRemote pmDao = new ProfileMetricBean();
	private MetricBeanRemote mDao = new MetricBean();
	
	
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
	
	public void setShowMore(boolean showMore) {
		this.showMore = showMore;
	}
	
	public void showMore() {
		this.showMore = true;
		filterMetricsByGranularity();
	}
	
	public void showLess() {
		this.showMore = false;
	}
	
	public boolean isShowMore() {
		return showMore;
	}
	
	public void setShowMoreWeighing(boolean showMoreWeighing) {
		this.showMoreWeighing = showMoreWeighing;
	}
	
	public void showMoreWeighing() {
		this.showMoreWeighing = true;
		weighingRoot = createQualityWeights();
	}
	
	public void showLessWeighing() {
		this.showMoreWeighing = false;
	}
	
	public boolean isShowMoreWeighing() {
		return showMoreWeighing;
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

	public TreeNode getWeighingRoot() {
		return weighingRoot;
	}

	public void setWeighingRoot(TreeNode weighingRoot) {
		this.weighingRoot = weighingRoot;
	}
		
	public void save() {
    	FacesMessage msg;

    	try{
    		
    		int selectedProfileID = selectedProfile.getProfileId();
    		
    		if(profileMetric!=null){
    			pmDao.profileAddMetric(selectedProfileID, profileMetric);
    			filterMetricsByGranularity();
    			    			
    	    	 switch (profileMetric.getUnitID()) { //Boleano, Porcentaje, Milisegundos, Basico-Intermedio-Completo, Entero
    				case 1: //Boleano
    					listBooleanProfileMetric = pmDao.profileMetricList(selectedProfile, 1); //UnitID = Booleano
    					break;
    				case 2: //Porcentaje
    					listPercentageProfileMetric = pmDao.profileMetricList(selectedProfile, 2); //UnitID = Porcentaje
    					break;
    				case 3: //Milisegundos
    					listIntegerProfileMetric = pmDao.profileMetricList(selectedProfile, 3); //UnitID = Milisegundos
    					break;
    				case 4: //Basico-Intermedio-Completo
    					listEnumeratedProfileMetric = pmDao.profileMetricList(selectedProfile, 4); //UnitID = Basico-Intermedio-Completo
    					break;
    				case 5: //Entero
    					listIntegerProfileMetric.addAll(pmDao.profileMetricList(selectedProfile, 5)); //UnitID = Entero
    					break;    		
    				default:
    					listBooleanProfileMetric = null;
    					listPercentageProfileMetric = null;
    					listIntegerProfileMetric = null;
    					listEnumeratedProfileMetric = null;
    					listIntegerProfileMetric = null;
    					selectedProfileMetric = null;
    					selectedBooleanProfileMetric = null;
    					selectedPercentageProfileMetric = null;
    					selectedIntegerProfileMetric = null;
    					selectedEnumeratedProfileMetric = null;
    					break;
    				}
        		
        		msg = new FacesMessage("La Metrica fue asociado al Perfil de manera correcta.");
                FacesContext.getCurrentInstance().addMessage(null, msg);
    		}
    		
    	} catch(DAOException e) {   		
    		msg = new FacesMessage("Error al asociar la Metrica con el Perfil.");
            FacesContext.getCurrentInstance().addMessage(null, msg);
    	}
	}
	
	public void filterMetricsByGranularity(){
		listProfileMetrics = new ArrayList<>();
		List<Metric> listMetrics = mDao.profileMetricsToAddGet(selectedProfile.getProfileId());
		for(Metric m:listMetrics){
			if(m.getGranurality().equals(selectedProfile.getGranurality())){
				listProfileMetrics.add(m);
			}
		}
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
	
    public void onWeighingRowEdit(RowEditEvent event) {
        FacesMessage msg = new FacesMessage("Ponderación editada", ((TreeNode) event.getObject()).toString());
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
     
    public void onWeighingRowCancel(RowEditEvent event) {
        FacesMessage msg = new FacesMessage("Edición cancelada", ((TreeNode) event.getObject()).toString());
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	
	//TODO: obtener datos de la base. De momento a modo de prueba estan hardcoded
    public TreeNode createQualityWeights() {
        TreeNode root = new DefaultTreeNode(new QualityWeight("Calidad del servicio", "1", "Modelo"), null);
         
        TreeNode dimension1 = new DefaultTreeNode(new QualityWeight("Seguridad", "1/3", "Dimension"), root);
        TreeNode dimension2 = new DefaultTreeNode(new QualityWeight("Confiabilidad", "1/3", "Dimension"), root);
        TreeNode dimension3 = new DefaultTreeNode(new QualityWeight("Interoperabilidad", "1/3", "Dimension"), root);
         
        TreeNode factor11 = new DefaultTreeNode(new QualityWeight("Protección", "1", "Factor"), dimension1);
        TreeNode factor12 = new DefaultTreeNode(new QualityWeight("Disponibilidad", "1", "Factor"), dimension2);
        TreeNode factor13 = new DefaultTreeNode(new QualityWeight("Soporte de estándares", "1", "Factor"), dimension3);
        
        TreeNode metric111 = new DefaultTreeNode(new QualityWeight("Información en excepciones", "1", "Métrica"), factor11);
        TreeNode metric112 = new DefaultTreeNode(new QualityWeight("Disponibilidad diaria del servicio", "1", "Métrica"), factor12);
        TreeNode metric113 = new DefaultTreeNode(new QualityWeight("Excepciones en formato OGC", "0", "Métrica"), factor13);
        TreeNode metric213 = new DefaultTreeNode(new QualityWeight("Capas del servicio con CRS adecuado (IDEuy)", "1", "Métrica"), factor13);

        TreeNode range1111 = new DefaultTreeNode(new QualityWeight("true", "1", "Rango"), metric111);
        TreeNode range1112 = new DefaultTreeNode(new QualityWeight("mayor a 30%", "1", "Rango"), metric112);
        TreeNode range1113 = new DefaultTreeNode(new QualityWeight("true", "0", "Rango"), metric113);
        TreeNode range1213 = new DefaultTreeNode(new QualityWeight("mayor a 75%", "1", "Rango"), metric213);
                 
        return root;
    }

}
