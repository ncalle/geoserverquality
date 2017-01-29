package conexionDatos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.sql.ResultSet;
import java.sql.SQLException;

public class RegistryDao {
	public static boolean validate(String name, String pass) {		
		boolean status = false;
		Connection conn = null;
		PreparedStatement pst = null;

		String url = "jdbc:postgresql://localhost:5432/";
		String dbName = "geoservicequality";
		String driver = "org.postgresql.Driver";
		String userName = "postgres";
		String password = "root";
		try {
			Class.forName(driver).newInstance();
			conn = DriverManager
					.getConnection(url + dbName, userName, password);

			pst = conn
					.prepareStatement("INSERT INTO `GeoServiceQuality`.`Usuario` (`Email`, `UsuarioPassword`, 'Tipo') VALUES (?, ?, 'TC');");
			pst.setString(1, name);
			pst.setString(2, pass);
			
			//TODO: ingresar el resto de los campos del usuario

			status = (pst.executeUpdate() > 0);
			System.out.println("Insert into:" + status);

		} catch (Exception e) {
			System.out.println("Exception:" + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (pst != null) {
				try {
					pst.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return status;
	}
}