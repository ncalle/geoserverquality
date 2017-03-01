package service;

import javax.annotation.PostConstruct;
import java.io.Serializable;
import javax.faces.bean.ManagedBean;

import org.primefaces.model.chart.Axis;
import org.primefaces.model.chart.AxisType;
import org.primefaces.model.chart.LineChartModel;
import org.primefaces.model.chart.LineChartSeries;
import org.primefaces.model.chart.PieChartModel;
 
@ManagedBean
public class ReportsBean implements Serializable {
 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private PieChartModel pieChartServicesPerInstitution;
    private LineChartModel mediaResponseTime;
 
    @PostConstruct
    public void init() {
        createPieModels();
    }
      
    public PieChartModel getPieChartServicesPerInstitution() {
        return pieChartServicesPerInstitution;
    }
     
    private void createPieModels() {
        createPieChartServicesPerInstitution();
        createAnimatedModels();
    }
    
	public LineChartModel getMediaResponseTime() {
		return mediaResponseTime;
	}

	public void setMediaResponseTime(LineChartModel mediaResponseTime) {
		this.mediaResponseTime = mediaResponseTime;
	}
     
    private void createPieChartServicesPerInstitution() {
    	pieChartServicesPerInstitution = new PieChartModel();
         
    	pieChartServicesPerInstitution.set("Brand 1", 540);
    	pieChartServicesPerInstitution.set("Brand 2", 325);
    	pieChartServicesPerInstitution.set("Brand 3", 702);
    	pieChartServicesPerInstitution.set("Brand 4", 421);
         
    	pieChartServicesPerInstitution.setTitle("Custom Pie");
    	pieChartServicesPerInstitution.setLegendPosition("e");
    	pieChartServicesPerInstitution.setFill(false);
    	pieChartServicesPerInstitution.setShowDataLabels(true);
    	pieChartServicesPerInstitution.setDiameter(150);
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