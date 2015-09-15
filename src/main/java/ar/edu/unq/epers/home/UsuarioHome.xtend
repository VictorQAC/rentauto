package ar.edu.unq.epers.home

import java.sql.Connection
import java.sql.DriverManager
import java.sql.PreparedStatement
import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.ResultSet
import ar.edu.unq.epers.servicio.Usuario

@Accessors
class UsuarioHome {
	new(){}
	
	/**
	 * Genera la coneccion a la Base de Datos
	 */
	private def Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/RentAuto?user=root&password=root");
	}
	
	/**
	 * Trae de la Base de Datos el usuario referenciado al codigo de validacion
	 * @param codigoValidacion = Es el codigo de validacion utilizado para obtener el
	 * usuario.
	 */
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
	
	/**
	 * Guarda los datos del usuario en la Base de Datos
	 * @param usuario = Es el usuario a persistir
	 */
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
	
	/**
	 * Devuelve true si el usario existe en la Base de datos
	 * @param idNombre = Es el ID del usuario a buscar.
	 */
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
	
	/**
	 * Actualiza el password del usuario informado
	 * @param idNombre = El ID del usuario a actualizar el password
	 * @param nuevaPassword = Password a actualizar.
	 */
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
	
	/**
	 * Devuelve true si se pudo loguear
	 * @param idNombre = El ID del usuario a loquearse
	 * @param password = El Password del usuario a loquearse
	 */
	def loguearse(String idNombre, String password) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT *
								FROM USUARIO WHERE IDNOMBRE = ? AND PASSWORD = ?")
			ps.setString(1,idNombre)
			ps.setString(2,password)
			var ResultSet rs =ps.executeQuery()
			if (rs.next()) {
				var Usuario user = new Usuario(rs.getString("NOMBRE"),rs.getString("APELLIDO"),
										rs.getString("IDNOMBRE"),rs.getString("EMAIL"),
										rs.getString("PASSWORD"),rs.getDate("FECHADENACIMIENTO"))
				user.codigoDeValidacion = rs.getString("CODIGODEVALIDACION")
				user.estadoDeValidacion = rs.getBoolean("ESTADODEVALIDACION")
				return user
			}else{
				return null
			}						
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
		
	}
	
	/**
	 * Devuelve el password del usuario pasado por parametro
	 * @param idNombre = El ID del usuario a obtener el password
	 */
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
	
	/**
	 * Borra los datos de la Base de Datos
	 */
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
	
	/**
	 * Actualiza el estado de validacion del usuario en la Base de Datos
	 * @param idNombre = El ID del usuario que se le actualizara el estado de validacion
	 * @param estadoValidacion = Booleano a setear 
	 */
	def actualizar(Usuario user) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("UPDATE USUARIO SET NOMBRE = ? ,
										APELLIDO = ? ,PASSWORD = ? ,FECHADENACIMIENTO = ? ,
										EMAIL = ? ,CODIGODEVALIDACION = ? ,ESTADODEVALIDACION = ?
										WHERE IDNOMBRE = ?")
			ps.setString(1,user.nombre)
			ps.setString(2,user.apellido)
			ps.setString(3,user.password)
			ps.setDate(4,user.fechaDeNacimiento)
			ps.setString(5,user.email)
			ps.setString(6,user.codigoDeValidacion)
			ps.setBoolean(7,user.estadoDeValidacion)
			ps.setString(8,user.idNombre)
			ps.executeUpdate()
		}finally {
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();
		}
			}
	
	def getUsuarioPorIDNombre(String idNombre) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try {
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT * FROM  USUARIO WHERE IDNOMBRE = ? ")
			ps.setString(1,idNombre);
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
	
	}
      