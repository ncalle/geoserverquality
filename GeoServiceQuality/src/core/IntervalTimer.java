package core;

import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;
import javax.ejb.Singleton;
import javax.ejb.AccessTimeout;
import javax.ejb.Schedule;
import javax.ejb.Startup;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.ejb.TimerConfig;

import EvaluationCore.App;

@Singleton
@Startup
public class IntervalTimer {


    @PostConstruct
    public void applicationStartup() {
    	
    	//Timer automatico programado
    	scheduleTimer();
    	
         
    }
    
    @Schedule(minute="*/5", hour="*", persistent = true) // despierta cada 5 min
    public void scheduleTimer() {
    	TimerConfig timerConfig = new TimerConfig();
        timerConfig.setInfo("Timer");
        
        System.out.println("scheduleTimer : " + System.currentTimeMillis());
        
        App.proccessWMS();
        
    }
    
    @Timeout
    @AccessTimeout(value = 20, unit = TimeUnit.MINUTES)
    public void process(Timer timer) {
    	System.out.println("process timer..");
    }



}
