package Test


import org.junit.Assert
import org.junit.Test
import java.sql.Date
import servicio.Usuario
import servicio.SistemaRegistroyLogin
import org.junit.Before
import static org.mockito.Mockito.*;
import Excepciones.UsuarioExisteException
import Excepciones.UsuarioNoExisteException

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
		//sist.borrarHome()	
	}
	
	@Test
	(expected= UsuarioExisteException )def registrarUsuarioExistente(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		sist.registrarUsuario(user)
	}
	
	@Test
	def void ingresoDeUsuarioCorrectamente(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		Assert.assertTrue(sist.ingresarUsuario(user.idNombre,user.password))
		//sist.borrarHome()
	}
	
	@Test
	def void ingresoDeUsuarioConPasswordEquivocada(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		Assert.assertFalse(sist.ingresarUsuario(user.idNombre,"Contraseña Incorrecta"))
		//sist.borrarHome()
	}
	
	@Test
	(expected= UsuarioNoExisteException ) def ingresoDeUsuarioNoRegistrado(){
		Assert.assertTrue(sist.ingresarUsuario("Usuario No Registrado","345"))
		
	}
	
	
	
	
	/* 
	@Test
	def void validarCuentaTest(){
		sist.registrarUsuario(user)
		Assert.assertFalse(user.estadoDeValidacion)
		sist.validarCuenta(user.codigoDeValidacion)
		Assert.assertTrue(user.estadoDeValidacion)
		sist.borrarHome()
	}*/
	
		/*
    
    @Test
	def void noValidarCuentaTest(){
			
	    sist.borrarHome()
	
		sist.registrarUsuario(user)
		Assert.assertFalse(user.estadoDeValidacion)
		
		
	}*/

	
}