package service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import dao.DAOException;
import dao.EvaluationSummaryBean;
import dao.EvaluationSummaryBeanRemote;
import entity.EvaluationSummary;

@ManagedBean(name = "homeBean")
@ViewScoped
public class HomeBean {

	private List<EvaluationSummary> listEvaluationSummary;

	@EJB
	private EvaluationSummaryBeanRemote evaluationSummaryDao = new EvaluationSummaryBean();
	
	@PostConstruct
	private void init() {
		try {
			setListEvaluationSummary(evaluationSummaryDao.list());			
		} catch (DAOException e) {
			e.printStackTrace();
		}
	}

	public List<EvaluationSummary> getListEvaluationSummary() {
		return listEvaluationSummary;
	}

	public void setListEvaluationSummary(List<EvaluationSummary> listEvaluationSummary) {
		this.listEvaluationSummary = listEvaluationSummary;
	}
	
}
