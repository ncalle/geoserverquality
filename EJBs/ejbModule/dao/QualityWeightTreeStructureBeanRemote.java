package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.QualityWeightTreeStructure;

@Remote
public interface QualityWeightTreeStructureBeanRemote {

    public List<QualityWeightTreeStructure> list(Integer profileID) throws DAOException;

}