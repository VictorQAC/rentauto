package Test

import home.UsuarioHome
import java.sql.Date
import servicio.Usuario
import org.junit.Before
import org.junit.Assert
import org.junit.Test

class UsuarioHomeTestCase {
	
	var UsuarioHome usuarioHome;
	var Usuario user
	var Usuario user2
	
	@Before
	def void setUp(){
		usuarioHome = new UsuarioHome()
		user = new Usuario("jorge","grillo","jgrillo","mail@hotmail.com"
			,"123",new Date(10 / 11 / 1990))
		user2 = new Usuario("pedro","grillo","pgrillo","mailP@hotmail.com"
			,"133",new Date(12 / 11 / 1990))		
	}
	
	
	
	@Test
	def void existeUsuarioTest(){
		usuarioHome.guardar(user)
		Assert.assertTrue(usuarioHome.existeUsuario("jgrillo"))
		usuarioHome.borrarDatos()
	}
	
	@Test
	def noExisteUsuarioTest(){
		
		Assert.assertFalse(usuarioHome.existeUsuario("pgrillo"))
	}
	
	@Test
	def noGetUsuarioPorCodigoDeValidacionTest(){
		Assert.assertEquals(usuarioHome.getUsuarioPorCodigoDeValidacion("unCodigoDeValidacion"),
							null)
	}
	
	@Test
	def void getUsuarioPorCodigoDeValidacionTest(){
		user.codigoDeValidacion = "soyUnCodigoDeValidacion"
		usuarioHome.guardar(user)
		Assert.assertEquals(usuarioHome.getUsuarioPorCodigoDeValidacion("soyUnCodigoDeValidacion").idNombre,
							user.idNombre)
		usuarioHome.borrarDatos()
	}
	
	@Test
	def void actualizarPasswordTest(){
		usuarioHome.guardar(user)
		Assert.assertEquals(usuarioHome.getPassword("jgrillo"),"123")
		usuarioHome.actualizarPassword("jgrillo","222")
		Assert.assertEquals(usuarioHome.getPassword("jgrillo"),"222")
		usuarioHome.borrarDatos()		
	}
	
	@Test
	def void loguearseTest(){
		usuarioHome.guardar(user)
		Assert.assertTrue(usuarioHome.loguearse("jgrillo","123"))
		usuarioHome.borrarDatos()
	}
	
	@Test
	def void noPuedeloguearseTest(){
		Assert.assertFalse(usuarioHome.loguearse("Juanito","123"))
	}
	
}