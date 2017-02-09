package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.Metric;

@Remote
public interface MetricBeanRemote {

    public List<Metric> list() throws DAOException;

}
