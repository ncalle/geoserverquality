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


public final class App {

	//static String URL = "http://www2.demis.nl/wms/wms.asp?REQUEST=GetCapabilities&VERSION=1.3.0&wms=WorldMap";
	static String URL = "http://geoservicios.mtop.gub.uy/geoserver/inf_tte_ttelog_logistica/wms?service=WMS&version=1.3.0&request=GetCapabilities";
	
    public static void main( String[] args ) {
        System.out.println( "Evaluation Core Test --------------------" );
        proccessWMS();
        
        boolean ok = metricInformationException(URL, "WMS");
        System.out.println( "metricInformationException -------------------- " + ok);
        
        ok = metricOGCFormatException(URL, "WMS");
        System.out.println( "metricInformationException -------------------- " + ok);
        
        int i = metricCountMapFormat(URL, "WMS");
        System.out.println( "metricCountMapFormat -------------------- " + i);
        
    }
    
    
    @SuppressWarnings("restriction")
	public static void proccessWMS(){
    	try {
    		
    		Unmarshaller unmarshaller = getUnmarshaller();
			 
			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
			        .unmarshal(new StreamSource(URL), WMSCapabilities.class);
			 
			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
			
			//Excepciones
			Capability c = wmsCapabilities.getCapability();
			ExceptionInfo(c);
			
			// Capas
			for (Layer layer : wmsCapabilities.getCapability().getLayer().getLayer()) {
				layerInfo(layer);
			}
			
		} catch (JAXBException e) {
			e.printStackTrace();
		}
    }
    
    private static void ExceptionInfo(Capability c){
    	System.out.println("------------------------- ");
    	System.out.println("Formato Excepcion: " + c.getException().getFormat().toString());
		System.out.println("Excepcion manejo: " + c.isSetException());
    }
    
    private static void layerInfo(Layer layer){
    	System.out.println("------------------------- ");
    	System.out.println("ID capa: " + layer.getIdentifier());
	    System.out.println("Nombre Capa: " + layer.getName());
	    
	    if(layer.isSetTitle()){
	    	 System.out.println("Titulo Capa: " + layer.getTitle());
	    }
	   
	    System.out.println("Escala max: " + layer.getMaxScaleDenominator());
	    System.out.println("Escala min: " + layer.getMinScaleDenominator());
	    
	    if(layer.getAttribution()!=null){
	    	System.out.println("Atributo: " + layer.getAttribution().getTitle());
	    }
	    
	    System.out.println("isSetAuthorityURL: " + layer.isSetAuthorityURL());
	    for (AuthorityURL a : layer.getAuthorityURL()) {
	    	System.out.println("AuthorityURL: " + a.getName());
		}
	    
	    System.out.println("isSetCRS: " + layer.isSetCRS());
	    if(layer.isSetCRS()){
	    	System.out.println("CRS: " + layer.getCRS());
	    }
	    
	    System.out.println("isSetCascaded: " + layer.isSetCascaded());
	    if(layer.isSetCascaded()){
	    	System.out.println("Cascaded: " + layer.getCascaded());
	    }
	    
	    if(layer.getKeywordList()!=null){
	    	 System.out.println("KeywordList: " + layer.getKeywordList().toString());
	    }
	    
	    for (Dimension l : layer.getDimension()) {
	    	System.out.println("Dimension: " + l.getName() + " unidad: " + l.getUnits());
		}
	    
	    System.out.println("isSetFixedHeight: " + layer.isSetFixedHeight());
	    if(layer.isSetFixedHeight()){
	    	System.out.println("Height: " + layer.getFixedHeight());
	    }
	    
	    System.out.println("isSetFixedHeight: " + layer.isSetFixedWidth());
	    if(layer.isSetFixedWidth()){
	    	System.out.println("Width: " + layer.getFixedWidth());
	    }
	    
	    System.out.println("isOpaque: " + layer.isOpaque());
	    System.out.println("isSetOpaque: " + layer.isSetOpaque());
	    System.out.println("isQueryable: " + layer.isQueryable());
	    System.out.println("isSetBoundingBox: " + layer.isSetBoundingBox());
	    
	    
	    if(layer.getAttribution()!=null){
	    	System.out.println("getLogoURL: " + layer.getAttribution().getLogoURL());
	    }
	    
	    System.out.println("getMetadataURL: " + layer.getMetadataURL());
	    
	    for (Style l : layer.getStyle()) {
	    	System.out.println("Style: " + l.getName());
		}
	    
	    
    }
    
    @SuppressWarnings("restriction")
   	public static Unmarshaller getUnmarshaller(){
   		try{
   			// Para un esquema determinado
   			JAXBContext context = JAXBContext.newInstance("net.opengis.wms.v_1_3_0");
   			
   			// Varios esquemas
   			//JAXBContext context = JAXBContext.newInstance("net.opengis.filter.v_1_1_0:net.opengis.gml.v_3_1_1");
   			
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
						if(list.get(i).equals("INIMAGE") || list.get(i).equals("BLANK")){
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
   	public static Integer metricNumberFormatException(String url, String serviceType){
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
     * Esta operacion esta solamente para versiones menores o iguales a v_1_1_0 del wms
     * --------------------------------------------------------------------------*/
    
    @SuppressWarnings("restriction")
   	public static boolean metricGetLegendGraphic(String url, String serviceType){
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
       			
       			//Todo habilitar esto para versiones anteriores
       			//if(c.getRequest()!=null && c.getRequest().getGetLegendGraphic()!=null) {
		    		return true;
       				
       			//}
				
       		}
   			
   		} catch (JAXBException e) {
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
       		
       		Unmarshaller unmarshaller = getUnmarshaller();
   			 
       		if(serviceType.equals("WMS")) {
       			// Unmarshal the given URL, retrieve WMSCapabilities element
       			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
       			        .unmarshal(new StreamSource(url), WMSCapabilities.class);
       			
       			// Retrieve WMSCapabilities instance
       			WMSCapabilities wmsCapabilities = wmsCapabilitiesElement.getValue();
       			Capability c = wmsCapabilities.getCapability();
       			
       			//TODO: habilitar esto para versiones anteriores
       			//if(c.getRequest()!=null && c.getRequest().getScaleHint()!=null) {
		    		return true;
       				
       			//}
				
       		}
   			
   		} catch (JAXBException e) {
   			e.printStackTrace();
   		}
       	return res;
    }
    
    
}
