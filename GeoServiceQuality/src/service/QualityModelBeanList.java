package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import entity.QualityModel;
import dao.DAOException;
import dao.QualityModelBean;
import dao.QualityModelBeanRemote;


@ManagedBean(name="qualityModelBeanList")
@ViewScoped
public class QualityModelBeanList {
	
	private List<QualityModel> listQualityModels;	
	
	@EJB
	private QualityModelBeanRemote qmDao = new QualityModelBean();
		
	@PostConstruct
	private void init()	{
		try {
            listQualityModels = qmDao.list();
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<QualityModel> getListQualityModels() {
		return listQualityModels;
	}
	
	public void setListQualityModels(List<QualityModel> listQualityModels) {
		this.listQualityModels = listQualityModels;
	}	
}
