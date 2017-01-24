package negocio;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;

import daos.EvaluationObjectDAO;
import daos.EvaluationObjectDAOImpl;

public class EvaluationObjectBean {
	
	@EJB
    private EvaluationObjectDAO eoDao = new EvaluationObjectDAOImpl();
	
	@PostConstruct
	private void init()
	{
		
	}

}
