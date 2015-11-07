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
	UsuarioNeo Carlos
	UsuarioNeo Maria
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
		Carlos = new UsuarioNeo("Carlos","Perez","cperez","mail@hotmail.com"
			,"34567")
		Maria = new UsuarioNeo("Maria","Peze","mperez","mail@hotmail.com"
			,"89718")
		
		
		mensaje = new Mensaje("Hola como andas?")	
			
		service = new RedSocialService
		service.crearUsuario(Juan)
		service.crearUsuario(Pedro)
		service.crearUsuario(Marta)
		service.crearUsuario(Carlos)
		service.crearUsuario(Maria)
		service.crearMensaje(mensaje)
	}
	
	@After
    def void limpiarBase() {
        service.eliminarUsuario(Juan)
        service.eliminarUsuario(Pedro)
        service.eliminarUsuario(Marta)
        service.eliminarUsuario(Carlos)
		service.eliminarUsuario(Maria)
        service.eliminarMensaje(mensaje)
	}
	
	@Test
	def void usuarioJuanNoPoseeAmigos(){
		val amigos = service.amigos(Juan)
		Assert.assertEquals(0, amigos.length)
	}
	
	@Test
	def void usuarioJuanPosseDosAmigos(){
		service.amigoDe(Juan,Pedro)
		service.amigoDe(Juan,Marta)
		val amigos = service.amigos(Juan)
		Assert.assertEquals(2, amigos.length)
	}
	
	@Test
	def void usuarioJuanLeEnviaUnMensajeAPedro(){
		
		service.enviarMensaje(Juan,Pedro,mensaje)
		val msjs = service.getMensajesRecibidos(Pedro,mensaje)
		
		Assert.assertEquals(1, msjs.length)
	}
	
	@Test
	def void usuarioJuanEstaRelacionadoConCuatroPersonas(){
		
		service.amigoDe(Juan,Pedro)
		service.amigoDe(Juan,Marta)
		service.amigoDe(Marta,Maria)
		service.amigoDe(Pedro,Carlos)
		
		val res = service.amigosDeAmigos(Juan)
		
		Assert.assertEquals(res.length, 4)
	}
	
	@Test
	def void usuarioCarlosNoEstaRelacionadoConNingunaPersona(){
		
		service.amigoDe(Juan,Pedro)
		service.amigoDe(Juan,Marta)
		service.amigoDe(Marta,Maria)
		
		val res = service.amigosDeAmigos(Carlos)
		
		Assert.assertEquals(res.length, 0)
	}
	
	
	
}