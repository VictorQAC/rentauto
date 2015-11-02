package ar.edu.unq.epers.servicio

import org.neo4j.graphdb.GraphDatabaseService
import ar.edu.unq.epers.home.RedSocialHome
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.TipoDeAmistad

class RedSocialService {
	
	private def createHome(GraphDatabaseService graph) {
		new RedSocialHome(graph)
	}
	
	def crearUsuario(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).crearNodo(user); 
			null
		]
	}
	
	def eliminarUsuario(Usuario user) {
		GraphServiceRunner::run[
			createHome(it).eliminarNodo(user)
			null
		]
	}
	
	def amigoDe(Usuario user1, Usuario user2) {
		GraphServiceRunner::run[
			val home = createHome(it);
			home.relacionar(user1, user2, TipoDeAmistad.AMIGO)
			//home.relacionar(user2, user1, TipoDeAmistad.AMIGO)
		]
	}
	
	def amigos(Usuario user) {
		GraphServiceRunner::run[
			val home = createHome(it)
			home.getAmigos(user)
		]
	}
	
}