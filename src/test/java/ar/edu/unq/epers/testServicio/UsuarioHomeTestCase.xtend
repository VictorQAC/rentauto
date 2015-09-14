package ar.edu.unq.epers.testServicio



import java.sql.Date
import org.junit.Before
import org.junit.Assert
import org.junit.Test
import ar.edu.unq.epers.home.UsuarioHome
import ar.edu.unq.epers.servicio.Usuario

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
	def void existeUsuarioEnlaBD(){
		usuarioHome.borrarDatos()
		usuarioHome.guardar(user)
		Assert.assertTrue(usuarioHome.existeUsuario("jgrillo"))
	}
	
	@Test
	def noExisteUsuarioEnlaBD(){
		Assert.assertFalse(usuarioHome.existeUsuario("pgrillo"))
	}
	
	@Test
	def void getUsuarioPorCodigoDeValidacionTest_CodigoDeValidacionReferenciadoAlUsuario(){
		user.codigoDeValidacion = "soyUnCodigoDeValidacion"
		usuarioHome.borrarDatos()
		usuarioHome.guardar(user)
		Assert.assertEquals(usuarioHome.getUsuarioPorCodigoDeValidacion("soyUnCodigoDeValidacion").idNombre,
							user.idNombre)
	}
	
	@Test
	def getUsuarioPorCodigoDeValidacionTest_CodigoDeValidacionNoReferenciadoAlUsuario(){
		Assert.assertEquals(usuarioHome.getUsuarioPorCodigoDeValidacion("unCodigoDeValidacion"),
							null)
	}
	
	@Test
	def void actualizarPasswordTest(){
		usuarioHome.borrarDatos()
		usuarioHome.guardar(user)
		Assert.assertEquals(usuarioHome.getPassword("jgrillo"),"123")
		usuarioHome.actualizarPassword("jgrillo","222")
		Assert.assertEquals(usuarioHome.getPassword("jgrillo"),"222")		
	}
	
	@Test
	def void loguearseTest(){
		usuarioHome.borrarDatos()
		usuarioHome.guardar(user)
		Assert.assertEquals(usuarioHome.loguearse("jgrillo","123"),user)
	}
	
	@Test
	def void loguearseTest_UsuarioIncorrecto(){
		usuarioHome.borrarDatos()
		usuarioHome.guardar(user)
		Assert.assertEquals(usuarioHome.loguearse("Usuario Incorrecto","456"),null)
	}
	
	@Test
	def void loguearseTest_ContraseniaIncorrecta(){
		usuarioHome.borrarDatos()
		usuarioHome.guardar(user)
		Assert.assertEquals(usuarioHome.loguearse("jgrillo","Contraseña Incorrecta"),null)
	}
}