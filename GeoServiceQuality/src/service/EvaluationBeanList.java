package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import entity.Evaluation;
import dao.DAOException;
import dao.EvaluationBean;
import dao.EvaluationBeanRemote;


@ManagedBean(name="evaluationBeanList")
@RequestScoped
public class EvaluationBeanList {
	
    
	private List<Evaluation> list;
	
	@EJB
    private EvaluationBeanRemote evaluationDao = new EvaluationBean();
	
	
	@PostConstruct
	private void init()	{
		try {
			
            list = evaluationDao.list();
	            
    	} catch(DAOException e) {
    		e.printStackTrace();
    	} 
	}
	
	public List<Evaluation> getList() {
		return list;
	}
	
	public void setList(List<Evaluation> list) {
		this.list = list;
	}

}
