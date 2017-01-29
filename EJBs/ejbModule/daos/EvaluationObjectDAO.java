package daos;

import java.util.List;

import javax.ejb.Local;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;

/**
 * Session Bean implementation class EvaluationObjectDAO
 */
@Local
public interface EvaluationObjectDAO {

	public void createEvaluationObject() throws Exception;
	
	public List<TestObject> listAllEvaluationObjects() throws Exception;

}
