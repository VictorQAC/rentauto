package home

import java.sql.Connection
import java.sql.DriverManager
import java.sql.PreparedStatement
import org.eclipse.xtend.lib.annotations.Accessors
import servicio.Usuario

@Accessors
class UsuarioHome implements IHome {

	var String nombre
	var String apellido
	var String idNombre
	var String password
	var String email
	var String fechaDeNacimiento
	var String codigoDeValidacion
	var Integer estadoDeValidacion

	override recuperarUsuario(String nombreDelUsuario) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override recuperarUsuarioSegunCodigoDeValidacion(String codigoDeValidacion) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override void persistirUsuario(Usuario usuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;

		try {
			conn = this.getConnection();
			ps = conn.
				prepareStatement(
					"INSERT INTO usuario (NOMBRE, APELLIDO,IDNOMBRE,PASSWORD,EMAIL,FECHADENACIMIENTO,CODIGODEVALIDACION,ESTADODEVALIDACION) VALUES (?,?)"
				);
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
		} finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}

	private def Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/RentAuto?user=root&password=root");

	}
	
	
	
	////////////////////////// aca esta lo nuevo /////////////
	
	def getUsuarioPorCodigoDeValidacion(String codigoValidacion) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT * FROM  USUARIO WHERE CODIGODEVALIDACION = ? ")
			ps.setString(7,codigoValidacion);
			val rs = ps.executeQuery()
		
			if (rs.next()) {
				val Usuario res = new Usuario
				res.nombre = rs.getString("NOMBRE")
				res.apellido = rs.getString("APELLIDO")
				res.idNombre = rs.getString("IDNOMBRE")
				res.password = rs.getString("PASSWORD")
				res.email = rs.getString("EMAIL")
				res.fechaDeNacimiento = rs.getDate("FECHADENACIMIENTO")
				res.codigoDeValidacion = rs.getInt("CODIGODEVALIDACION")
				res.estadoDeValidacion = rs.getBoolean("ESTADODEVALIDACION")
				return res
        	}
        	else
        		return null
        		
        }finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
        
	}
	
	def guardar(Usuario usuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.
				prepareStatement(
					"INSERT INTO USUARIO (NOMBRE, APELLIDO,IDNOMBRE,PASSWORD,EMAIL,FECHADENACIMIENTO,CODIGODEVALIDACION,ESTADODEVALIDACION) VALUES (?,?)"
				);
			ps.setString(1, "usuario.nombre");
			ps.setString(2, "usuario.apellido");
			ps.setString(3, "usuario.idNombre");
			ps.setString(4, "usuario.password");
			ps.setString(5, "usuario.email");
			ps.setString(6, "usuario.fechaDeNacimiento");
			ps.setString(7, "usuario.codigoDeValidacion");
			ps.setString(8, "usuario.estadoDeValidacion");
		
			ps.executeQuery();
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}
	
	def existeUsuario(Usuario usuario) {
		var String idUsuario
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT * FROM  USUARIO WHERE IDNOMBRE = ? ")
			ps.setString(3,usuario.idNombre);
			val rs = ps.executeQuery()
		
			if (rs.next()) {
				idUsuario = rs.getString("IDNOMBRE")
			}
				return idUsuario != null
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}

}