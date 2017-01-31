package daos;

import java.util.List;

import javax.ejb.Local;

import Model.MeasurableObject;



/**
 * Contrato para el DAO de MeasurableObject 
 */
@Local
public interface MeasurableObjectDAO {

    public List<MeasurableObject> list() throws DAOException;

    public void create(MeasurableObject measurableobject, Integer userID, Integer nodeID) throws IllegalArgumentException, DAOException;

    public void delete(MeasurableObject measurableobject, Integer userID) throws DAOException;

}