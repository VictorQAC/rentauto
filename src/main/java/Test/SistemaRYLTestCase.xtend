package Test


import org.junit.Assert
import org.junit.Test
import java.sql.Date
import servicio.Usuario
import servicio.SistemaRegistroyLogin
import org.junit.Before
import Excepciones.UsuarioExisteException
import Excepciones.UsuarioNoExisteException
import Excepciones.NuevaPasswordInvalidaException
import Excepciones.ValidacionException

class SistemaRYLTestCase {
	
	var Usuario user
	var SistemaRegistroyLogin sist
    
    @Before
    def void setUp(){
    	user = new Usuario("carlos","grillo","cargrillo","mail@hotmail.com"
			,"123",new Date(10 / 11 / 1990))
		
		sist = new SistemaRegistroyLogin()
    }
    
    @Test
	def void registrarUsuarioNoExistente(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		Assert.assertTrue(sist.usuarioExistente(user.idNombre))	
	}
	
	@Test
	(expected= UsuarioExisteException )def void registrarUsuarioExistente(){
		sist.registrarUsuario(user)
	}
	
	@Test
	def void ingresoDeUsuarioCorrectamente(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		Assert.assertTrue(sist.ingresarUsuario(user.idNombre,user.password))
	}
	
	@Test
	def void ingresoDeUsuarioConPasswordEquivocada(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		Assert.assertFalse(sist.ingresarUsuario(user.idNombre,"Contraseña Incorrecta"))
	}
	
	@Test
	(expected= UsuarioNoExisteException ) def void ingresoDeUsuarioNoRegistrado(){
		sist.ingresarUsuario("Usuario No Registrado","345")
		
	}
	
	@Test
	def void cambiarPasswordTest(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		var nuevaPass = "456"
		sist.cambiarPassword(user.idNombre,user.password,nuevaPass)
		Assert.assertTrue(sist.ingresarUsuario(user.idNombre,nuevaPass))
	}
	
	@Test
	(expected= NuevaPasswordInvalidaException) def void cambiarPasswordTest_IngresoDeClaveIdenticaALaActual(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		sist.cambiarPassword(user.idNombre,user.password,user.password)
	}
	
	@Test
	(expected= ValidacionException)  def void validarCuentaTest_ConCodigoDeValidacionIncorrecto(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		var codigoValidacionIncorrecto = "codigoIncorrecto"
		sist.validarCuenta("codigoIncorrecto")
	}
    
}