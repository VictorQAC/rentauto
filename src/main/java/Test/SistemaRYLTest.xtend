package Test


import org.junit.Assert
import org.junit.Test
import java.sql.Date
import servicio.Usuario
import servicio.SistemaRegistroyLogin

class SistemaRYLTest {

	@Test
	def testDePrueba() {
		var Usuario u = new Usuario("pepe","grillo","pgrillo","mail@hotmail.com"
			,"123",new Date(10 / 11 / 1990))
		var SistemaRegistroyLogin sist = new SistemaRegistroyLogin()
		sist.registrarUsuario(u)
		Assert.assertTrue(sist.ingresarUsuario(u.idNombre,u.password))
	}

	
}