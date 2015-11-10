package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.UsuarioHomeH
import java.sql.Date
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Visibilidad
import ar.edu.unq.epers.model.Clasificacion
import ar.edu.unq.epers.model.Calificacion
import ar.edu.unq.epers.home.SistemMongoDB
import ar.edu.unq.epers.home.Collection

class UsuarioService {
	
	var Collection<Calificacion> calificaciones = SistemMongoDB.instance().collection(Calificacion)
	
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
	
	def calificarAuto(Clasificacion clasificacion, Visibilidad visibilidad,String comentario,Integer idAuto,String idUsuario){
		
		var Calificacion nuevaCalificacion = new  Calificacion (clasificacion,comentario,visibilidad,idAuto,idUsuario)
		calificaciones.insert(nuevaCalificacion)
		
	}
}