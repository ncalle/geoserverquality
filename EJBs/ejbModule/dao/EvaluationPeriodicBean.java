package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import entity.EvaluationPeriodic;

@Stateless
@LocalBean
public class EvaluationPeriodicBean implements EvaluationPeriodicBeanRemote {

    private static final String SQL_LIST_ORDER_BY_ID =
    		"SELECT EvaluationSummaryID, MeasurableObjectURL, EvaluatedCount, Periodic, SuccessCount, SuccessPercentage FROM evaluation_periodic_get (?)";
    private static final String SQL_INSERT =
            "SELECT EvaluationSummaryID, MeasurableObjectURL, EvaluatedCount, Periodic, SuccessCount, SuccessPercentage FROM evaluation_periodic_insert (?, ?, ?, ?, ?, ?)";
    private static final String SQL_UPDATE =
        	"SELECT * FROM evaluation_periodic_update (?, ?, ?, ?, ?, ?)";

    private DAOFactory daoFactory;
	
    public EvaluationPeriodicBean() {
    	daoFactory = DAOFactory.getInstance("geoservicequality.jdbc");
    }

    EvaluationPeriodicBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

	@Override
	public List<EvaluationPeriodic> list() throws DAOException {

		List<EvaluationPeriodic> list = new ArrayList<>();

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_LIST_ORDER_BY_ID);
            
            statement.setObject(1, null); //userID
            
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	list.add(map(resultSet));
            }
            
            connection.close();
            
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return list;
	}
	
	private static EvaluationPeriodic map(ResultSet resultSet) throws SQLException {
		EvaluationPeriodic object = new EvaluationPeriodic();
		object.setEvaluationSummaryID(resultSet.getInt("EvaluationSummaryID"));
	    object.setMeasurableObjectUrl(resultSet.getString("MeasurableObjectUrl"));
	    object.setEvaluatedCount(resultSet.getInt("EvaluatedCount"));
		object.setPeriodic(resultSet.getInt("Periodic"));
		object.setSuccessCount(resultSet.getInt("SuccessCount"));
		object.setSuccessPercentage(resultSet.getInt("SuccessPercentage"));

       return object;
   }

	@Override
	public EvaluationPeriodic create(EvaluationPeriodic evaluationPeriodic)
			throws IllegalArgumentException, DAOException {
		Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		
		EvaluationPeriodic ev = null;
        
        try {
        	
        	connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_INSERT);

            statement.setInt(1, evaluationPeriodic.getEvaluationSummaryID());
			statement.setString(2, evaluationPeriodic.getMeasurableObjectUrl());
			statement.setInt(3, evaluationPeriodic.getEvaluatedCount());
			statement.setInt(4, evaluationPeriodic.getPeriodic());
			statement.setInt(5, evaluationPeriodic.getSuccessCount());
			statement.setInt(6, evaluationPeriodic.getSuccessPercentage());
			
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	ev = map(resultSet);
            }
            
            connection.close();
		
        } catch (SQLException e) {
        	throw new DAOException(e);
        }
        
        return ev;
	}

	@Override
	public void update(EvaluationPeriodic evaluationPeriodic) throws DAOException {
		Connection connection = null;
		PreparedStatement statement = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_UPDATE);

            statement.setInt(1, evaluationPeriodic.getEvaluationSummaryID());
			statement.setString(2, evaluationPeriodic.getMeasurableObjectUrl());
			statement.setInt(3, evaluationPeriodic.getEvaluatedCount());
			statement.setInt(4, evaluationPeriodic.getPeriodic());
			statement.setInt(5, evaluationPeriodic.getSuccessCount());
			statement.setInt(6, evaluationPeriodic.getSuccessPercentage());
        
            statement.executeQuery();
            
            connection.close();
            
        } catch (SQLException e) {
            throw new DAOException(e);
        }
		
	}

}
