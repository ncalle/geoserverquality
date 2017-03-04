package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import entity.Profile;
import entity.ProfileMetric;

/**
 * Session Bean implementation class UserBean
 */
@Stateless
@LocalBean
public class ProfileMetricBean implements ProfileMetricBeanRemote {

    private static final String SQL_PROFILE_METRIC_LIST =
    		"SELECT QualityModelID, QualityModelName, DimensionID, DimensionName, FactorID, FactorName, MetricID, MetricName, MetricAgrgegationFlag, MetricGranurality, MetricDescription, UnitID, UnitName, UnitDescription, MetricRangeID, BooleanFlag, BooleanAcceptanceValue, PercentageFlag, PercentageAcceptanceValue, IntegerFlag, IntegerAcceptanceValue, EnumerateFlag, EnumerateAcceptanceValue FROM profile_metric_get (?)";
    
    private DAOFactory daoFactory;

    ProfileMetricBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }
    
    public ProfileMetricBean() {
		// Obtener DAOFactory
    	daoFactory = DAOFactory.getInstance("geoservicequality.jdbc");
    }    
        
    
    @Override
    public List<ProfileMetric> profileMetricList(Profile profile) throws DAOException{
        List<ProfileMetric> metricList = new ArrayList<>();

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_PROFILE_METRIC_LIST);
            
            statement.setInt(1, profile.getProfileId());
            
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	metricList.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return metricList;    
    	
    }
        
    private static ProfileMetric map(ResultSet resultSet) throws SQLException {
    	ProfileMetric profileMetric = new ProfileMetric();
    	profileMetric.setQualityModelID(resultSet.getInt("QualityModelID"));
    	profileMetric.setQualityModelName(resultSet.getString("QualityModelName"));
    	profileMetric.setDimensionID(resultSet.getInt("DimensionID"));
    	profileMetric.setDimensionName(resultSet.getString("DimensionName"));    	
    	profileMetric.setFactorID(resultSet.getInt("FactorID"));
    	profileMetric.setFactorName(resultSet.getString("FactorName"));    	
    	profileMetric.setMetricID(resultSet.getInt("MetricID"));
    	profileMetric.setMetricName(resultSet.getString("MetricName"));
    	profileMetric.setMetricAgrgegationFlag(resultSet.getBoolean("MetricAgrgegationFlag"));
    	profileMetric.setMetricGranurality(resultSet.getString("MetricGranurality"));
    	profileMetric.setMetricDescription(resultSet.getString("MetricDescription"));
    	profileMetric.setUnitID(resultSet.getInt("UnitID"));
    	profileMetric.setUnitName(resultSet.getString("UnitName"));
    	profileMetric.setUnitDescription(resultSet.getString("UnitDescription"));
    	
    	profileMetric.setMetricRangeID(resultSet.getInt("MetricRangeID"));
    	profileMetric.setBooleanFlag(resultSet.getBoolean("BooleanFlag"));
    	profileMetric.setBooleanAcceptanceValue(resultSet.getBoolean("BooleanAcceptanceValue"));
    	profileMetric.setPercentageFlag(resultSet.getBoolean("PercentageFlag"));
    	profileMetric.setPercentageAcceptanceValue(resultSet.getInt("PercentageAcceptanceValue"));
    	profileMetric.setIntegerFlag(resultSet.getBoolean("IntegerFlag"));
    	profileMetric.setIntegerAcceptanceValue(resultSet.getInt("IntegerAcceptanceValue"));
    	profileMetric.setEnumerateFlag(resultSet.getBoolean("EnumerateFlag"));
    	profileMetric.setEnumerateAcceptanceValue(resultSet.getString("EnumerateAcceptanceValue"));
    	
        return profileMetric;
    }

}