package ar.edu.unq.epers.testServicio

import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import java.util.Date
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.servicio.RedSocialService

class RedSocialServiceTest {
	Usuario Juan
	Usuario Pedro
	Usuario Marta
	RedSocialService service
	
	@Before
	def void setUp(){
		Juan = new Usuario("Juan","Grillo","jgrillo","mail@hotmail.com"
			,"123")
		Pedro = new Usuario("Pedro","Lopez","plopez","mailP@hotmail.com"
			,"456")
		Marta = new Usuario("Marta","Gonzalez","mgonzalez","mail@hotmail.com"
			,"789")	
		service = new RedSocialService
		service.crearUsuario(Juan)
		service.crearUsuario(Pedro)
		service.crearUsuario(Marta)
	}
	
	@Test
	def void noPoseeAmigos(){
		val amigos = service.amigos(Juan)
		Assert.assertEquals(0, amigos.length)
		//Assert.assertEquals(padres.head, padre)
	}
}