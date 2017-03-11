package service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

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
	private int userId;
	private String profileResult;
	private boolean showResult;

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
			listEvaluation = new ArrayList<>(); //evaluationDao.list();
			showResult = false;
			
			FacesContext context = FacesContext.getCurrentInstance();
			HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
			HttpSession appsession = request.getSession(true);
			userId = (Integer) appsession.getAttribute("userId");
		} catch (DAOException e) {
			e.printStackTrace();
		}
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
	

	public void evaluate() throws DAOException {
		Date date = new Date(Calendar.getInstance().getTime().getTime());
		
		if (selectedMeasurableObject != null && selectedProfile != null) {
			showResult = true;
			List<Integer> listMetrics = new ArrayList<>();
			List<Boolean> listResult = new ArrayList<>();
			
			Iterator<ProfileMetric> iterator = listProfileMetric.iterator();
			while (iterator.hasNext()) {
				listMetrics.add(iterator.next().getMetricID());
			}
			
			System.out.println("Metricas incluidas en listMetrics: " + listMetrics);

			boolean success = false;
			try {

				for (Integer metricId : listMetrics) {
					success = App.ejecuteMetric(metricId, selectedMeasurableObject.getMeasurableObjectURL(), selectedMeasurableObject.getEntityType());
					listResult.add(success);
					System.out.println("MetricId: " + metricId + " Success: " + success);
					
					Evaluation e = new Evaluation();
					
					e.setMetricID(metricId);
					e.setSuccess(success);
					e.setIsEvaluationCompleted(true);
					e.setStartDate(date);
					e.setEndDate(date);
					
					listEvaluation.add(e);
					System.out.println(e.toString());
				}
				
				int profileResultTotal = resultEvaluationProfile(listResult);
				profileResult = profileResultTotal + " % de aprobación";
				//TODO: Guardar este resultado (profileResultTotal) en base 

				boolean evaluationSummaryResultTotal;
				if (profileResultTotal >= 50){
					evaluationSummaryResultTotal = true;
				}
				else {
					evaluationSummaryResultTotal = false;
				}
				
				EvaluationSummary es = new EvaluationSummary();
				
				es.setUserID(userId);
				es.setProfileID(selectedProfile.getProfileId());
				es.setMeasurableObjectID(selectedMeasurableObject.getMeasurableObjectID());
				es.setSuccess(evaluationSummaryResultTotal);
				
				EvaluationSummary evaluationSummaryResult = evaluationSummaryDao.create(es);
				
				System.out.println("getEvaluationSummaryID: " + evaluationSummaryResult.getEvaluationSummaryID());
				
				//cargar cada una de las evaluaciones, asociadas al ID del resumen de evaluacion
				Iterator<Evaluation> evaluation_iterator = listEvaluation.iterator();
				while (evaluation_iterator.hasNext()) {
					Evaluation e = new Evaluation();
					e = evaluation_iterator.next();
					e.setEvaluationSummaryID(evaluationSummaryResult.getEvaluationSummaryID());
					evaluationDao.create(e);
					
					System.out.println("evaluationDao.create(e): " + e);
				}			 

				FacesContext context = FacesContext.getCurrentInstance();
				context.addMessage(null, new FacesMessage("La evaluación se realizó correctamente"));
				
				// Se actualiza el listado de evaluaciones
				listEvaluation = evaluationDao.list();

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
