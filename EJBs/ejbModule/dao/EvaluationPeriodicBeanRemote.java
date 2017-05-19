package dao;

import java.util.List;
import javax.ejb.Remote;

import entity.EvaluationPeriodic;

@Remote
public interface EvaluationPeriodicBeanRemote {

    public List<EvaluationPeriodic> list() throws DAOException;
    
    public EvaluationPeriodic create(EvaluationPeriodic evaluationPeriodic) throws IllegalArgumentException, DAOException;

}
