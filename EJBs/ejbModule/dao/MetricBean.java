package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import entity.Metric;

@Stateless
@LocalBean
public class MetricBean implements MetricBeanRemote {

    private static final String SQL_LIST_ORDER_BY_ID =
    		"SELECT MetricID, MetricFactorID, MetricName, MetricAgrgegationFlag, MetricUnitID, MetricGranurality, MetricDescription FROM metric_get ()";


    private DAOFactory daoFactory;
	
    public MetricBean() {
    	daoFactory = DAOFactory.getInstance("geoservicequality.jdbc");
    }

    MetricBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

	@Override
	public List<Metric> list() throws DAOException {

		List<Metric> list = new ArrayList<>();

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
	
	 private static Metric map(ResultSet resultSet) throws SQLException {
		Metric metric = new Metric();
		metric.setMetricID(resultSet.getInt("MetricID"));
		metric.setName(resultSet.getString("MetricName"));
		metric.setGranurality(resultSet.getString("MetricGranurality"));
		metric.setFactorID(resultSet.getInt("MetricFactorID"));
		metric.setUnitID(resultSet.getInt("MetricUnitID"));
		metric.setAgrgegationFlag(resultSet.getBoolean("MetricAgrgegationFlag"));
		metric.setDescription(resultSet.getString("MetricDescription"));

        return metric; 
    }

}
