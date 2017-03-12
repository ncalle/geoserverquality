package service;

import java.util.Iterator;
import java.util.List;

import javax.annotation.PostConstruct;
import java.io.Serializable;
import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import org.primefaces.model.chart.Axis;
import org.primefaces.model.chart.AxisType;
import org.primefaces.model.chart.BarChartModel;
import org.primefaces.model.chart.ChartSeries;
import org.primefaces.model.chart.HorizontalBarChartModel;
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
	
	private HorizontalBarChartModel barChartSuccessEvaluationPerInstitution;
    private List<Report> listSuccessEvaluationPerInstitution;
	
	//success_evaluation_per_node
	//geographic_services_per_institution
	//evaluations_per_metric
	private LineChartModel mediaResponseTime;
 
    @EJB
	private ReportBeanRemote rDao = new ReportBean();
    
    @PostConstruct
    public void init() {
		try {
			setListEvaluationSuccessVsFailed(rDao.evaluationSuccessVsFailed());
			setListSuccessEvaluationPerProfile(rDao.successEvaluationPerProfile());
			setListSuccessEvaluationPerInstitution(rDao.successEvaluationPerInstitution());
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
	
	public HorizontalBarChartModel getBarChartSuccessEvaluationPerInstitution() {
		return barChartSuccessEvaluationPerInstitution;
	}

	public void setBarChartSuccessEvaluationPerInstitution(HorizontalBarChartModel barChartSuccessEvaluationPerInstitution) {
		this.barChartSuccessEvaluationPerInstitution = barChartSuccessEvaluationPerInstitution;
	}

	public List<Report> getListSuccessEvaluationPerInstitution() {
		return listSuccessEvaluationPerInstitution;
	}

	public void setListSuccessEvaluationPerInstitution(List<Report> listSuccessEvaluationPerInstitution) {
		this.listSuccessEvaluationPerInstitution = listSuccessEvaluationPerInstitution;
	}

	
    private void createModels() {
    	createPieChartEvaluationSuccessVsFailed();
        createBarChartSuccessEvaluationPerProfile();
        createBarChartSuccessEvaluationPerInstitution();
    	initLinearModel();
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
    	
    	barChartSuccessEvaluationPerProfile.setTitle("Exitos por Perfil");
    	barChartSuccessEvaluationPerProfile.setAnimate(true);
    	barChartSuccessEvaluationPerProfile.setLegendPosition("ne");
        Axis yAxis = barChartSuccessEvaluationPerProfile.getAxis(AxisType.Y);
        yAxis.setMin(0);
        yAxis.setMax(100);
        
		Report report = null;
    	
        ChartSeries exitos = new ChartSeries();
        exitos.setLabel("Exitos");
        
		Iterator<Report> iterator = listSuccessEvaluationPerProfile.iterator();
		while (iterator.hasNext()) {
			report = iterator.next();			
			if (report.getProfileName() != null && report.getProfileSuccessPercentage() != null){
				exitos.set(report.getProfileName(), report.getProfileSuccessPercentage());				
			}
		}
		barChartSuccessEvaluationPerProfile.addSeries(exitos);
    }
    
    private void createBarChartSuccessEvaluationPerInstitution() {
    	barChartSuccessEvaluationPerInstitution = new HorizontalBarChartModel();
         
		Report report = null;
    	
        ChartSeries exitos = new ChartSeries();
        exitos.setLabel("Exitos");
        
		Iterator<Report> iterator = listSuccessEvaluationPerInstitution.iterator();
		while (iterator.hasNext()) {
			report = iterator.next();			
			if (report.getInstitutionName() != null && report.getInstitutionSuccessPercentage() != null){
				exitos.set(report.getInstitutionName(), report.getInstitutionSuccessPercentage());				
			}
		}
         
        barChartSuccessEvaluationPerInstitution.addSeries(exitos);
         
        barChartSuccessEvaluationPerInstitution.setTitle("Exitos por Institución");
        barChartSuccessEvaluationPerInstitution.setAnimate(true);
        barChartSuccessEvaluationPerInstitution.setLegendPosition("e");
        barChartSuccessEvaluationPerInstitution.setStacked(true);
         
        Axis xAxis = barChartSuccessEvaluationPerInstitution.getAxis(AxisType.X);
        xAxis.setLabel("%Exitos");
        xAxis.setMin(0);
        xAxis.setMax(100);
         
        Axis yAxis = barChartSuccessEvaluationPerInstitution.getAxis(AxisType.Y);
        yAxis.setLabel("Institución");   
    }
    
    
    
    private void initLinearModel() {
        mediaResponseTime = new LineChartModel();
        
    	mediaResponseTime.setTitle("Tiempo medio de respuesta");
    	mediaResponseTime.setAnimate(true);
    	mediaResponseTime.setLegendPosition("se");
        Axis yAxis = mediaResponseTime.getAxis(AxisType.Y);
        yAxis.setMin(0);
        yAxis.setMax(10);
 
        LineChartSeries series1 = new LineChartSeries();
        series1.setLabel("Nodo 1");
 
        series1.set(1, 2);
        series1.set(2, 1);
        series1.set(3, 3);
        series1.set(4, 6);
        series1.set(5, 8);
 
        LineChartSeries series2 = new LineChartSeries();
        series2.setLabel("Nodo 2");
 
        series2.set(1, 6);
        series2.set(2, 3);
        series2.set(3, 2);
        series2.set(4, 7);
        series2.set(5, 9);
 
        mediaResponseTime.addSeries(series1);
        mediaResponseTime.addSeries(series2);
         
    } 
}