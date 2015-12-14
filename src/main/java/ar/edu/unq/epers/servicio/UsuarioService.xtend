package ar.edu.unq.epers.servicio

import ar.edu.unq.epers.home.SessionManager
import ar.edu.unq.epers.home.UsuarioHomeH
import java.util.Date
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Visibilidad
import ar.edu.unq.epers.model.Clasificacion
import ar.edu.unq.epers.model.Calificacion
import ar.edu.unq.epers.home.SistemMongoDB
import ar.edu.unq.epers.home.Collection
import ar.edu.unq.epers.model.UsuarioNeo
import ar.edu.unq.epers.home.RedSocialHome
import org.neo4j.graphdb.GraphDatabaseService
import org.mongojack.DBQuery
import java.util.List
import org.mongojack.DBCursor

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
	
	def getMongoCollection() {
		calificaciones.getMongoCollection()
	
	}

	
	def List<Calificacion> verPerfilDe(UsuarioNeo user, UsuarioNeo user2){
		var RedSocialService rs = new RedSocialService()
		var query = DBQuery.is("idUsuario",user2.idNombre)
		if(rs.sonAmigos(user,user2)){
			query.and(DBQuery.in("visibilidad", #[Visibilidad.SOLOAMIGOS, Visibilidad.PUBLICO]))
			
		}else{
			query.and(DBQuery.is("visibilidad",Visibilidad.PUBLICO))
		}
		return this.getMongoCollection().find(query).iterator.toList
	}
	
}