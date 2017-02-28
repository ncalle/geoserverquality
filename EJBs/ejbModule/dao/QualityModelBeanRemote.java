package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.QualityModel;

@Remote
public interface QualityModelBeanRemote {

    public List<QualityModel> list() throws DAOException;

}