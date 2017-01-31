package daos;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import Model.TestObject;

/**
 * Session Bean implementation class EvaluationObjectDAOImpl
 */
@Stateless
@LocalBean
public class EvaluationObjectDAOImpl implements EvaluationObjectDAO{

    public EvaluationObjectDAOImpl() {
        // TODO Auto-generated constructor stub
    }

	@Override
	public void createEvaluationObject() throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<TestObject> listAllEvaluationObjects() throws Exception {
		List<TestObject> list = new ArrayList<>();
		list.add(new TestObject(0, "Google", "Buscador", "www.google.com"));
		return list;
		
	}

}
