package daos;

import javax.ejb.Remote;

import Model.User;

@Remote
public interface UserBeanRemote {

	public User find(String email, String password) throws DAOException;
	
}