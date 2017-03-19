package EvaluationCore;

import java.security.KeyStore.Entry.Attribute;
import java.util.List;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.stream.StreamSource;

import net.opengis.wms.v_1_3_0.AuthorityURL;
import net.opengis.wms.v_1_3_0.Capability;
import net.opengis.wms.v_1_3_0.DCPType;
import net.opengis.wms.v_1_3_0.Dimension;
import net.opengis.wms.v_1_3_0.Layer;
import net.opengis.wms.v_1_3_0.OperationType;
import net.opengis.wms.v_1_3_0.Style;
import net.opengis.wms.v_1_3_0.WMSCapabilities;

import net.opengis.wms.v_1_1_1.Request;
import net.opengis.wms.v_1_1_1.WMTMSCapabilities;
import net.opengis.filter.v_1_1_0.FilterCapabilities;
import net.opengis.wfs.v_1_1_0.WFSCapabilitiesType;



public final class App {

	//static String URL = "http://www2.demis.nl/wms/wms.asp?REQUEST=GetCapabilities&VERSION=1.3.0&wms=WorldMap";
	static String URL = "http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_logistica/wms?service=WMS&version=1.3.0&request=GetCapabilities";
	
    public static void main( String[] args ) {
        System.out.println( "Evaluation Core Test --------------------" );
        
    }
    
    
    public static boolean ejecuteMetric(Integer metricId, String url, String serviceType, int acceptanceValue){
    	 boolean res = false;
    	 
    	 switch (metricId) {
			case 0:
				res = metricInformationException(url, serviceType);
				break;
			case 1:
				res = metricOGCFormatException(url, serviceType);
				break;
			case 2:
				res = metricCRSInLayer(url, serviceType);
				break;
			case 3:
				res = metricGetMapFormat(url, serviceType, "PNG");
				break;
			case 4:
				res = metricGetMapFormat(url, serviceType, "KML");
				break;
			case 5:
				res = metricGetFeatureInfoFormat(url, serviceType, "text/html");
				break;
			case 6:
				res = metricFormatException(url, serviceType, "INIMAGE");
				break;
			case 7:
				res = metricFormatException(url, serviceType, "BLANK");
				break;
			case 8:
				res = metricCountMapFormat(url, serviceType) > acceptanceValue;
				break;
			case 9:
				res = metricCountFormatException(url, serviceType) > acceptanceValue;
				break;
			case 10:
				res = metricGetLegendGraphic(url, serviceType);
				break;
			case 11:
				res = metricScaleHint(url, serviceType);
				break;
	
			default:
				break;
			}
    	 
    	 return res;
    }
    
    @SuppressWarnings("restriction")
   	public static Unmarshaller getUnmarshallerWFS_1_1_0(){
   		try{
   			// Para un esquema determinado
   			JAXBContext context = JAXBContext.newInstance("net.opengis.wfs.v_1_1_0");
   			
   			// Use the created JAXB context to construct an unmarshaller
   			return context.createUnmarshaller();
   			
   		} catch (JAXBException e) {
  			e.printStackTrace();
  			return null;
  		}
   		
   	}
    
    @SuppressWarnings("restriction")
   	public static Unmarshaller getUnmarshaller(){
   		try{
   			// Para un esquema determinado
   			JAXBContext context = JAXBContext.newInstance("net.opengis.wms.v_1_3_0");
   			
   			// Use the created JAXB context to construct an unmarshaller
   			return context.createUnmarshaller();
   			
   		} catch (JAXBException e) {
  			e.printStackTrace();
  			return null;
  		}
   		
   	}
    
    @SuppressWarnings("restriction")
   	public static Unmarshaller getUnmarshaller_1_1_1(){
   		try{
   			// Para un esquema determinado
   			JAXBContext context = JAXBContext.newInstance("net.opengis.wms.v_1_1_1");
   			
   			// Use the created JAXB context to construct an unmarshaller
   			return context.createUnmarshaller();
   			
   		} catch (JAXBException e) {
  			e.printStackTrace();
  			return null;
  		}
   		
   	}
    
