package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.UsuarioHomeH
import java.sql.Date

class UsuarioService {
	
	def consultarUsuario(int id_usuario){
	       
	       SessionManager.runInSession([
			
			new UsuarioHomeH().get(id_usuario)
			
		])
	 }
	
	def guardarUsuario(String unNombre, String unApellido, String unNombreDeUsuario,
			String unEmail,String unPassword,Date unaFechaDeNacimiento) {
		
		SessionManager.runInSession([
			var Usuario user = new Usuario(unNombre,unApellido,unNombreDeUsuario,unEmail,unPassword,unaFechaDeNacimiento)
			new UsuarioHomeH().save(user)
			user
      ])	
	}
	
	def persistirUsuario(Usuario usuario) {
		SessionManager.runInSession([
			new UsuarioHomeH().save(usuario)
			usuario
      ])
	}
	
}