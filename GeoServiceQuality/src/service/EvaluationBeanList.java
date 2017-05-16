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

import org.primefaces.event.NodeExpandEvent;
import org.primefaces.event.NodeSelectEvent;
import org.primefaces.event.SelectEvent;
import org.primefaces.model.DefaultTreeNode;
import org.primefaces.model.TreeNode;

import EvaluationCore.App;
import entity.Evaluation;
import entity.EvaluationSummary;
import entity.IdeTreeStructure;
import entity.MeasurableObject;
import entity.Profile;
import entity.ProfileMetric;
import entity.QualityWeightTreeStructure;
import dao.DAOException;
import dao.EvaluationBean;
import dao.EvaluationBeanRemote;
import dao.EvaluationSummaryBean;
import dao.EvaluationSummaryBeanRemote;
import dao.IdeTreeStructureBean;
import dao.IdeTreeStructureBeanRemote;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;
import dao.ProfileBean;
import dao.ProfileBeanRemote;
import dao.ProfileMetricBean;
import dao.ProfileMetricBeanRemote;
import dao.QualityWeightTreeStructureBean;
import dao.QualityWeightTreeStructureBeanRemote;


@ManagedBean(name = "evaluationBeanList")
@ViewScoped
public class EvaluationBeanList {

	private List<Evaluation> listEvaluation;
	private List<Profile> listProfile;
	private Profile selectedProfile;
	private List<MeasurableObject> listMeasurableObjectsToShow;
	private MeasurableObject selectedMeasurableObject;
	private List<ProfileMetric> listProfileMetric;
	private int userId, manualMetricID;
	private String profileResult;
	private boolean showResult, showConfirm;
	Map<Integer, Boolean> resultMap = new HashMap<>();
	
	private List<IdeTreeStructure> listIdeStructure;
	private List<MeasurableObject> listObjects;
	
	private TreeNode root;
	private TreeNode selectedNode;
	private MeasurableObject selectedTreeNode;
	private String profileGranularity;
	
	private List <MeasurableObject> listIdeMO;
	private List <MeasurableObject> listInstitutionMO;
	private List <MeasurableObject> listNodeMO;

	@EJB
	private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	private EvaluationBeanRemote evaluationDao = new EvaluationBean();
	private EvaluationSummaryBeanRemote evaluationSummaryDao = new EvaluationSummaryBean();
	private ProfileBeanRemote profileDao = new ProfileBean();
	private ProfileMetricBeanRemote pmDao = new ProfileMetricBean();
	private IdeTreeStructureBeanRemote ideTreeDao = new IdeTreeStructureBean();
	private List<QualityWeightTreeStructure> listQualityWeight;
	private QualityWeightTreeStructureBeanRemote qwDao = new QualityWeightTreeStructureBean();
	
