package dao;

import java.util.List;

import model.MeasurableObject;

/**
 * Contrato para el DAO de MeasurableObject 
 */
public interface MeasurableObjectDAO {

    public List<MeasurableObject> list() throws DAOException;

    public void create(MeasurableObject measurableobject, Integer userID, Integer nodeID) throws IllegalArgumentException, DAOException;

    public void delete(MeasurableObject measurableobject, Integer userID) throws DAOException;

}