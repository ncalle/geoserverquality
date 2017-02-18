package EvaluationCore;

import java.security.KeyStore.Entry.Attribute;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.transform.stream.StreamSource;

import net.opengis.wms.v_1_3_0.AuthorityURL;
import net.opengis.wms.v_1_3_0.Capability;
import net.opengis.wms.v_1_3_0.Dimension;
import net.opengis.wms.v_1_3_0.Layer;
import net.opengis.wms.v_1_3_0.WMSCapabilities;


public final class App 
{

	static String URL = "http://www2.demis.nl/wms/wms.asp?REQUEST=GetCapabilities&VERSION=1.3.0&wms=WorldMap";
	
    public static void main( String[] args )
    {
        System.out.println( "Evaluation Core Test --------------------" );
        proccessWMS();
    }
    
    
    @SuppressWarnings("restriction")
	public static void proccessWMS(){
    	try {
    		
    		System.out.println( "proccessWMS.." );
    		
    		// Para un esquema determinado
			JAXBContext context = JAXBContext.newInstance("net.opengis.wms.v_1_3_0");
			
			// Varios esquemas
			//JAXBContext context = JAXBContext.newInstance("net.opengis.filter.v_1_1_0:net.opengis.gml.v_3_1_1");
			
			
			// Use the created JAXB context to construct an unmarshaller
			Unmarshaller unmarshaller = context.createUnmarshaller();
			 
			// Unmarshal the given URL, retrieve WMSCapabilities element
			JAXBElement<WMSCapabilities> wmsCapabilitiesElement = unmarshaller
			        .unmarshal(new StreamSource(URL), WMSCapabilities.class);
			 
			// Retrieve WMSCapabilities instance
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
    }
    

}
