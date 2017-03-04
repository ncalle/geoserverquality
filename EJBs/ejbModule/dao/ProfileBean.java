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

@Stateless
@LocalBean
public class ProfileBean implements ProfileBeanRemote {

    private static final String SQL_LIST_ORDER_BY_ID =
    		"SELECT ProfileID, ProfileName, ProfileGranurality, ProfileIsWeightedFlag FROM profile_get ()";
	private static final String SQL_INSERT =
            "SELECT * FROM profile_insert (?, ?, ?)";
	private static final String SQL_DELETE =
        	"SELECT * FROM profile_delete (?)";

    private DAOFactory daoFactory;
	
    public ProfileBean() {
    	daoFactory = DAOFactory.getInstance("geoservicequality.jdbc");
    }

    ProfileBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }

	@Override
	public List<Profile> list() throws DAOException {

		 List<Profile> list = new ArrayList<>();

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
	

	@Override
	public void create(Profile profile) throws IllegalArgumentException, DAOException {
		Connection connection = null;
		PreparedStatement statement = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_INSERT);

            statement.setString(1, profile.getName());
			statement.setString(2, profile.getGranurality());
			statement.setString(3, profile.getMetricIds()); 
			
            statement.executeQuery();

        } catch (SQLException e) {
            throw new DAOException(e);
        }        
		
	}

	@Override
	public void delete(Profile profile) throws DAOException {
    	Connection connection = null;
		PreparedStatement statement = null;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_DELETE);

            statement.setInt(1, profile.getProfileId());
        
            statement.executeQuery();

            profile.setProfileId(null);
            
        } catch (SQLException e) {
            throw new DAOException(e);
        }		
	}
	
	private static Profile map(ResultSet resultSet) throws SQLException {
	    Profile profile = new Profile();
	   	profile.setProfileId(resultSet.getInt("ProfileID"));
	   	profile.setName(resultSet.getString("ProfileName"));
	   	profile.setGranurality(resultSet.getString("ProfileGranurality"));
	   	profile.setIsWeightedFlag(resultSet.getBoolean("ProfileIsWeightedFlag"));
	
	   	return profile; 
	}
	
}
