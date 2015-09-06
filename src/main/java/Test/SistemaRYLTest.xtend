package Test

import org.junit.Test
import servicio.SistemaRegistroyLogin
import servicio.Usuario
import org.junit.Assert

class SistemaRYLTest {
	@Test
	def prueba(){
		var SistemaRegistroyLogin sistema = new SistemaRegistroyLogin()
		var Usuario u = new Usuario("pepe","grillo","pgrillo",
				"pgrillo@hotmail.com","123", null)
		sistema.registrarUsuario(u)
		Assert.assertTrue(sistema.ingresarUsuario("pgrillo","123"))  
		//no funca
		
	}
}