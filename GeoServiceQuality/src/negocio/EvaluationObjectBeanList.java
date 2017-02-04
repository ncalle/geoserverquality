package negocio;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;

import Model.TestObject;
import daos.EvaluationObjectDAO;
import daos.EvaluationObjectDAOImpl;


@ManagedBean(name="evaluationObjectBeanList")
@RequestScoped
public class EvaluationObjectBeanList {
	

    
	private List<TestObject> listObjects;
	@EJB
    private EvaluationObjectDAO eoDao = new EvaluationObjectDAOImpl();
	
	
	@PostConstruct
	private void init()
	{
		try {
			//listObjects = eoDao.listAllEvaluationObjects();
			//System.out.println("getName"+ listObjects.get(0).getName());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
