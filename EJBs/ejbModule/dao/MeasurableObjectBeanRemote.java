package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.MeasurableObject;

@Remote
public interface MeasurableObjectBeanRemote {

    public List<MeasurableObject> list() throws DAOException;

    public void create(MeasurableObject measurableobject, Integer userID, Integer nodeID) throws IllegalArgumentException, DAOException;

    public void delete(MeasurableObject measurableobject, Integer userID) throws DAOException;
	
}
