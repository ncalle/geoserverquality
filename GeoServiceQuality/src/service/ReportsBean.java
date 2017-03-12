package service;

import java.util.Iterator;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import org.primefaces.model.chart.Axis;
import org.primefaces.model.chart.AxisType;
import org.primefaces.model.chart.BarChartModel;
import org.primefaces.model.chart.ChartSeries;
import org.primefaces.model.chart.LineChartModel;
import org.primefaces.model.chart.LineChartSeries;
import org.primefaces.model.chart.PieChartModel;

import dao.DAOException;
import dao.ReportBean;
import dao.ReportBeanRemote;
import entity.Report;
 
@ManagedBean(name = "reportsBean")
@ViewScoped
public class ReportsBean { 
	private List<Report> listEvaluationSuccessVsFailed;
	private PieChartModel pieChartEvaluationSuccessVsFailed;
    
	private List<Report> listSuccessEvaluationPerProfile;
	private BarChartModel barChartSuccessEvaluationPerProfile;
	
	private LineChartModel mediaResponseTime;
 
    @EJB
	private ReportBeanRemote rDao = new ReportBean();
    
    @PostConstruct
    public void init() {
		try {
			setListEvaluationSuccessVsFailed(rDao.evaluationSuccessVsFailed());
			setListSuccessEvaluationPerProfile(rDao.successEvaluationPerProfile());
            createModels();
    	} catch(DAOException e) {
    		e.printStackTrace();
    	}      
    }
    
	public List<Report> getListEvaluationSuccessVsFailed() {
		return listEvaluationSuccessVsFailed;
	}

	public void setListEvaluationSuccessVsFailed(List<Report> listEvaluationSuccessVsFailed) {
		this.listEvaluationSuccessVsFailed= listEvaluationSuccessVsFailed;
	}
    	public LineChartModel getMediaResponseTime() {
		return mediaResponseTime;
	}
	
	public void setMediaResponseTime(LineChartModel mediaResponseTime) {
		this.mediaResponseTime = mediaResponseTime;
	}

	public PieChartModel getPieChartEvaluationSuccessVsFailed() {
		return pieChartEvaluationSuccessVsFailed;
	}

	public void setPieChartEvaluationSuccessVsFailed(PieChartModel pieChartEvaluationSuccessVsFailed) {
		this.pieChartEvaluationSuccessVsFailed = pieChartEvaluationSuccessVsFailed;
	}
	
	public List<Report> getListSuccessEvaluationPerProfile() {
		return listSuccessEvaluationPerProfile;
	}

	public void setListSuccessEvaluationPerProfile(List<Report> listSuccessEvaluationPerProfile) {
		this.listSuccessEvaluationPerProfile = listSuccessEvaluationPerProfile;
	}

	public BarChartModel getBarChartSuccessEvaluationPerProfile() {
		return barChartSuccessEvaluationPerProfile;
	}

	public void setBarChartSuccessEvaluationPerProfile(BarChartModel barChartSuccessEvaluationPerProfile) {
		this.barChartSuccessEvaluationPerProfile = barChartSuccessEvaluationPerProfile;
	}

	
    private void createModels() {
        createPieChartEvaluationSuccessVsFailed();
        createBarChartSuccessEvaluationPerProfile();
        createAnimatedModels();
    }
     
    private void createPieChartEvaluationSuccessVsFailed() {    	pieChartEvaluationSuccessVsFailed = new PieChartModel();
    	Report report = null;
    	    	
		Iterator<Report> iterator = listEvaluationSuccessVsFailed.iterator();
		if (iterator.hasNext()) {
			report = iterator.next();			
				
			if (report.getTotalEvaluationCount() == 0){
				pieChartEvaluationSuccessVsFailed.set("No existen resultados", 100);
			}
			else{
				pieChartEvaluationSuccessVsFailed.set("Exitos", report.getSuccessPercentage());
				pieChartEvaluationSuccessVsFailed.set("Fracasos", report.getFailPercentage());				
			}				
		}
         		pieChartEvaluationSuccessVsFailed.setTitle("Exitos vs Fracasos");		pieChartEvaluationSuccessVsFailed.setLegendPosition("e");		pieChartEvaluationSuccessVsFailed.setFill(false);		pieChartEvaluationSuccessVsFailed.setShowDataLabels(true);		pieChartEvaluationSuccessVsFailed.setDiameter(150);
    }
    
    private void createBarChartSuccessEvaluationPerProfile() {
    	barChartSuccessEvaluationPerProfile = new BarChartModel();
		Report report = null;
    	
        ChartSeries exitos = new ChartSeries();
        ChartSeries fracasos = new ChartSeries();
        exitos.setLabel("Exitos");
        fracasos.setLabel("Fracasos");
        
		Iterator<Report> iterator = listSuccessEvaluationPerProfile.iterator();
		while (iterator.hasNext()) {
			report = iterator.next();			
			if (report.getProfileName() != null && report.getProfileSuccessPercentage() != null){

				exitos.set(report.getProfileName(), report.getProfileSuccessPercentage());
		        fracasos.set(report.getProfileName(), (100 - report.getProfileSuccessPercentage()));				
			}
		}
		barChartSuccessEvaluationPerProfile.addSeries(exitos);
		barChartSuccessEvaluationPerProfile.addSeries(fracasos);
    }
        private void createAnimatedModels() {
    	mediaResponseTime = initLinearModel();
    	mediaResponseTime.setTitle("Line Chart");
    	mediaResponseTime.setAnimate(true);
    	mediaResponseTime.setLegendPosition("se");
        Axis yAxis = mediaResponseTime.getAxis(AxisType.Y);
        yAxis.setMin(0);
        yAxis.setMax(10);
    }
          
    private LineChartModel initLinearModel() {
        LineChartModel model = new LineChartModel();
 
        LineChartSeries series1 = new LineChartSeries();
        series1.setLabel("Series 1");
 
        series1.set(1, 2);
        series1.set(2, 1);
        series1.set(3, 3);
        series1.set(4, 6);
        series1.set(5, 8);
 
        LineChartSeries series2 = new LineChartSeries();
        series2.setLabel("Series 2");
 
        series2.set(1, 6);
        series2.set(2, 3);
        series2.set(3, 2);
        series2.set(4, 7);
        series2.set(5, 9);
 
        model.addSeries(series1);
        model.addSeries(series2);
         
        return model;
    }   
}