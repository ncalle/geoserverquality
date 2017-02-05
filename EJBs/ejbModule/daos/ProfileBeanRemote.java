package daos;

import java.util.List;
import javax.ejb.Remote;
import Model.Profile;

@Remote
public interface ProfileBeanRemote {

    public List<Profile> list() throws DAOException;

    public void create(Profile profile) throws IllegalArgumentException, DAOException;

    public void delete(Profile profile) throws DAOException;
	
}