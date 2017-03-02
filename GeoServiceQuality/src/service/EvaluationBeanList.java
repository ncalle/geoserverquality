package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import EvaluationCore.App;
import entity.Evaluation;
import entity.MeasurableObject;
import entity.Profile;
import dao.DAOException;
import dao.EvaluationBean;
import dao.EvaluationBeanRemote;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;
import dao.ProfileBean;
import dao.ProfileBeanRemote;


@ManagedBean(name="evaluationBeanList")
@RequestScoped
public class EvaluationBeanList {
	
    
	private List<Evaluation> list;
	private List<Profile> listProfile;
	private List<MeasurableObject> listObjects;
	private int selectedProfileId, selectedObjectId;
	private int userId;
	
	
	@EJB
    private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	
	@EJB
    private EvaluationBeanRemote evaluationDao = new EvaluationBean();
	
	@EJB
    private ProfileBeanRemote profileDao = new ProfileBean();
	
	
	public void setSelectedProfileId(int selectedProfileId) {
		this.selectedProfileId = selectedProfileId;
	}
	
	public int getSelectedProfileId() {
		return selectedProfileId;
	}
	
	public void setSelectedObjectId(int selectedObjectId) {
		this.selectedObjectId = selectedObjectId;
	}
	
	public int getSelectedObjectId() {
		return selectedObjectId;
	}
	
	public List<MeasurableObject> getListObjects() {
		return listObjects;
	}
	
	public List<Profile> getListProfile() {
		return listProfile;
	}
	
	public void setListObjects(List<MeasurableObject> listObjects) {
		this.listObjects = listObjects;
	}
	
	public void setListProfile(List<Profile> listProfile) {
		this.listProfile = listProfile;
	}
	
	public List<Evaluation> getList() {
		return list;
	}
	
	public void setList(List<Evaluation> list) {
		this.list = list;
	}
	
	@PostConstruct
	private void init()	{
		try {
			
            list = evaluationDao.list();
            
            listProfile = profileDao.list();
            
            listObjects = moDao.list();
            
            FacesContext context = FacesContext.getCurrentInstance();
            HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
            HttpSession appsession = request.getSession(true);
            userId = (Integer)appsession.getAttribute("userId");
	            
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	 public void evaluate() throws DAOException{
		 
		 //Cargo el objeto medible seleccionado
		 MeasurableObject m = null;
		 for(int i=0; i<listObjects.size(); i++){
			int id = listObjects.get(i).getMeasurableObjectID();
			if(id==selectedObjectId){
				m = listObjects.get(i);
			}
		}
		 
		//Cargo el perfil seleccionado
		 Profile p = null;
		 for(int i=0; i<listProfile.size(); i++){
			int id = listProfile.get(i).getProfileId();
			if(id==selectedObjectId){
				p = listProfile.get(i);
			}
		}
		 
		 if(m!=null && p!=null){
			 System.out.println( "loadMetrics -------------------- " + p.getMetricIds());
			 
			 String listMetrics = "0"; //p.getMetricIds();
			 
			 boolean success = App.loadMetrics(listMetrics, m.getMeasurableObjectURL(), m.getMeasurableObjectType());
			 
			 Evaluation e = new Evaluation();
			 e.setProfileID(selectedProfileId);
			 e.setUserID(userId);
			 e.setSuccess(success);
			 e.setIsEvaluationCompleted(true);
			 
			 System.out.println("evaluate.. selectedObjectId: " + selectedObjectId + " selectedProfileId: " + selectedProfileId
					 + " success: " + success);
			 
			 try{
				 evaluationDao.create(e);
		            
	            FacesContext context = FacesContext.getCurrentInstance();
	    		context.addMessage(null, new FacesMessage("La evaluación se realizó correctamente"));
	    		
	    	} catch(DAOException ex) {
	    		
	    		FacesContext context = FacesContext.getCurrentInstance();
	    		context.addMessage(null, new FacesMessage("Error al realizar la evaluación"));
	    		
	    		ex.printStackTrace();
	    	} 
			 
		 } else {
			 FacesContext context = FacesContext.getCurrentInstance();
	    	 context.addMessage(null, new FacesMessage("Error al realizar la evaluación"));
		 }
		 
	 }
	

}
