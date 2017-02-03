package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

import Model.User;

/**
 * Session Bean implementation class UserBean
 */
@Stateless
@LocalBean
public class UserBean implements UserBeanRemote {

    private static final String SQL_FIND_BY_EMAIL_AND_PASSWORD =
        	"SELECT UserID, InstitutionID, InstitutionName, Email, UserGroupID, UserGroupName, FirstName, LastName, PhoneNumber FROM user_get (?, ?, ?)";
    
    private DAOFactory daoFactory;

    UserBean(DAOFactory daoFactory) {
        this.daoFactory = daoFactory;
    }
    
    public UserBean() {
    }
    
    //@Override
    public User find(String email, String password) throws DAOException {       
    	User user = null;

        Connection connection = null;
		PreparedStatement statement = null;
		ResultSet resultSet = null;
		
		try {			
			connection = daoFactory.getConnection();			
			statement = connection.prepareStatement(SQL_FIND_BY_EMAIL_AND_PASSWORD);
			
			statement.setObject(1, null); //userID
			statement.setString(2, email);
			statement.setString(3, password);
			
			resultSet = statement.executeQuery();
			
			if (resultSet.next()) {
                user = map(resultSet);
            }                
		} catch (SQLException e) {
			throw new DAOException(e);
		}
		
    	return user;        
    }
    
    private static User map(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setUserId(resultSet.getInt("UserID"));
        user.setInstitutionID(resultSet.getInt("InstitutionID"));
        user.setInstitutionName(resultSet.getString("InstitutionName"));
        user.setEmail(resultSet.getString("Email"));
        user.setUserGroupID(resultSet.getInt("UserGroupID"));
        user.setUserGroupName(resultSet.getString("UserGroupName"));
        user.setFirstName(resultSet.getString("FirstName"));
        user.setLastName(resultSet.getString("LastName"));
        user.setPhoneNumber(resultSet.getString("PhoneNumber"));

        return user;
    }    

}
