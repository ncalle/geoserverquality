package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import entity.MeasurableObject;

/**
 * Session Bean implementation class MeasurableObjectBean
 */
@Stateless
@LocalBean
public class MeasurableObjectBean implements MeasurableObjectBeanRemote {

    private static final String SQL_LIST_ORDER_BY_ID =
    		"SELECT MeasurableObjectID, MeasurableObjectTypeID, MeasurableObjectType, MeasurableObjectName, MeasurableObjectDescription, MeasurableObjectURL, MeasurableObjectServicesType FROM prototype_measurable_objects_get (?)";
	private static final String SQL_INSERT =
            "SELECT * FROM prototype_measurable_objects_insert (?, ?, ?, ?, ?)";
    private static final String SQL_DELETE =
        	"SELECT * FROM prototype_measurable_objects_delete(?, ?)";
    private static final String SQL_USER_MEASURABLE_OBJECT_TO_ADD_GET =
    		"SELECT MeasurableObjectID, MeasurableObjectTypeID, MeasurableObjectType, MeasurableObjectName, MeasurableObjectDescription, MeasurableObjectURL, MeasurableObjectServicesType FROM prototype_user_measurable_object_to_add_get (?)";
	private static final String SQL_UPDATE =
        	"SELECT * FROM prototype_measurable_object_update (?, ?, ?, ?, ?)";    

    private DAOFactory daoFactory;
	
    public MeasurableObjectBean() {
    	daoFactory = DAOFactory.getInstance("geoservicequality.jdbc");
    }

    MeasurableObjectBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }
    
    @Override
    public List<MeasurableObject> list() throws DAOException {
        List<MeasurableObject> measurableobject = new ArrayList<>();

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_LIST_ORDER_BY_ID);
            
			statement.setObject(1, null); //userID
			
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	measurableobject.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return measurableobject;
    }
    
    @Override
    public List<MeasurableObject> list(Integer userID) throws DAOException {
        List<MeasurableObject> measurableobject = new ArrayList<>();

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_LIST_ORDER_BY_ID);
            
			statement.setObject(1, userID);
			
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	measurableobject.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return measurableobject;
    }    

    @Override
    public void create(MeasurableObject measurableobject, Integer nodeID) throws IllegalArgumentException, DAOException {
        if (measurableobject.getMeasurableObjectID() != null) {
            throw new IllegalArgumentException("El objeto medible ya existe. Error.");
        }

        Connection connection = null;
		PreparedStatement statement = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_INSERT);

            statement.setInt(1, nodeID); //TODO: parametrizar cuando se amplíe el prototipo
            statement.setString(2, measurableobject.getMeasurableObjectURL());
            statement.setString(3, measurableobject.getMeasurableObjectServicesType());
            statement.setString(4, measurableobject.getMeasurableObjectDescription());
            statement.setString(5, "Servicio"); //TODO: parametrizar cuando se amplíe el prototipo
		
            statement.executeQuery();            
            
        } catch (SQLException e) {
            throw new DAOException(e);
        }        
    }

    @Override
    public void delete(MeasurableObject measurableobject) throws DAOException {

    	Connection connection = null;
		PreparedStatement statement = null;
		
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_DELETE);

            statement.setInt(1, measurableobject.getMeasurableObjectID());
            statement.setString(2, measurableobject.getMeasurableObjectType());
                   
            statement.executeQuery();
            
            measurableobject.setMeasurableObjectID(null);
            
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }
    
    @Override
    public List<MeasurableObject> userMeasurableObjectsToAddGet(Integer userID) throws DAOException {
        System.out.println("userID en MOBEAN" + userID);
    	List<MeasurableObject> measurableobject = new ArrayList<>();

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_USER_MEASURABLE_OBJECT_TO_ADD_GET);
            
			statement.setObject(1, userID);
			
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	measurableobject.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return measurableobject;
    }
    
    @Override
    public void update(MeasurableObject measurableObject) throws DAOException{

    	Connection connection = null;
		PreparedStatement statement = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_UPDATE);

            statement.setInt(1, measurableObject.getMeasurableObjectID());
            statement.setString(2, measurableObject.getMeasurableObjectType());
            statement.setString(3, measurableObject.getMeasurableObjectURL());
            statement.setString(4, measurableObject.getMeasurableObjectServicesType());
            statement.setString(5, measurableObject.getMeasurableObjectDescription());
        
            statement.executeQuery();
            
        } catch (SQLException e) {
            throw new DAOException(e);
        }
    }

    private static MeasurableObject map(ResultSet resultSet) throws SQLException {
    	MeasurableObject measurableobject = new MeasurableObject();
    	measurableobject.setMeasurableObjectID(resultSet.getInt("MeasurableObjectID"));
    	measurableobject.setMeasurableObjectTypeID(resultSet.getInt("MeasurableObjectTypeID"));
    	measurableobject.setMeasurableObjectType(resultSet.getString("MeasurableObjectType"));
    	measurableobject.setMeasurableObjectName(resultSet.getString("MeasurableObjectName"));
    	measurableobject.setMeasurableObjectDescription(resultSet.getString("MeasurableObjectDescription"));
    	measurableobject.setMeasurableObjectURL(resultSet.getString("MeasurableObjectURL"));
    	measurableobject.setMeasurableObjectServicesType(resultSet.getString("MeasurableObjectServicesType"));

        return measurableobject; 
    }
    
}