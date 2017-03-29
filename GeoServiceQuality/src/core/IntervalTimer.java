package core;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.AccessTimeout;
import javax.ejb.EJB;
import javax.ejb.Schedule;
import javax.ejb.Startup;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.ejb.TimerConfig;

import dao.EvaluationBean;
import dao.EvaluationBeanRemote;
import dao.MeasurableObjectBean;
import dao.MeasurableObjectBeanRemote;
import dao.ReportBean;
import dao.ReportBeanRemote;
import entity.Evaluation;
import entity.MeasurableObject;


@Singleton
@Startup
public class IntervalTimer {
	
	static String URL1 = "http://geoservicios.mtop.gub.uy/geoserver/mb_pap/wms?service=WMS&version=1.3.0&request=GetCapabilities";
	static String URL2 = "http://geoservicios.sgm.gub.uy/DPYO_UYMA.cgi?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities";
	static int TIMEOUT_SERVICE = 18000;
	
	 @EJB
	 private EvaluationBeanRemote evaluationDao = new EvaluationBean();
	 private MeasurableObjectBeanRemote moDao = new MeasurableObjectBean();
	 
	private List<MeasurableObject> listMeasurableObjects;

    @PostConstruct
    public void applicationStartup() {
    	
    	//Timer automatico programado
    	scheduleTimer();
    	
    }
    
    @Schedule(minute="*/15", hour="*", persistent = true)
    public void scheduleTimer() {
    	TimerConfig timerConfig = new TimerConfig();
        timerConfig.setInfo("Timer");
        
        System.out.println("scheduleTimer : " + System.currentTimeMillis());
        
        //boolean ok = checkService(URL1, TIMEOUT_SERVICE);
        //System.out.println("checkService.. " + ok + URL1);
        
      /*  listMeasurableObjects = moDao.list();
        List<Evaluation> list =  evaluationDao.list();
        String url;
        
        for(Evaluation e:list){
        	if (e.getMetricID() == 0 && !e.getIsEvaluationCompleted()){
        		int idMO = e.getMeasurableObjectID();
        		 for(MeasurableObject m:listMeasurableObjects){
        			 if(m.getMeasurableObjectID()==idMO){
        				 url = m.getMeasurableObjectURL();
        			 }
        		 }
        				
        	}
        }*/
    }
    
    @Timeout
    @AccessTimeout(value = 20, unit = TimeUnit.MINUTES)
    public void process(Timer timer) {
    	System.out.println("process timer..");
    }
    
}
