package negocio;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.ViewScoped;

import Model.TestObject;
import daos.EvaluationObjectDAO;
import daos.EvaluationObjectDAOImpl;


@ManagedBean(name="evaluationObjectBean")
@RequestScoped
public class EvaluationObjectBean {
	

    private String name;
    private String description;
    private String url;
    
	private List<TestObject> listObjects;
	
	@EJB
    private EvaluationObjectDAO eoDao = new EvaluationObjectDAOImpl();
	
	
	@PostConstruct
	private void init()
	{
		try {
			listObjects = eoDao.listAllEvaluationObjects();
			//System.out.println("getName"+ listObjects.get(0).getName());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

    public String getName() {
        return name;
    }

    public void setName(String name) {
    	System.out.println("setName: " + name);
        this.name = name;
    }
    
    public String getDescription() {
		return description;
	}
    
    public void setDescription(String description) {
    	System.out.println("setDescription: " + description);
		this.description = description;
	}
    
    public String getUrl() {
		return url;
	}
    
    public void setUrl(String url) {
    	System.out.println("setUrl: " + url);
		this.url = url;
	}
}
