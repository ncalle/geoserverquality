package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.QualityModelTreeStructure;

@Remote
public interface QualityModelTreeStructureBeanRemote {

    public List<QualityModelTreeStructure> list() throws DAOException;

}