package service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.primefaces.event.SelectEvent;

import EvaluationCore.App;
import entity.Evaluation;
import entity.EvaluationSummary;
import entity.MeasurableObject;
import entity.Profile;
import entity.ProfileMetric;
import dao.DAOException;
import dao.EvaluationBean;
import dao.EvaluationBeanRemote;
import dao.EvaluationSummaryBean;
import dao.EvaluationSummaryBeanRemote;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;
import dao.ProfileBean;
import dao.ProfileBeanRemote;
import dao.ProfileMetricBean;
import dao.ProfileMetricBeanRemote;

@ManagedBean(name = "evaluationBeanList")
@ViewScoped
public class EvaluationBeanList {

	private List<Evaluation> listEvaluation;
	private List<Profile> listProfile;
	private Profile selectedProfile;
	private List<MeasurableObject> listMeasurableObjects;
	private MeasurableObject selectedMeasurableObject;
	private List<ProfileMetric> listProfileMetric;
	private int userId, manualMetricID;
	private String profileResult;
	private boolean showResult, showConfirm;
	Map<Integer, Boolean> resultMap = new HashMap<>();

	@EJB
	private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	private EvaluationBeanRemote evaluationDao = new EvaluationBean();
	private EvaluationSummaryBeanRemote evaluationSummaryDao = new EvaluationSummaryBean();
	private ProfileBeanRemote profileDao = new ProfileBean();
	private ProfileMetricBeanRemote pmDao = new ProfileMetricBean();

	
	@PostConstruct
	private void init() {
		try {
			listProfile = profileDao.list();
			listMeasurableObjects = moDao.list();
			listEvaluation = new ArrayList<>(); 
			showResult = false;
			resultMap =  new HashMap<Integer, Boolean>();
			
			FacesContext context = FacesContext.getCurrentInstance();
			HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
			HttpSession appsession = request.getSession(true);
			userId = (Integer) appsession.getAttribute("userId");
			
		} catch (DAOException e) {
			e.printStackTrace();
		}
	}
	 
	public void confirmationNegative() {
        showConfirm = false;
        resultMap.put(manualMetricID, false);
        evaluate();
    }
	
	public void confirmationPositive() {
        showConfirm = false;
        resultMap.put(manualMetricID, true);
        evaluate();
    }
	
