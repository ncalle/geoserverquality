package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.Profile;
import entity.ProfileMetric;

@Remote
public interface ProfileMetricBeanRemote {

    public List<ProfileMetric> profileMetricList(Profile profile) throws DAOException;
    
}