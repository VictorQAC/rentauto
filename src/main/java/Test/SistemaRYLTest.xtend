package Test


import org.junit.Assert
import org.junit.Test
import java.sql.Date
import servicio.Usuario
import servicio.SistemaRegistroyLogin
import org.junit.Before
import static org.mockito.Mockito.*;

class SistemaRYLTest {
	
	var Usuario user
	var SistemaRegistroyLogin sist
    
    @Before
    def void setUp(){
    	user = new Usuario("carlos","grillo","cargrillo","mail@hotmail.com"
			,"123",new Date(10 / 11 / 1990))
		
		sist = new SistemaRegistroyLogin()
    }
    
    @Test
	def void registrarUsuarioTest(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		Assert.assertTrue(sist.usuarioExistente(user.idNombre))
		sist.borrarHome()
		
	}
	
	@Test
	def void validarCuentaTest(){
		sist.borrarHome()
		sist.registrarUsuario(user)
		Assert.assertFalse(user.estadoDeValidacion)
		sist.validarCuenta(user.codigoDeValidacion)
		Assert.assertTrue(user.estadoDeValidacion)
		sist.borrarHome()
	}	/*
    
    @Test
	def void noValidarCuentaTest(){
			
	    sist.borrarHome()
	
		sist.registrarUsuario(user)
		Assert.assertFalse(user.estadoDeValidacion)
		
		
	}*/

	
}