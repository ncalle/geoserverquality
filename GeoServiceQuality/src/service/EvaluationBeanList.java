package service;

import java.util.ArrayList;
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
import entity.MeasurableObject;
import entity.Profile;
import entity.ProfileMetric;
import dao.DAOException;
import dao.EvaluationBean;
import dao.EvaluationBeanRemote;
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

	@EJB
	private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	private EvaluationBeanRemote evaluationDao = new EvaluationBean();
	private ProfileBeanRemote profileDao = new ProfileBean();
	private ProfileMetricBeanRemote pmDao = new ProfileMetricBean();

	
	@PostConstruct
	private void init() {
		try {
			listProfile = profileDao.list();
			listMeasurableObjects = moDao.list();
			listEvaluation = evaluationDao.list();
			
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
		listProfileMetric = pmDao.profileMetricList(selectedProfile);
	}
	

	public void evaluate() throws DAOException {
		// Cargo el objeto medible seleccionado
		MeasurableObject m = null;
		for (int i = 0; i < listMeasurableObjects.size(); i++) {
			int id = listMeasurableObjects.get(i).getMeasurableObjectID();
			if (id == selectedMeasurableObject.getMeasurableObjectID()) {
				m = listMeasurableObjects.get(i);
			}
		}

		// Cargo el perfil seleccionado
		Profile p = null;
		for (int i = 0; i < listProfile.size(); i++) {
			int id = listProfile.get(i).getProfileId();
			if (id == selectedProfile.getProfileId()) {
				p = listProfile.get(i);
			}
		}

		if (m != null && p != null) {
			List<Integer> listMetrics = new ArrayList<>();
			
			Iterator<ProfileMetric> iterator = listProfileMetric.iterator();
			while (iterator.hasNext()) {
				listMetrics.add(iterator.next().getMetricID());
			}
			
			System.out.println("Metricas incluidas en listMetrics: " + listMetrics);

			boolean success = false;
			try {

				for (Integer metricId : listMetrics) {
					success = App.ejecuteMetric(metricId, m.getMeasurableObjectURL(), m.getMeasurableObjectType());

					Evaluation e = new Evaluation();
					e.setProfileID(selectedProfile.getProfileId());
					e.setUserID(userId);
					e.setSuccess(success);
					e.setIsEvaluationCompleted(true);

					System.out.println("Evaluation: ObjectId: " + selectedMeasurableObject.getMeasurableObjectID() + " MetricId: "
							+ metricId + " Success: " + success);

					evaluationDao.create(e);
				}

				FacesContext context = FacesContext.getCurrentInstance();
				context.addMessage(null, new FacesMessage("La evaluación se realizó correctamente"));

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
}
