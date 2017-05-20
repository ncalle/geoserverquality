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
import dao.EvaluationPeriodicBean;
import dao.EvaluationPeriodicBeanRemote;

import entity.EvaluationPeriodic;


@Singleton
@Startup
public class IntervalTimer {
	
	static String URL1 = "http://geoservicios.mtop.gub.uy/geoserver/mb_pap/wms?service=WMS&version=1.3.0&request=GetCapabilities";
	static String URL2 = "http://geoservicios.sgm.gub.uy/DPYO_UYMA.cgi?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetCapabilities";
	static int TIMEOUT_SERVICE = 18000;
	
	 @EJB
	 private EvaluationBeanRemote evaluationDao = new EvaluationBean();
	 private EvaluationPeriodicBeanRemote evaluationPeriodicDao = new EvaluationPeriodicBean();

	 private List<EvaluationPeriodic> listPeriodicObjects;

	 
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
     
        listPeriodicObjects = evaluationPeriodicDao.list();
        for(EvaluationPeriodic e:listPeriodicObjects){
        	boolean success = metricServiceAvailable(e.getMeasurableObjectUrl(), TIMEOUT_SERVICE);
        	System.out.println("checkService.. " + success + URL1);
        	
        	int count = e.getEvaluatedCount();
        	int countSuccess= e.getSuccessCount();
        	
        	count++;
        	if(success){
        		countSuccess++;
        	}
        	
        	e.setEvaluatedCount(count);
        	e.setSuccessCount(countSuccess);
        	e.setSuccessPercentage(countSuccess/count * 100);
        	
        	System.out.println(e.toString());
        	
        	evaluationPeriodicDao.update(e);
        }
        
    }
    
    @Timeout
    @AccessTimeout(value = 20, unit = TimeUnit.MINUTES)
    public void process(Timer timer) {
    	System.out.println("process timer..");
    }
    
    
    public boolean metricServiceAvailable(String url, int timeout) {
        url = url.replaceFirst("^https", "http"); 

        try {
        	URL u = new URL(url);
            HttpURLConnection connection = (HttpURLConnection) u.openConnection();
            connection.setConnectTimeout(timeout);
            connection.setReadTimeout(timeout);
            connection.setRequestMethod("HEAD");
            int responseCode = connection.getResponseCode();
            return (200 <= responseCode && responseCode <= 399);
        } catch (IOException exception) {
            return false;
        }
    }
    
}
