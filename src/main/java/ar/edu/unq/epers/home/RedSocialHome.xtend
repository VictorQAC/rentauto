package ar.edu.unq.epers.home

import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.DynamicLabel
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.TipoDeAmistad
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.RelationshipType
import org.neo4j.graphdb.Direction
import java.util.Date
import java.util.List
import ar.edu.unq.epers.model.Reserva

class RedSocialHome {
	GraphDatabaseService graph

	new(GraphDatabaseService graph) {
		this.graph = graph
	}

	private def userLabel() {
		DynamicLabel.label("User")
	}
	
	def crearNodo(Usuario user) {
		val node = this.graph.createNode(userLabel)
		//node.setProperty("idUsuario", user.idUsuario)
		node.setProperty("nombre", user.nombre)
		node.setProperty("apellido", user.apellido)
		node.setProperty("idNombre", user.idNombre)
		node.setProperty("password", user.password)
		node.setProperty("email", user.email)
		//node.setProperty("fechaDeNacimiento", user.fechaDeNacimiento)
		//node.setProperty("codigoDeValidacion", user.codigoDeValidacion)
		node.setProperty("estadoDeValidacion", user.estadoDeValidacion)
		node.setProperty("reservas", user.reservas)
	}
	
	def eliminarNodo(Usuario user) {
		val nodo = this.getNodo(user)
		nodo.relationships.forEach[delete]
		nodo.delete
	}
	
	def getNodo(Usuario user) {
		this.getNodo(user.idNombre)
	}
	
	def getNodo(String idNombre) {
		this.graph.findNodes(userLabel, "idUsuario", idNombre).head
	}
	
	def relacionar(Usuario user1, Usuario user2, TipoDeAmistad amistad) {
		val nodo1 = this.getNodo(user1);
		val nodo2 = this.getNodo(user2);
		nodo1.createRelationshipTo(nodo2, amistad);
	}
	
	def getAmigos(Usuario user) {
		
		val nodoUsuario = this.getNodo(user)
		val nodoAmigos = this.nodosRelacionados(nodoUsuario, TipoDeAmistad.AMIGO, Direction.OUTGOING)
		nodoAmigos.map[toUsuario].toSet
		
	}
	
	protected def nodosRelacionados(Node nodo, RelationshipType tipo, Direction direccion) {
		nodo.getRelationships(tipo, direccion).map[it.getOtherNode(nodo)]
	}
	
	private def toUsuario(Node nodo) {
		new Usuario => [
			//idUsuario = nodo.getProperty("idUsuario") as Integer
			nombre = nodo.getProperty("nombre") as String
			apellido = nodo.getProperty("apellido") as String
			idNombre = nodo.getProperty("idNombre") as String
			password = nodo.getProperty("password") as String
			email = nodo.getProperty("email") as String
			//fechaDeNacimiento = nodo.getProperty("fechaDeNacimiento") as Date
			//codigoDeValidacion = nodo.getProperty("codigoDeValidacion") as String
			estadoDeValidacion = nodo.getProperty("estadoDeValidacion") as Boolean
			reservas = nodo.getProperty("reservas") as List<Reserva>
		]
	}
}