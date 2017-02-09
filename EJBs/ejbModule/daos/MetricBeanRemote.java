package daos;

import java.util.List;
import javax.ejb.Remote;

import Model.Metric;

@Remote
public interface MetricBeanRemote {

    public List<Metric> list() throws DAOException;

}
