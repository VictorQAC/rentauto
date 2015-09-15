package ar.edu.unq.epers.testServicio


import java.sql.Date
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import static org.mockito.Mockito.*;
import ar.edu.unq.epers.servicio.Usuario
import ar.edu.unq.epers.servicio.RegistroyLogin
import ar.edu.unq.epers.home.UsuarioHome
import ar.edu.unq.epers.servicio.EnviadorDeMails
import ar.edu.unq.epers.excepciones.UsuarioExisteException
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import ar.edu.unq.epers.excepciones.NuevaPasswordInvalidaException
import ar.edu.unq.epers.excepciones.ValidacionException
import ar.edu.unq.epers.servicio.Mail
import ar.edu.unq.epers.servicio.GeneradorDeCodigo

class RegistroYLoginTestCase {
	
	var Usuario user
	var Usuario user2
	var RegistroyLogin sist
	var UsuarioHome mockHome
	var EnviadorDeMails mockEnv
	var Mail            mockMail
	var GeneradorDeCodigo mockGenerador
    
    @Before
    def void setUp(){
    	user = new Usuario("carlos","grillo","cargrillo","mail@hotmail.com"
			,"123",new Date(10 / 11 / 1990))
			
		user2 = new Usuario("jose","grillo","jgrillo","jmail@hotmail.com"
			,"122",new Date(10 / 12 / 1993))
			
			
		mockHome = mock(UsuarioHome)
		mockEnv = mock(EnviadorDeMails)
		mockGenerador = mock(GeneradorDeCodigo)
		sist = new RegistroyLogin(mockHome,mockEnv,mockGenerador)
    }
    
    @Test
	def void registrarUsuarioNoExistente(){
		//sist.borrarHome()
		
	    sist.registrarUsuario(user)
		
	    when(mockHome.existeUsuario(user.idNombre)).thenReturn(true)
		
		Assert.assertTrue(sist.usuarioExistente(user.idNombre))	
	}
	
	@Test
	(expected= UsuarioExisteException )def void registrarUsuarioExistente(){
		
		when(mockHome.existeUsuario(user.idNombre)).thenReturn(true)
		
		sist.registrarUsuario(user)
	}
	
	@Test
	def void ingresoDeUsuarioCorrectamente(){
		//sist.borrarHome()
		//sist.registrarUsuario(user)
		
		when(mockHome.existeUsuario(user.idNombre)).thenReturn(true)
		when(mockHome.loguearse(user.idNombre,user.password)).thenReturn(user)
		
		sist.ingresarUsuario(user.idNombre,user.password)
		
		Assert.assertTrue(sist.usuarioIngresadoCorrectamente(user))
	}
	
	@Test
	def void ingresoDeUsuarioConPasswordEquivocada(){
		//sist.borrarHome()
		//sist.registrarUsuario(user)
		
		when(mockHome.existeUsuario(user.idNombre)).thenReturn(true)
		when(mockHome.loguearse(user.idNombre,user.password)).thenReturn(null)
		
		sist.ingresarUsuario(user.idNombre,"Contraseña Incorrecta")
		
		Assert.assertFalse(sist.usuarioIngresadoCorrectamente(user))
	}
	
	@Test
	(expected= UsuarioNoExisteException ) def void ingresoDeUsuarioNoRegistrado(){
		
		sist.ingresarUsuario("Usuario No Registrado","345")
		
	}
	
	@Test
	def void cambiarPasswordTest(){
		//sist.borrarHome()
		//sist.registrarUsuario(user)
		
		var nuevaPass = "456"
		
		when(mockHome.getUsuarioPorIDNombre(user.idNombre)).thenReturn(user)
		
		sist.cambiarPassword(user.idNombre,user.password,nuevaPass)
		
		when(mockHome.getPassword(user.idNombre)).thenReturn(nuevaPass)
		
		Assert.assertTrue(sist.passwordCambiadoCorrectamente(user,nuevaPass))
	}
	
	@Test
	(expected= NuevaPasswordInvalidaException) def void cambiarPasswordTest_IngresoDeClaveIdenticaALaActual(){
		//sist.borrarHome()
		//sist.registrarUsuario(user)
		
		sist.cambiarPassword(user.idNombre,user.password,user.password)
	}
	
	@Test
	(expected= ValidacionException)  def void validarCuentaTest_ConCodigoDeValidacionIncorrecto(){
		//sist.borrarHome()
		//sist.registrarUsuario(user)
		
		var codigoValidacionIncorrecto = "codigoIncorrecto"
		sist.validarCuenta("codigoIncorrecto")
	}
	
	@Test
	
	def void mailEnviadoCorrectamenteTest(){
		
		sist.enviarMailConValidacion(mockMail)
		
		verify(mockEnv).enviarMail(mockMail)
	}
    
    @Test
	
	def void codigoGeneradoCorrectamenteTest(){
		
		sist.generarCodigoDeValidacionParaUsuario()
		
		verify(mockGenerador).generarCodigo()
	}
    
}