	@PostConstruct
	private void init() {
		try {
			listProfile = profileDao.list();		
			
			listEvaluation = new ArrayList<>(); 
			showResult = false;
			resultMap =  new HashMap<Integer, Boolean>();
			
			FacesContext context = FacesContext.getCurrentInstance();
			HttpServletRequest request = (HttpServletRequest) context.getExternalContext().getRequest();
			HttpSession appsession = request.getSession(true);
			userId = (Integer) appsession.getAttribute("userId");

			listIdeStructure = ideTreeDao.list(userId);
            createTree();	
			
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
	
	public List<MeasurableObject> getListMeasurableObjectsToShow() {
		return listMeasurableObjectsToShow;
	}

	public void setListMeasurableObjectsToShow(List<MeasurableObject> listMeasurableObjectsToShow) {
		this.listMeasurableObjectsToShow = listMeasurableObjectsToShow;
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
	
	public MeasurableObject getSelectedTreeNode() {
		return selectedTreeNode;
	}

	public void setSelectedTreeNode(MeasurableObject selectedTreeNode) {
		this.selectedTreeNode = selectedTreeNode;
	}	
	
	public List<MeasurableObject> getListObjects() {
		return listObjects;
	}
	
	public void setListObjects(List<MeasurableObject> listObjects) {
		this.listObjects = listObjects;
	}
	
	public String getProfileGranularity() {
		return profileGranularity;
	}

	public void setProfileGranularity(String profileGranularity) {
		this.profileGranularity = profileGranularity;
	}
	
	public void onRowSelectProfile(SelectEvent event) {
		List<MeasurableObject> list = new ArrayList<>();
		
		listProfileMetric = pmDao.profileMetricList(selectedProfile, null);
		listObjects = new ArrayList();
		
		if (listObjects != null){
			for(MeasurableObject mo : listObjects){
				if(mo.getEntityType().equals(selectedProfile.getGranurality())) {
					list.add(mo);
				}
			}
		}
		listMeasurableObjectsToShow = list;
		
		if (selectedProfile.getGranurality().equals("Servicio") || selectedProfile.getGranurality().equals("Capa")){
			profileGranularity = "Low";
		}
		else{
			profileGranularity = "High";
		}
		
		//limpio la tabla de objetos de granularidad alta
		selectedTreeNode = null;
		
		//se calcula hash con peso total de cada rama del arbol de ponderaciones
		if(selectedProfile.getIsWeightedFlag()){
			calculateWeight();
		}
		
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
	
    public TreeNode getRoot() {
        return root;
    }
    
	public List<MeasurableObject> getListIdeMO() {
		return listIdeMO;
	}

	public void setListIdeMO(List<MeasurableObject> listIdeMO) {
		this.listIdeMO = listIdeMO;
	}
	
	public List<IdeTreeStructure> getListIdeStructure() {
		return listIdeStructure;
	}

	public void setListIdeStructure(List<IdeTreeStructure> listIdeStructure) {
		this.listIdeStructure = listIdeStructure;
	}

	public List <MeasurableObject> getListInstitutionMO() {
		return listInstitutionMO;
	}

	public void setListInstitutionMO(List <MeasurableObject> listInstitutionMO) {
		this.listInstitutionMO = listInstitutionMO;
	}

	public List <MeasurableObject> getListNodeMO() {
		return listNodeMO;
	}

	public void setListNodeMO(List <MeasurableObject> listNodeMO) {
		this.listNodeMO = listNodeMO;
	}
	
    public TreeNode getSelectedNode() {
        return selectedNode;
    }
 
    public void setSelectedNode(TreeNode selectedNode) {
        this.selectedNode = selectedNode;
    }
    
	public void createTree(){
        root = new DefaultTreeNode("Ides", null);
        List <Integer> listIde = new ArrayList<>();
        List <Integer> listInstitution = new ArrayList<>();
        List <Integer> listNode = new ArrayList<>();
        
        listIdeMO = new ArrayList<>();
        listInstitutionMO = new ArrayList<>();
        listNodeMO = new ArrayList<>();
        
        if (listIdeStructure != null){
        	System.out.println("TREE: " + listIdeStructure);
        				
			for (IdeTreeStructure ide : listIdeStructure) {
				if ((!listIde.contains(ide.getIdeID()))){
					listIde.add(ide.getIdeID());
					
					MeasurableObject ideMO = new MeasurableObject();
					ideMO.setEntityType("Ide");
					ideMO.setEntityID(ide.getIdeID());
					ideMO.setMeasurableObjectID(ide.getIdeMeasurableObjectID());
					ideMO.setMeasurableObjectName(ide.getIdeName());
					ideMO.setMeasurableObjectDescription(ide.getIdeDescription());
					listIdeMO.add(ideMO);
					
					TreeNode tIde = new DefaultTreeNode(ide.getIdeName(), root);
					
					for (IdeTreeStructure institution : listIdeStructure) {
						if ((!listInstitution.contains(institution.getInstitutionID()))
								&& ide.getIdeID() == institution.getIdeID()) {
							listInstitution.add(institution.getInstitutionID());
							
							MeasurableObject institutionMO = new MeasurableObject();
							institutionMO.setEntityType("Institución");
							institutionMO.setEntityID(institution.getInstitutionID());
							institutionMO.setMeasurableObjectID(institution.getInstitutionMeasurableObjectID());
							institutionMO.setMeasurableObjectName(institution.getInstitutionName());
							institutionMO.setMeasurableObjectDescription(institution.getInstitutionDescription());
							listInstitutionMO.add(institutionMO);
							
							TreeNode tInstitution = new DefaultTreeNode(institution.getInstitutionName(), tIde);
							
							for (IdeTreeStructure node : listIdeStructure) {
								if ((!listNode.contains(node.getNodeID()))
										&& institution.getInstitutionID() == node.getInstitutionID()) {
									listNode.add(node.getNodeID());
									
									MeasurableObject nodeMO = new MeasurableObject();
									nodeMO.setEntityType("Nodo");
									nodeMO.setEntityID(node.getNodeID());
									nodeMO.setMeasurableObjectID(node.getNodeMeasurableObjectID());
									nodeMO.setMeasurableObjectName(node.getNodeName());
									nodeMO.setMeasurableObjectDescription(node.getNodeDescription());
									listNodeMO.add(nodeMO);
									
									TreeNode tNode = new DefaultTreeNode(node.getNodeName(), tInstitution);
								}
							}
						}
					}						
				}
			}
        }
	}
	
    public void onNodeSelect(NodeSelectEvent event) {
    	selectedMeasurableObject = null;
    	
    	if (selectedProfile != null){
        	if (selectedNode != null && selectedNode.getRowKey() != null) {
            	String rowKey = selectedNode.getRowKey();
            	Integer numberOfUnderscore = rowKey.length() - rowKey.replace("_", "").length();
            	MeasurableObject element;
            	
        		switch (numberOfUnderscore) {
    			case 0:
    				listObjects = moDao.servicesAndLayerGet(null, selectedNode.getData().toString(), "Ide");
    				
    				if(selectedProfile.getGranurality().equals("Ide") || profileGranularity.equals("Low")){
    					Iterator<MeasurableObject> ideItr = listIdeMO.iterator();
        				while(ideItr.hasNext()) {
        					element = ideItr.next();
        					if (element.getMeasurableObjectName().equals(selectedNode.getData())){
        						selectedTreeNode = element;						
        					}
        				}
    				}
    				
    				break;
    			case 1:
    				listObjects = moDao.servicesAndLayerGet(null, selectedNode.getData().toString(), "Institución");
    				
    				if(selectedProfile.getGranurality().equals("Institución") || profileGranularity.equals("Low")){
    					Iterator<MeasurableObject> instItr = listInstitutionMO.iterator();

        				while(instItr.hasNext()) {
        					element = instItr.next();
        					if (element.getMeasurableObjectName().equals(selectedNode.getData())){
        						selectedTreeNode = element;						
        					}
        				}
    				}
    				
    				break;
    			case 2:			
    				listObjects = moDao.servicesAndLayerGet(null, selectedNode.getData().toString(), "Nodo");
    				
    				if(selectedProfile.getGranurality().equals("Nodo") || profileGranularity.equals("Low")){
    					Iterator<MeasurableObject> nodeItr = listNodeMO.iterator();

        				while(nodeItr.hasNext()) {
        					element = nodeItr.next();
        					if (element.getMeasurableObjectName().equals(selectedNode.getData())){
        						selectedTreeNode = element;						
        					}
        				}
    				}
    				
    				break;
    			default:
    				break;
    			}
        		
        		List<MeasurableObject> list = new ArrayList<>();
        		
        		for(MeasurableObject mo : listObjects){
        			if(mo.getEntityType().equals(selectedProfile.getGranurality())) {
        				list.add(mo);
        			}
        		}
        		listMeasurableObjectsToShow = list;
        	}
    	}    	    	
    }


	public void evaluate() throws DAOException {
		
		if ((selectedMeasurableObject != null || selectedTreeNode != null) && selectedProfile != null) {
			
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
			
			try {
				
				List<MeasurableObject> listMO = new ArrayList<>();
				
				if(profileGranularity.equals("High") && selectedTreeNode != null){
					
					for (MeasurableObject obj : listObjects) {
						if(obj.getEntityType().equals("Servicio")){
							listMO.add(obj);
						}
						
					}
					
				} else {
					listMO.add(selectedMeasurableObject);
				}
				
				System.out.println("selectedTreeNode::" + selectedTreeNode.toString());
				
				System.out.println("listMO::" + listMO.toString());
				
				for (MeasurableObject moItem : listMO) {
					
					for (ProfileMetric metric : listProfileMetric) {
						success = evaluationMetric(metric, moItem);
						listResult.add(success);
						
						Evaluation e = new Evaluation();
						e.setMetricID(metric.getMetricID());
						e.setSuccess(success);
						e.setIsEvaluationCompleted(true);
						e.setEvaluationCount(1);
						e.setEvaluationApprovedValue(success?1:0);
						e.setStartDate(date);
						e.setEndDate(date);
						e.setMetricName(metric.getMetricName());
						e.setQualityModelName(metric.getQualityModelName());
						e.setProfileName(selectedProfile.getName());
						e.setMeasurableObjectName(moItem.getMeasurableObjectDescription());
						e.setEntityType(selectedTreeNode.getMeasurableObjectName());
						
						listEvaluation.add(e);
					}
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
				es.setMeasurableObjectID(selectedMeasurableObject!=null?selectedMeasurableObject.getMeasurableObjectID():selectedTreeNode.getMeasurableObjectID());
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
				
			} catch (Exception ex) {

				FacesContext context = FacesContext.getCurrentInstance();
				context.addMessage(null, new FacesMessage("Error al realizar la evaluación"));

				ex.printStackTrace();
			}

		} else {
			FacesContext context = FacesContext.getCurrentInstance();
			context.addMessage(null, new FacesMessage("Falto seleccionar un perfil o un objeto a evaluar"));
		}

	}
	
	public boolean evaluationMetric(ProfileMetric metric, MeasurableObject selectedMeasurableObject){
		Boolean success = false;
		int metricId = metric.getMetricID();
		int acceptanceValue = 0;
		
		if(metric.getMetricManual()) {
			success = resultMap.get(metric.getMetricID());
		} else {
			acceptanceValue = metric.getUnitID()==2? metric.getPercentageAcceptanceValue(): metric.getIntegerAcceptanceValue();
			success = App.ejecuteMetric(metricId, selectedMeasurableObject.getMeasurableObjectURL(), selectedMeasurableObject.getMeasurableObjectServicesType(), acceptanceValue, selectedMeasurableObject.getMeasurableObjectName());
		}
		
		System.out.println("MetricId: " + metricId + " Success: " + success + " ServiceType: " + selectedMeasurableObject.getMeasurableObjectServicesType() + " MO:" + selectedMeasurableObject.getMeasurableObjectURL() + " Name:" + selectedMeasurableObject.getMeasurableObjectName());
		return success;
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
	
	 public void calculateWeight() {
	    	
    	double weightTree, weightTreeD, weightTreeF, weightTreeM, weightTreeR;
    	
        Map<Integer, Double> hashMetricWeight = new HashMap<Integer, Double>();
        
        listQualityWeight = qwDao.list(selectedProfile.getProfileId());
        
        if (listQualityWeight != null){        	
			for (QualityWeightTreeStructure qw : listQualityWeight) {
				if (qw.getElementType().equals("Q")){
					
					for (QualityWeightTreeStructure d : listQualityWeight) {
						if (d.getElementType().equals("D") && qw.getElementID() == d.getFatherElementyID()){
							
							if (d.getDenominatorValue() != null  && d.getDenominatorValue() != 0){
								weightTreeD = (double)d.getNumeratorValue()/(double)d.getDenominatorValue();
							} else{
								weightTreeD = d.getNumeratorValue();
							}
							
							for (QualityWeightTreeStructure f : listQualityWeight) {
								if (f.getElementType().equals("F") && d.getElementID() == f.getFatherElementyID()){
									
									if (f.getDenominatorValue() != null  && f.getDenominatorValue() != 0){
										weightTreeF = (double)f.getNumeratorValue()/(double)f.getDenominatorValue();
									} else{
										weightTreeF = f.getNumeratorValue();
									}									
									
									for (QualityWeightTreeStructure m : listQualityWeight) {
										if (m.getElementType().equals("M") && f.getElementID() == m.getFatherElementyID()){
											
											if (m.getDenominatorValue() != null  && m.getDenominatorValue() != 0){
												weightTreeM = (double)m.getNumeratorValue()/(double)m.getDenominatorValue();
											} else{
												weightTreeM = m.getNumeratorValue();
											}
											
											for (QualityWeightTreeStructure mr : listQualityWeight) {
												if (mr.getElementType().equals("R") && m.getElementID() == mr.getFatherElementyID()){
													
													if (mr.getDenominatorValue() != null && mr.getDenominatorValue() != 0){
														weightTreeR = (double)mr.getNumeratorValue()/(double)mr.getDenominatorValue();
													} else{
														weightTreeR = mr.getNumeratorValue();
													}
													
													weightTree = weightTreeR * weightTreeM * weightTreeF * weightTreeD;
													hashMetricWeight.put(m.getElementID(), weightTree);
													
													System.out.println("hashMetricWeight::: " + hashMetricWeight.toString());
												}
											}
										}
									}
								}
							}
						}
					}						
				}
			}
        }
    }
}
