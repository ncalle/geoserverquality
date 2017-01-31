package negocio;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ViewScoped;
import javax.inject.Named;

import Model.TestObject;
import daos.EvaluationObjectDAO;
import daos.EvaluationObjectDAOImpl;
import daos.MeasurableObjectDAO;
import daos.MeasurableObjectDAOJDBC;

//@ManagedBean(name="evObject")
@Named("evObject")
@ViewScoped
public class EvaluationObjectBean {
	
	private List<TestObject> listObjects;
	
	@EJB
    private EvaluationObjectDAO eoDao = new EvaluationObjectDAOImpl();
	
	//@EJB
    //private MeasurableObjectDAO eoDao = new MeasurableObjectDAOJDBC(null);
	
	@PostConstruct
	private void init()
	{
		try {
			listObjects = eoDao.listAllEvaluationObjects();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	

}
