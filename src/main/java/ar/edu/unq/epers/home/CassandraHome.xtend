package ar.edu.unq.epers.home

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import com.datastax.driver.mapping.MappingManager
import com.datastax.driver.mapping.Mapper
import ar.edu.unq.epers.model.AutosDisponibles
import ar.edu.unq.epers.servicio.AutoService
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.AutoCache
import java.util.List

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
			"patente text);"
		)

		session.execute("CREATE TABLE IF NOT EXISTS simplex.autosDisponibles (" + 
				"dia text, " +
				"ubicacion text, " +
				"autos list< frozen<autoCache>>," + 
				"PRIMARY KEY (dia, ubicacion));"
		)
		mapper = new MappingManager(session).mapper(AutosDisponibles);
	}
	
	def autosDisponiblesPara(Date dia, Ubicacion ubicacion){
		
		this.connect()
		
		val busqueda =  mapper.get(dia.toString,ubicacion.nombre)
		if(busqueda == null){
			
			val AutoService autoService = new AutoService()
			val autos = autoService.autosDisponibles(ubicacion,dia)
			
			val patentes = autoService.obtenerPatentes(autos)
			
			val AutosDisponibles busqueda1 = this.crearBusqueda(patentes,dia.toString,ubicacion.nombre)
			
			return busqueda1
		}
		else{
			return busqueda
		}
		
		
		
	}
	
	def buscarAutos(String dia, String ubicacion) {
		
		return mapper.get(dia,ubicacion)
	}
	
	def AutosDisponibles crearBusqueda(List<String> patentes,String  dia1, String ubic){
		
       var List<AutoCache> autosCache
	 
	 for(var i = patentes.size;i<=0;i--){
	 	  
	 	var patenteAutoCache = patentes.get(i) 
	 	
	 	var autoCache = new AutoCache(patenteAutoCache)
	 	
	 	
	 	autosCache.add(autoCache)
	 	
	 }	
	 
	 var AutosDisponibles autosDispon = new AutosDisponibles(dia1,ubic,autosCache)
     
     return autosDispon 
    } 
	
}