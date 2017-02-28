package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import entity.QualityModel;

/**
 * Session Bean implementation class UserBean
 */
@Stateless
@LocalBean
public class QualityModelBean implements QualityModelBeanRemote {

    private static final String SQL_QUALITY_MODEL_LIST_ORDER_BY_ID =
    		"SELECT QualityModelID, QualityModelName, DimensionID, DimensionName, FactorID, FactorName, MetricID, MetricName, MetricAgrgegationFlag, MetricGranurality, MetricDescription, UnitID, UnitName, UnitDescription FROM quality_models_get()";
    
    private DAOFactory daoFactory;

    QualityModelBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }
    
    public QualityModelBean() {
		// Obtener DAOFactory
    	daoFactory = DAOFactory.getInstance("geoservicequality.jdbc");
    }    
    
    @Override
    public List<QualityModel> list() throws DAOException {
        List<QualityModel> qualityModels = new ArrayList<>();

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_QUALITY_MODEL_LIST_ORDER_BY_ID);
            
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
            	qualityModels.add(map(resultSet));
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }

        return qualityModels;
    }
        
    private static QualityModel map(ResultSet resultSet) throws SQLException {
    	QualityModel qualityModel = new QualityModel();
    	qualityModel.setQualityModelID(resultSet.getInt("QualityModelID"));
    	qualityModel.setQualityModelName(resultSet.getString("QualityModelName"));
    	qualityModel.setDimensionID(resultSet.getInt("DimensionID"));
    	qualityModel.setDimensionName(resultSet.getString("DimensionName"));    	
    	qualityModel.setFactorID(resultSet.getInt("FactorID"));
    	qualityModel.setFactorName(resultSet.getString("FactorName"));    	
    	qualityModel.setMetricID(resultSet.getInt("MetricID"));
    	qualityModel.setMetricName(resultSet.getString("MetricName"));
    	qualityModel.setMetricAgrgegationFlag(resultSet.getBoolean("MetricAgrgegationFlag"));
    	qualityModel.setMetricGranurality(resultSet.getString("MetricGranurality"));
    	qualityModel.setMetricDescription(resultSet.getString("MetricDescription"));
    	qualityModel.setUnitID(resultSet.getInt("UnitID"));
    	qualityModel.setUnitName(resultSet.getString("UnitName"));
    	qualityModel.setUnitDescription(resultSet.getString("UnitDescription"));    	
    	
        return qualityModel;
    }

}