    @SuppressWarnings("restriction")
   	public static Unmarshaller getUnmarshaller_1_1_0(){
   		try{
   			// Para un esquema determinado
   			JAXBContext context = JAXBContext.newInstance("net.opengis.wms.v_1_1_0");
   			
   			// Use the created JAXB context to construct an unmarshaller
   			return context.createUnmarshaller();
   			
   		} catch (JAXBException e) {
  			e.printStackTrace();
  			return null;
  		}
   		
   	}
    
    
    /* --------------------------------------------------------------------------
     * Indica si las excepciones del servicio se encuentran en algún formato que evite exponer datos 
     * que sean de utilidad para un atacante. Algunos de estos datos pueden ser: servidor, sistema 
     * operativo, base de datos, etc. 
     * Ejemplos de estos formatos: application/vnd.ogc.se_inimage, application/vnd.ogc.se_blank
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricInformationException(String url, String serviceType){
    	boolean res = false;
       	try {
       		
       		if(serviceType.equals("WMS")) {
       			
       			Unmarshaller unmarshaller = getUnmarshaller();
       			
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			if(c.isSetException()){
       				List<String> list = c.getException().getFormat();
       				for (int i = 0; i < list.size(); i++) {
						if(list.get(i).equals("INIMAGE") || list.get(i).equals("BLANK")){
							return true;
						}
					}
       			}
       		} 
       		
       		/*else if(serviceType.equals("WFS")){
       			Unmarshaller unmarshaller = getUnmarshallerWFS_1_1_0();
       			
       			JAXBElement<WFSCapabilitiesType> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WFSCapabilitiesType.class);
       			
       			WFSCapabilitiesType wmsCapabilities = wmsCapabilitiesElement.getValue();
       			FilterCapabilities c = wmsCapabilities.getFilterCapabilities();
       			
       			return false;
       		}*/
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    
    /* --------------------------------------------------------------------------
     * Indica si el método soporta el formato de excepción format
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricFormatException(String url, String serviceType, String format){
    	boolean res = false;
       	try {
       		
       		
       		Unmarshaller unmarshaller = getUnmarshaller();
   			 
       		if(serviceType.equals("WMS")) {
       			// Unmarshal the given URL, retrieve WMSCapabilities element
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			// Retrieve WMSCapabilities instance
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			if(c.isSetException()){
       				List<String> list = c.getException().getFormat();
       				for (int i = 0; i < list.size(); i++) {
						if(list.get(i).equals(format)){
							return true;
						}
					}
       			}
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    /* --------------------------------------------------------------------------
     * Indica si las excepciones que son retornadas por el servicio se encuentran en 
     * algún formato propuesto por los estándares OGC.
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricOGCFormatException(String url, String serviceType){
    	boolean res = false;
       	try {
       		
       		Unmarshaller unmarshaller = getUnmarshaller();
   			 
       		if(serviceType.equals("WMS")) {
       			// Unmarshal the given URL, retrieve WMSCapabilities element
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			// Retrieve WMSCapabilities instance
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			if(c.isSetException()){
       				List<String> list = c.getException().getFormat();
       				for (int i = 0; i < list.size(); i++) {
						if(list.get(i).equals("INIMAGE") || list.get(i).equals("BLANK") 
								|| list.get(i).equals("XML") || list.get(i).equals("PARTIALMAP")
								|| list.get(i).equals("JSON") || list.get(i).equals("JSONP")){
							return true;
						}
					}
       			}
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    /* --------------------------------------------------------------------------
     * Indica la cantidad de diferentes formatos que soporta el servicio para 
     * retornar una excepción.
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static Integer metricCountFormatException(String url, String serviceType){
    	int res = 0;
       	try {
       		
       		Unmarshaller unmarshaller = getUnmarshaller();
   			 
       		if(serviceType.equals("WMS")) {
       			// Unmarshal the given URL, retrieve WMSCapabilities element
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			// Retrieve WMSCapabilities instance
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			if(c.isSetException()){
       				List<String> list = c.getException().getFormat();
       				res = list.size();
       			}
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    
    /* --------------------------------------------------------------------------
     * Indica si el método getMap() soporta el formato Format.
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricGetMapFormat(String url, String serviceType, String format){
    	boolean res = false;
       	try {
       		
       		Unmarshaller unmarshaller = getUnmarshaller();
   			 
       		if(serviceType.equals("WMS")) {
       			// Unmarshal the given URL, retrieve WMSCapabilities element
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			// Retrieve WMSCapabilities instance
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			if(c.getRequest()!=null && c.getRequest().getGetMap()!=null) {
       				for (String l : c.getRequest().getGetMap().getFormat()) {
    			    	if(format.equals(l)){
    			    		return true;
    			    	}
    				}
       			}
				
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    
    
    /* --------------------------------------------------------------------------
     * Indica si el método GetFeatureInfo() soporta el formato Format.
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricGetFeatureInfoFormat(String url, String serviceType, String format){
    	boolean res = false;
       	try {
       		
       		Unmarshaller unmarshaller = getUnmarshaller();
   			 
       		if(serviceType.equals("WMS")) {
       			// Unmarshal the given URL, retrieve WMSCapabilities element
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			// Retrieve WMSCapabilities instance
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			if(c.getRequest()!=null && c.getRequest().getGetFeatureInfo()!=null) {
       				for (String l : c.getRequest().getGetFeatureInfo().getFormat()) {
    			    	if(format.equals(l)){
    			    		return true;
    			    	}
    				}
       			}
				
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    /* --------------------------------------------------------------------------
     * Indica si las capas del servicio cumplen con el CRS adecuado.
     * --------------------------------------------------------------------------*/
    @SuppressWarnings("restriction")
   	public static boolean metricCRSInLayer(String url, String serviceType){
    	boolean res = true;
       	try {
       		Unmarshaller unmarshaller = getUnmarshaller();
  			 
       		if(serviceType.equals("WMS")) {
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			for (Layer layer : wmsCapabilities.getCapability().getLayer().getLayer()) {
       				if(!metricCRSInLayer(layer)){
       					return false;
       				}
    			}
       		}
       		
       		
   		} catch (Exception e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    
    /* --------------------------------------------------------------------------
     * Indica si la capa cumple con el CRS adecuado.
     * --------------------------------------------------------------------------*/
    
   	public static boolean metricCRSInLayer(Layer layer){
    	boolean res = false;
       	try {
       		
       		return layer.isSetCRS();
       		
   		} catch (Exception e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
   	
    /* --------------------------------------------------------------------------
     * Representa la cantidad total de formatos que puede soportar el servicio 
     * geográfico, en la totalidad de sus métodos.
     * --------------------------------------------------------------------------*/
   	
   	@SuppressWarnings("restriction")
   	public static int metricCountMapFormat(String url, String serviceType){
    	int res = 0;
       	try {
       		
       		Unmarshaller unmarshaller = getUnmarshaller();
   			 
       		if(serviceType.equals("WMS")) {
       			// Unmarshal the given URL, retrieve WMSCapabilities element
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			// Retrieve WMSCapabilities instance
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			if(c.getRequest()!=null && c.getRequest().getGetMap()!=null) {
       				return c.getRequest().getGetMap().getFormat().size();
       			}
				
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
   	
   	
   	/* --------------------------------------------------------------------------
     * Indica si el servicio implementa el método GetLegendGraphic.
     * Esta operacion esta solamente para versiones menores o iguales a v_1_1_1 del wms
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricGetLegendGraphic(String url, String serviceType){
    	boolean res = false;
       	try {
       		
       		Unmarshaller unmarshaller = getUnmarshaller_1_1_1();
  			 
       		if(serviceType.equals("WMS")) {
       			JAXBElement<net.opengis.wms.v_1_1_1.WMTMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), net.opengis.wms.v_1_1_1.WMTMSCapabilities.class);
       			
       			net.opengis.wms.v_1_1_1.WMTMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			
       			net.opengis.wms.v_1_1_1.Capability c = wmsCapabilities.getCapability();
       			
	       		if(c.getRequest()!=null && c.getRequest().getGetLegendGraphic()!=null) {
	       			return true;
	       		}
				
       		}
       		
       		
   		} catch (Exception e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    
    
    /* --------------------------------------------------------------------------
     * Indica si la capa tiene definido el parámetro <ScaleHint>. 
     * Dicho dato es el que sugiere cuál es la escala mínima y máxima en que es 
     * apropiado mostrar la capa.
     * Esta operacion esta solamente para versiones menores o iguales a v_1_1_0 del wms
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricScaleHint(String url, String serviceType){
    	boolean res = false;
       	try {
       		
       		Unmarshaller unmarshaller = getUnmarshaller_1_1_0();
   			 
       		if(serviceType.equals("WMS")) {
       			JAXBElement<net.opengis.wms.v_1_1_0.WMTMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), net.opengis.wms.v_1_1_0.WMTMSCapabilities.class);
       			
       			net.opengis.wms.v_1_1_0.WMTMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			
    			for (net.opengis.wms.v_1_1_0.Layer layer : wmsCapabilities.getCapability().getLayer().getLayer()) {
    				net.opengis.wms.v_1_1_0.ScaleHint scale = layer.getScaleHint();
    				
    				if(scale!=null) {
    					return true;
    				}
    			}
				
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    
}
