package home

import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



@Accessors
class UsuarioHome implements IHome{

	var String nombre
	var String apellido
	var String idNombre
	var String password
	var String email
	var String fechaDeNacimiento
	var String codigoDeValidacion
	var Integer estadoDeValidacion

}

def void persistirUsuario(Usuario usuario){
	
	Connection conn = null;
	PreparedStatement ps = null;
	
	try{
		conn = this.getConnection();
		ps = conn.prepareStatement("INSERT INTO usuario (NOMBRE, APELLIDO,IDNOMBRE,PASSWORD,EMAIL,FECHADENACIMIENTO,CODIGODEVALIDACION,ESTADODEVALIDACION) VALUES (?,?)");
        ps.setString(1, "usuario.nombre");
		ps.setString(2, "usuario.apellido");
		ps.setString(3, "usuario.idNombre");
		ps.setString(4, "usuario.password");
		ps.setString(5, "usuario.email");
		ps.setString(6, "usuario.fechaDeNacimiento");
        ps.setString(7, "usuario.codigoDeValidacion");
        ps.setString(8, "usuario.estadoDeValidacion");
  		ps.execute();
		
		ps.close();
		}finally{
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		}
		
	private Connection getConnection() throws Exception {
	Class.forName("com.mysql.jdbc.Driver");
	return DriverManager.getConnection("jdbc:mysql://localhost/RentAuto?user=root&password=root");
	}	
}