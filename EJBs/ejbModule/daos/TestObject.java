package daos;

import java.io.Serializable;

public class TestObject implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int id;
    private String name;
    private String description;
    private String url;

    public TestObject(int id, String name, String description, String url) {
    	this.name = name;
    	this.description = description;
    	this.url = url;
    	this.id = id;
    }
    
    public String getDescription() {
		return description;
	}
    
    public String getName() {
		return name;
	}
    
    public String getUrl() {
		return url;
	}
    
    public int getId() {
		return id;
	}
    
    public void setName(String name) {
		this.name = name;
	}
    
    public void setUrl(String url) {
		this.url = url;
	}
    
    public void setDescription(String description) {
		this.description = description;
	}
    
    public void setId(int id) {
		this.id = id;
	}
}
