package home

import java.sql.Connection
import java.sql.DriverManager
import java.sql.PreparedStatement
import org.eclipse.xtend.lib.annotations.Accessors
import servicio.Usuario
import java.sql.ResultSet

@Accessors
class UsuarioHome {
	new(){}
	
	private def Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/RentAuto?user=root&password=");
	}
	
	////////////////////////// aca esta lo nuevo /////////////
	
	def getUsuarioPorCodigoDeValidacion(String codigoValidacion) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT * FROM  USUARIO WHERE CODIGODEVALIDACION = ? ")
			ps.setString(1,codigoValidacion);
			val rs = ps.executeQuery()
		
			if (rs.next()) {
				val Usuario res = new Usuario
				res.nombre = rs.getString("NOMBRE")
				res.apellido = rs.getString("APELLIDO")
				res.idNombre = rs.getString("IDNOMBRE")
				res.password = rs.getString("PASSWORD")
				res.email = rs.getString("EMAIL")
				res.fechaDeNacimiento = rs.getDate("FECHADENACIMIENTO")
				res.codigoDeValidacion = rs.getString("CODIGODEVALIDACION")
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
					"INSERT INTO USUARIO (NOMBRE, APELLIDO,IDNOMBRE,
						PASSWORD,EMAIL,FECHADENACIMIENTO,CODIGODEVALIDACION,ESTADODEVALIDACION) VALUES (?,?,?,?,?,?,?,?)"
				);
			ps.setString(1, usuario.nombre);
			ps.setString(2, usuario.apellido);
			ps.setString(3, usuario.idNombre);
			ps.setString(4, usuario.password);
			ps.setString(5, usuario.email);
			ps.setDate(6, usuario.fechaDeNacimiento);
			ps.setString(7, usuario.codigoDeValidacion);
			ps.setBoolean(8, usuario.estadoDeValidacion);
			ps.executeUpdate();
			
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}
	
	def existeUsuario(String idNombre) {
		var String idUsuario
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT IDNOMBRE FROM USUARIO WHERE IDNOMBRE = ? ")
			ps.setString(1,idNombre);
			val ResultSet rs = ps.executeQuery()
		
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
	
	def actualizarPassword(String idNombre, String nuevaPassword) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("UPDATE USUARIO SET PASSWORD = ? WHERE IDNOMBRE = ?")
			ps.setString(1,nuevaPassword)
			ps.setString(2,idNombre)
			ps.executeUpdate()
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}
	
	def loguearse(String idName, String password) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT *
								FROM USUARIO WHERE IDNOMBRE = ? AND PASSWORD = ?")
			ps.setString(1,idName)
			ps.setString(2,password)
			var ResultSet rs =ps.executeQuery()
			return rs.next()						
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		
	}
	
	def getPassword(String idNombre) {
		var String pass;
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT PASSWORD FROM USUARIO WHERE IDNOMBRE= ? ")
			ps.setString(1,idNombre);
			var ResultSet rs = ps.executeQuery()
			
			if(rs.next()){
				pass = rs.getString("PASSWORD")
				return pass
			}
			else
				return "no tiene password"
				
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}
	
      def void borrarDatos(){
      	
      	var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("DELETE FROM USUARIO")
			ps.executeUpdate();
      	
      }finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
	}
	
	def actualizarValidacion(String idNombre, boolean estadoValidacion) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("UPDATE USUARIO SET ESTADODEVALIDACION = ? WHERE IDNOMBRE = ?")
			ps.setBoolean(1,estadoValidacion)
			ps.setString(2,idNombre)
			ps.executeUpdate()
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
			}
	}
      