	 public void addMessage(String summary, String detail) {
        FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, summary, detail);
        FacesContext.getCurrentInstance().addMessage(null, message);
    }
	 
	public Profile getSelectedProfile() {
		return selectedProfile;
	}

	public void setSelectedProfile(Profile selectedProfile) {
		this.selectedProfile = selectedProfile;
	}

	public List<Profile> getListProfile() {
		return listProfile;
	}

	public void setListProfile(List<Profile> listProfile) {
		this.listProfile = listProfile;
	}

	public List<Evaluation> getListEvaluation() {
		return listEvaluation;
	}

	public void setListEvaluation(List<Evaluation> listEvaluation) {
		this.listEvaluation = listEvaluation;
	}


	public List<MeasurableObject> getListMeasurableObjects() {
		return listMeasurableObjects;
	}


	public void setListMeasurableObjects(List<MeasurableObject> listMeasurableObjects) {
		this.listMeasurableObjects = listMeasurableObjects;
	}


	public MeasurableObject getSelectedMeasurableObject() {
		return selectedMeasurableObject;
	}


	public void setSelectedMeasurableObject(MeasurableObject selectedMeasurableObject) {
		this.selectedMeasurableObject = selectedMeasurableObject;
	}


	public List<ProfileMetric> getListProfileMetric() {
		return listProfileMetric;
	}


	public void setListProfileMetric(List<ProfileMetric> listProfileMetric) {
		this.listProfileMetric = listProfileMetric;
	}
	

	public void onRowSelect(SelectEvent event) {
		listProfileMetric = pmDao.profileMetricList(selectedProfile, null);
	}
	
	public void onRowSelectProfile(SelectEvent event) {
		List<MeasurableObject> list = new ArrayList<>();
		for(MeasurableObject mo : listMeasurableObjects){
			if(mo.getEntityType().equals(selectedProfile.getGranurality())) {
				list.add(mo);
			}
		}
		listMeasurableObjects = list;
	}
	
	public void setProfileResult(String profileResult) {
		this.profileResult = profileResult;
	}
	
	public String getProfileResult() {
		return profileResult;
	}
	
	public void setShowResult(boolean showResult) {
		this.showResult = showResult;
	}
	
	public boolean isShowResult() {
		return showResult;
	}
	
	public boolean isShowConfirm() {
		return showConfirm;
	}
	
	public void setShowConfirm(boolean show) {
		this.showConfirm = show;
	}
	
	

	public void evaluate() throws DAOException {
		
		if (selectedMeasurableObject != null && selectedProfile != null) {
		
			Date date = new Date(Calendar.getInstance().getTime().getTime());
			List<Boolean> listResult = new ArrayList<>();
			listEvaluation = new ArrayList<>();
			int manualEvaluation=0;
			Iterator<ProfileMetric> iterator = listProfileMetric.iterator();
			
			while (iterator.hasNext()) {
				ProfileMetric pm = (ProfileMetric) iterator.next();
				
				if(pm.getMetricManual()){
					manualEvaluation++;
					
					if(manualEvaluation > resultMap.size()){
						manualMetricID = pm.getMetricID();
						break;
					}
				}
			}
			
			if(manualEvaluation > resultMap.size()){
				showConfirm = true;
				return;
			}
		

			boolean success = false;
			int acceptanceValue = 0;
			try {
				
				for (ProfileMetric metric : listProfileMetric) {
					int metricId = metric.getMetricID();
					
					if(metric.getMetricManual()) {
						success = resultMap.get(metric.getMetricID());
					} else {
						acceptanceValue = metric.getUnitID()==2? metric.getPercentageAcceptanceValue(): metric.getIntegerAcceptanceValue();
						success = App.ejecuteMetric(metricId, selectedMeasurableObject.getMeasurableObjectURL(), selectedMeasurableObject.getMeasurableObjectServicesType(), acceptanceValue, "");
					}
					listResult.add(success);
					//System.out.println("MetricId: " + metricId + " Success: " + success + " ServiceType: " + selectedMeasurableObject.getMeasurableObjectServicesType() + " MO:" + selectedMeasurableObject.getMeasurableObjectURL());
					
					Evaluation e = new Evaluation();
					
					e.setMetricID(metricId);
					e.setSuccess(success);
					e.setIsEvaluationCompleted(true);
					e.setStartDate(date);
					e.setEndDate(date);
					e.setMetricName(metric.getMetricName());
					e.setQualityModelName(metric.getQualityModelName());
					e.setProfileName(selectedProfile.getName());
					listEvaluation.add(e);
				}
				
				
				int profileResultTotal = resultEvaluationProfile(listResult);
				profileResult = profileResultTotal + " % de aprobación";

				boolean evaluationSummaryResultTotal;
				if (profileResultTotal >= 50){
					evaluationSummaryResultTotal = true;
				} else {
					evaluationSummaryResultTotal = false;
				}
				
				EvaluationSummary es = new EvaluationSummary();
				
				es.setUserID(userId);
				es.setProfileID(selectedProfile.getProfileId());
				es.setMeasurableObjectID(selectedMeasurableObject.getMeasurableObjectID());
				es.setSuccess(evaluationSummaryResultTotal);
				es.setSuccessPercentage(profileResultTotal);
				
				EvaluationSummary evaluationSummaryResult = evaluationSummaryDao.create(es);
				
				//cargar cada una de las evaluaciones, asociadas al ID del resumen de evaluacion
				Iterator<Evaluation> evaluation_iterator = listEvaluation.iterator();
				Evaluation e;
				while (evaluation_iterator.hasNext()) {
					e = evaluation_iterator.next();
					e.setEvaluationSummaryID(evaluationSummaryResult.getEvaluationSummaryID());
					evaluationDao.create(e);
				}
				
				showResult = true;
				FacesContext context = FacesContext.getCurrentInstance();
				context.addMessage(null, new FacesMessage("La evaluación se realizó correctamente"));
				
				resultMap =  new HashMap<Integer, Boolean>();
				
			} catch (DAOException ex) {

				FacesContext context = FacesContext.getCurrentInstance();
				context.addMessage(null, new FacesMessage("Error al realizar la evaluación"));

				ex.printStackTrace();
			}

		} else {
			FacesContext context = FacesContext.getCurrentInstance();
			context.addMessage(null, new FacesMessage("Error al realizar la evaluación"));
		}

	}
	
	public int resultEvaluationProfile(List<Boolean> listResult) {
		int count = 0;
		for (int i = 0; i < listResult.size(); i++) {
			if(listResult.get(i)){
				count++;
			}
		}
		return (count*100)/listResult.size();
	}
}
