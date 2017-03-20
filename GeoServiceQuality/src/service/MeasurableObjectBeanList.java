package service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;

import org.primefaces.event.NodeSelectEvent;
import org.primefaces.event.RowEditEvent;
import org.primefaces.event.SelectEvent;
import org.primefaces.model.DefaultTreeNode;
import org.primefaces.model.TreeNode;

import entity.IdeTreeStructure;
import entity.MeasurableObject;
import dao.DAOException;
import dao.IdeTreeStructureBean;
import dao.IdeTreeStructureBeanRemote;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;


@ManagedBean(name="measurableObjectBeanList")
@RequestScoped
public class MeasurableObjectBeanList {
	
	private List<IdeTreeStructure> listIdeStructure;
	private List<MeasurableObject> listObjects;
	private MeasurableObject selectedMeasurableObject;
    
	private TreeNode root;
	private TreeNode selectedNode;
	
	@EJB
    private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	private IdeTreeStructureBeanRemote ideTreeDao = new IdeTreeStructureBean();
	
	@PostConstruct
	private void init()	{
		try {
			Integer userID = null;
			listIdeStructure = ideTreeDao.list(userID); //TODO: pasar el UserID cuando se quiera soportar lista de objetos medible del usuario.

            createTree();
            
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<MeasurableObject> getListObjects() {
		return listObjects;
	}
	
	public void setListObjects(List<MeasurableObject> listObjects) {
		this.listObjects = listObjects;
	}

	public MeasurableObject getSelectedMeasurableObject() {
		return selectedMeasurableObject;
	}

	public void setSelectedMeasurableObject(MeasurableObject selectedMeasurableObject) {
		this.selectedMeasurableObject = selectedMeasurableObject;
	}
	
    public void onRowSelect(SelectEvent event) {
    	//agregar codigo de ser necesario
    }
       	
	public void onRowEdit(RowEditEvent event) {    	
		MeasurableObject mo = ((MeasurableObject) event.getObject());

		System.out.println("mo : " + mo);
		
		moDao.update(mo);
		FacesMessage msg = new FacesMessage("Objeto Medible editado correctamente.");
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }	
	
	public void deleteMeasurableObject() {
		moDao.delete(selectedMeasurableObject);    	
    	listObjects = moDao.list();
        selectedMeasurableObject = null;
        
		FacesMessage msg = new FacesMessage("El Objecto Medible fue eliminado correctamente.");       
        FacesContext.getCurrentInstance().addMessage(null, msg);
    }
	

	public void createTree(){
        root = new DefaultTreeNode("Ides", null);
        List <Integer> listIde = new ArrayList<>();
        List <Integer> listInstitution = new ArrayList<>();
        List <Integer> listNode = new ArrayList<>();
        
        if (listIdeStructure != null){
        	System.out.println("TREE: " + listIdeStructure);
        				
			for (IdeTreeStructure ides : listIdeStructure) {
				if ((!listIde.contains(ides.getIdeID()))){
					listIde.add(ides.getIdeID());
					TreeNode ide = new DefaultTreeNode(ides.getIdeName(), root);
					
					for (IdeTreeStructure institutions : listIdeStructure) {
						if ((!listInstitution.contains(institutions.getInstitutionID()))
								&& ides.getIdeID() == institutions.getIdeID()) {
							listInstitution.add(institutions.getInstitutionID());
							TreeNode institution = new DefaultTreeNode(institutions.getInstitutionName(), ide);
							
							for (IdeTreeStructure nodes : listIdeStructure) {
								if ((!listNode.contains(nodes.getNodeID()))
										&& institutions.getInstitutionID() == nodes.getInstitutionID()) {
									listNode.add(nodes.getNodeID());
									TreeNode node = new DefaultTreeNode(nodes.getNodeName(), institution);
								}
							}
						}
					}						
				}
			}
        }
	}
	
    public TreeNode getSelectedNode() {
        return selectedNode;
    }
 
    public void setSelectedNode(TreeNode selectedNode) {
        this.selectedNode = selectedNode;
    }
	
    public TreeNode getRoot() {
        return root;
    }
    
    public void displaySelectedSingle() {
        if(selectedNode != null) {
            FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO, "Selected", selectedNode.getData().toString());
            FacesContext.getCurrentInstance().addMessage(null, message);
        }
    }
    
    public void onNodeSelect(NodeSelectEvent event) {    	
    	listObjects = moDao.servicesAndLayerGet(null, selectedNode.getData().toString(), "Nodo");
    }

	public List<IdeTreeStructure> getListIdeStructure() {
		return listIdeStructure;
	}

	public void setListIdeStructure(List<IdeTreeStructure> listIdeStructure) {
		this.listIdeStructure = listIdeStructure;
	}
}
