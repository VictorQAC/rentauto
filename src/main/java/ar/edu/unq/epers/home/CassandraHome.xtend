package ar.edu.unq.epers.home

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.mapping.MappingManager
import com.datastax.driver.mapping.Mapper
import ar.edu.unq.epers.model.AutosDisponibles
import ar.edu.unq.epers.servicio.AutoService

class CassandraHome {
	
	Cluster cluster
	Session session
	
	Mapper<AutosDisponibles> mapper
	
	def connect() {
		cluster = Cluster.builder().addContactPoint("localhost").build();
		session = cluster.connect();
	}
	
	
	def createSchema() {
		session.execute("CREATE KEYSPACE IF NOT EXISTS  simplex WITH replication = {'class':'SimpleStrategy', 'replication_factor':3};")

		session.execute("CREATE TYPE IF NOT EXISTS simplex.autoCache (" +
			"patente text," + 
			"ubicacionInicial text);"
		)

		session.execute("CREATE TABLE IF NOT EXISTS simplex.autosDisponibles (" + 
				"dia text, " +
				"ubicacion text, " +
				"autos list< frozen<autoCache>>," + 
				"PRIMARY KEY (dia, ubicacion));"
		)
		mapper = new MappingManager(session).mapper(AutosDisponibles);
	}
	
	def autosDisponiblesPara(String dia, String ubicacion){
		
		this.connect()
		
		val busqueda =  mapper.get(dia,ubicacion)
		if(busqueda == null){
			AutoService autoService = new AutoService()
		}
		else{
			return busqueda
		}
		
		
		
	}
	
}