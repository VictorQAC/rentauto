package test;

import static org.junit.Assert.*;

import org.junit.Test;

public class UsuarioHomeTestCase {
   
	private usuario1 UsuarioHome;
	
	@Before
	public void setUp(){
		
		usuario = new ("Juan","Perez","userJP","juan@gmail.com","pass",10/02/88)
	}
	
	@Test
	public void testInsertar() {
		
		usuarioHome.persistirUsuario(usuario)
		Assert.assertEquals("Se espera que haya podido insertar 1 registro",1, ps.getUpdateCount());
	}

}
