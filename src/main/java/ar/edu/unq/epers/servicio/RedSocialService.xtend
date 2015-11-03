package ar.edu.unq.epers.servicio

import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.home.RedSocialHome
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.TipoDeAmistad
import ar.edu.unq.epers.model.UsuarioNeo
import ar.edu.unq.epers.model.Mensaje
import ar.edu.unq.epers.model.EnvioDeMensaje

class RedSocialService {
	
	private def createHome(GraphDatabaseService graph) {
		new RedSocialHome(graph)
	}
	
	def crearUsuario(UsuarioNeo user) {
		GraphServiceRunner::run[
			createHome(it).crearNodo(user); 
			null
		]
	}
	
	def eliminarUsuario(UsuarioNeo user) {
		GraphServiceRunner::run[
			createHome(it).eliminarNodo(user)
			null
		]
	}
	
	def amigoDe(UsuarioNeo user1, UsuarioNeo user2) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.relacionar(user1, user2, TipoDeAmistad.AMIGO)
			//home.relacionar(user2, user1, TipoDeAmistad.AMIGO)
		]
	}
	
	def amigos(UsuarioNeo user) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getAmigos(user)
		]
	}
	
	def enviarMensaje(UsuarioNeo remitente,UsuarioNeo destinatario,Mensaje msj){
		GraphServiceRunner::run[
			val home = createHome(it);
			home.crearNodoMensaje(msj)
			home.envioOReseccionMjs(msj, remitente, EnvioDeMensaje.REMITENTE)
			home.envioOReseccionMjs(msj, destinatario, EnvioDeMensaje.DESTINATARIO)
		]
	}
	
	def getMensajesRecibidos(UsuarioNeo user, Mensaje msj){
		
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getMensajes(user,msj)
		]
	}
	
	def eliminarMensaje(Mensaje msj) {
		GraphServiceRunner::run[
			createHome(it).eliminarNodoMensaje(msj)
			null
		]
	}
	
	def crearMensaje(Mensaje msj) {
		GraphServiceRunner::run[
			createHome(it).crearNodoMensaje(msj); 
			null
		]
	}
}