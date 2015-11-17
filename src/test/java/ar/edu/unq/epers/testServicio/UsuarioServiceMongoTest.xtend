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
import ar.edu.unq.epers.servicio.RedSocialService

class UsuarioServiceMongoTest {
	UsuarioService userService
	RedSocialService redSocialService
	UsuarioNeo Toreto
	UsuarioNeo Traverso
	Integer idAuto
	Integer idAuto2
	Integer idAuto3
	
	@Before
	def void setUp(){
		Toreto = new UsuarioNeo("Dominic","Toreto","dtoreto","mail@hotmail.com"
			,"123")
		Traverso = new UsuarioNeo("Juan Maria","Traverso","jmtraverso","mail@hotmail.com"
			,"456")	
		idAuto = 1234
		idAuto2 = 4563
		idAuto3 = 9382
		userService = new UsuarioService()
		redSocialService = new RedSocialService()
		redSocialService.crearUsuario(Toreto)
		redSocialService.crearUsuario(Traverso)
		
	}
	
	@After
	def void cleanDB(){
		userService.mongoCollection.drop
		redSocialService.eliminarUsuario(Toreto)
		redSocialService.eliminarUsuario(Traverso)
	}
	
	@Test
	def void insertCalificacion(){
		
		userService.calificarAuto(Clasificacion.EXCELENTE,Visibilidad.PUBLICO,
								"Alta nave",idAuto,Toreto.idNombre)
		
	    val query = DBQuery.is("idAuto",1234)
		val calificaciones = userService.getMongoCollection().find(query)
		
		Assert.assertEquals(calificaciones.size,1)
		
		val calificacion = calificaciones.get(0);

		Assert.assertEquals(calificacion.comentario, "Alta nave");
		Assert.assertEquals(calificacion.visibilidad, Visibilidad.PUBLICO);
	}
	
	
	@Test
	def void verPerfilEntreAmigosTest(){
		redSocialService.amigoDe(Toreto,Traverso)
		userService.calificarAuto(Clasificacion.EXCELENTE,Visibilidad.PUBLICO,
								"Alta nave",idAuto,Toreto.idNombre)
		userService.calificarAuto(Clasificacion.BUENO,Visibilidad.SOLOAMIGOS,
								"Sin Aire Acondicionado",idAuto2,Toreto.idNombre)
		userService.calificarAuto(Clasificacion.MALO,Visibilidad.PRIVADO,
								"Demasiados problemas",idAuto3,Toreto.idNombre)
		val calificaciones = userService.verPerfilDe(Traverso,Toreto)
		Assert.assertEquals(calificaciones.length,2)
	}
	 @Test
	def void verPerfilEntreNoAmigosTest(){
		
	
		redSocialService.amigoDe(Toreto,Traverso)
		userService.calificarAuto(Clasificacion.EXCELENTE,Visibilidad.PRIVADO,
								"Alta nave",idAuto,Toreto.idNombre)
		userService.calificarAuto(Clasificacion.MALO,Visibilidad.PRIVADO,
								"Demasiados problemas",idAuto3,Toreto.idNombre)
		val calificaciones = userService.verPerfilDe(Traverso,Toreto)
		Assert.assertEquals(calificaciones.length,0)
  }

}