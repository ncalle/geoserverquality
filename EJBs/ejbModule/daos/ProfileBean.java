package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import Model.Profile;

@Stateless
@LocalBean
public class ProfileBean implements ProfileBeanRemote {

    private static final String SQL_LIST_ORDER_BY_ID =
    		"SELECT ProfileID, ProfileName, ProfileGranurality, ProfileIsWeightedFlag FROM profile_get ()";
	private static final String SQL_INSERT =
            "SELECT * FROM profile_insert (?, ?, ?)";

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
	
	 private static Profile map(ResultSet resultSet) throws SQLException {
	    Profile profile = new Profile();
    	profile.setProfileId(resultSet.getInt("ProfileID"));
    	profile.setName(resultSet.getString("ProfileName"));
    	profile.setGranurality(resultSet.getString("ProfileGranurality"));
    	profile.setIsWeightedFlag(resultSet.getBoolean("ProfileIsWeightedFlag"));

        return profile; 
    }

	@Override
	public void create(Profile profile) throws IllegalArgumentException, DAOException {
		Connection connection = null;
		PreparedStatement statement = null;
		int affectedRows;
        
        try {
            connection = daoFactory.getConnection();
            statement = connection.prepareStatement(SQL_INSERT);

            statement.setString(1, profile.getName());
			statement.setString(2, profile.getGranurality());
			statement.setString(3, null); 
			
			//TODO: agregar lista de metricas

            affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new DAOException("No fue posible crear el perfil. Error.");
            }
        } catch (SQLException e) {
            throw new DAOException(e);
        }        
		
	}

	@Override
	public void delete(Profile profile) throws DAOException {
		// TODO Auto-generated method stub
		
	}
	
}
