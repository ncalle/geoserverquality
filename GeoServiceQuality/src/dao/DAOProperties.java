package dao;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Se encarga de cargar las propiedades DAO del archivo dao.properties
 */
public class DAOProperties {

    private static final String PROPERTIES_FILE = "dao.properties";
    private static final Properties PROPERTIES = new Properties();

    static {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        InputStream propertiesFile = classLoader.getResourceAsStream(PROPERTIES_FILE);

        if (propertiesFile == null) {
            throw new DAOConfigurationException(
                "Archivo Properties '" + PROPERTIES_FILE + "' no se encuentra en el classpath.");
        }

        try {
            PROPERTIES.load(propertiesFile);
        } catch (IOException e) {
            throw new DAOConfigurationException(
                "No es posible cargar el archivo Properties '" + PROPERTIES_FILE + "'.", e);
        }
    }

    private String specificKey;

    public DAOProperties(String specificKey) throws DAOConfigurationException {
        this.specificKey = specificKey;
    }


    public String getProperty(String key, boolean mandatory) throws DAOConfigurationException {
        String fullKey = specificKey + "." + key;
        String property = PROPERTIES.getProperty(fullKey);

        if (property == null || property.trim().length() == 0) {
            if (mandatory) {
                throw new DAOConfigurationException("La Property requerida '" + fullKey + "'"
                    + " no se encuentra en el archivo Properties '" + PROPERTIES_FILE + "'.");
            } else {
                property = null;
            }
        }

        return property;
    }

}