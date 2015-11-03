package ar.edu.unq.epers.testServicio

import ar.edu.unq.epers.model.Usuario
import org.junit.Before
import java.util.Date
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.servicio.RedSocialService
import ar.edu.unq.epers.model.UsuarioNeo
import org.junit.After
import ar.edu.unq.epers.model.Mensaje

class RedSocialServiceTest {
	UsuarioNeo Juan
	UsuarioNeo Pedro
	UsuarioNeo Marta
	RedSocialService service
	Mensaje mensaje
	
	@Before
	def void setUp(){
		Juan = new UsuarioNeo("Juan","Grillo","jgrillo","mail@hotmail.com"
			,"123")
		Pedro = new UsuarioNeo("Pedro","Lopez","plopez","mailP@hotmail.com"
			,"456")
		Marta = new UsuarioNeo("Marta","Gonzalez","mgonzalez","mail@hotmail.com"
			,"789")	
		
		mensaje = new Mensaje("Hola como andas?")	
			
		service = new RedSocialService
		service.crearUsuario(Juan)
		service.crearUsuario(Pedro)
		service.crearUsuario(Marta)
		service.crearMensaje(mensaje)
	}
	
	@After
    def void limpiarBase() {
        service.eliminarUsuario(Juan)
        service.eliminarUsuario(Pedro)
        service.eliminarUsuario(Marta)
        service.eliminarMensaje(mensaje)
	}
	
	@Test
	def void usuarioJuanNoPoseeAmigos(){
		val amigos = service.amigos(Juan)
		Assert.assertEquals(0, amigos.length)
		//Assert.assertEquals(padres.head, padre)
	}
	
	@Test
	def void usuarioJuanPosseDosAmigos(){
		service.amigoDe(Juan,Pedro)
		service.amigoDe(Juan,Marta)
		val amigos = service.amigos(Juan)
		Assert.assertEquals(2, amigos.length)
		//Assert.assertEquals(padres.head, padre)
	}
	
	@Test
	def void envioDeMensaje(){
		
		service.enviarMensaje(Juan,Pedro,mensaje)
		val msjs = service.getMensajesRecibidos(Pedro,mensaje)
		
		Assert.assertEquals(1, msjs.length)
	}
	
	
}