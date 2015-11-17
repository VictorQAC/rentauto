package ar.edu.unq.epers.testServicio

import ar.edu.unq.epers.servicio.UsuarioService
import ar.edu.unq.epers.model.UsuarioNeo
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Clasificacion
import ar.edu.unq.epers.model.Visibilidad
import org.junit.Before
import org.junit.Test
import org.junit.Assert
import org.mongojack.DBQuery
import org.junit.After

class UsuarioServiceMongoTest {
	UsuarioService userService
	UsuarioNeo Toreto
	Integer idAuto
	
	@Before
	def void setUp(){
		Toreto = new UsuarioNeo("Dominic","Toreto","dtoreto","mail@hotmail.com"
			,"123")
		idAuto = 1234
		userService = new UsuarioService()
	}
	
	@After
	def void cleanDB(){
		userService.mongoCollection.drop
	}
	
	@Test
	def void insert(){
		
		userService.calificarAuto(Clasificacion.EXCELENTE,Visibilidad.PUBLICO,
								"Alta nave",idAuto,Toreto.idNombre)
		
		
	    val query = DBQuery.is("idUsuario","dtoreto")
		val calificaciones = userService.getMongoCollection().find(query)
		
		Assert.assertEquals(calificaciones.size,1)
		
		val calificacion = calificaciones.get(0);

		Assert.assertEquals(calificacion.comentario, "Alta nave");
		Assert.assertEquals(calificacion.visibilidad, Visibilidad.PUBLICO);
	}
	
}