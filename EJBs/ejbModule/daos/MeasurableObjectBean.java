package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import Model.MeasurableObject;

/**
 * Session Bean implementation class MeasurableObjectBean
 */
@Stateless
@LocalBean
public class MeasurableObjectBean implements MeasurableObjectBeanRemote {

    private static final String SQL_LIST_ORDER_BY_ID =
    		"SELECT MeasurableObjectID, MeasurableObjectTypeID, MeasurableObjectType, MeasurableObjectName, MeasurableObjectDescription, MeasurableObjectURL, MeasurableObjectServicesType FROM prototype_measurable_objects_get (?)";
	private static final String SQL_INSERT =
            "SELECT * FROM prototype_measurable_objects_insert (?, ?, ?, ?)";
    private static final String SQL_DELETE =
        	"SELECT * prototype_measurable_objects_delete(?, ?, ?)";

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
    public void create(MeasurableObject measurableobject, Integer userID, Integer nodeID) throws IllegalArgumentException, DAOException {
        if (measurableobject.getMeasurableObjectID() != null) {
            throw new IllegalArgumentException("El objeto medible ya existe. Error.");
        }

        Connection connection = null;
		PreparedStatement statement = null;
		int affectedRows;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_INSERT);

            statement.setInt(1, userID);
            statement.setInt(2, nodeID);
            statement.setString(3, measurableobject.getMeasurableObjectURL());
            statement.setString(4, measurableobject.getMeasurableObjectServicesType());
		
            affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new DAOException("No fue posible crear el objeto. Error.");
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }        
    }

    @Override
    public void delete(MeasurableObject measurableobject, Integer userID) throws DAOException {

    	Connection connection = null;
		PreparedStatement statement = null;
		int affectedRows;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_DELETE);

            statement.setInt(1, userID);
            statement.setInt(2, measurableobject.getMeasurableObjectID());
            statement.setInt(3, measurableobject.getMeasurableObjectTypeID());
                   
            affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new DAOException("No se ha podido remover el objeto. Error.");
            } else {
            	measurableobject.setMeasurableObjectID(null);
            }
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