package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import entity.Evaluation;

@Stateless
@LocalBean
public class EvaluationBean implements EvaluationBeanRemote {

    private static final String SQL_LIST_ORDER_BY_ID =
    		"SELECT EvaluationID, UserID, ProfileID, StartDate, EndDate, IsEvaluationCompletedFlag, SuccessFlag FROM evaluation_get ()";


    private DAOFactory daoFactory;
	
    public EvaluationBean() {
    	daoFactory = DAOFactory.getInstance("geoservicequality.jdbc");
    }

    EvaluationBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

	@Override
	public List<Evaluation> list() throws DAOException {

		List<Evaluation> list = new ArrayList<>();

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_LIST_ORDER_BY_ID);
            
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	list.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return list;
	}
	
	 private static Evaluation map(ResultSet resultSet) throws SQLException {
		Evaluation object = new Evaluation();
		object.setEvaluationID(resultSet.getInt("EvaluationID"));
		object.setUserID(resultSet.getInt("UserID"));
		object.setProfileID(resultSet.getInt("ProfileID"));

        return object; 
    }

	@Override
	public void create(Evaluation evaluation) throws IllegalArgumentException, DAOException {
		// TODO: operaciones de crear objeto
		
	}

}
