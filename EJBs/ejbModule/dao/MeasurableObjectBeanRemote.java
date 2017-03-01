package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.MeasurableObject;
import entity.User;

@Remote
public interface MeasurableObjectBeanRemote {

    public List<MeasurableObject> list() throws DAOException;
    
    public List<MeasurableObject> list(Integer userID) throws DAOException;

    public void create(MeasurableObject measurableobject, Integer nodeID) throws IllegalArgumentException, DAOException;

    public void delete(MeasurableObject measurableobject) throws DAOException;
    
    public List<MeasurableObject> userMeasurableObjectsToAddGet(Integer userID) throws DAOException;
    
    public void update(MeasurableObject measurableObject) throws DAOException;
    
}
