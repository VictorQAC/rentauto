package ar.edu.unq.epers.testServicio

import org.junit.Before
import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Familiar
import ar.edu.unq.epers.model.Ubicacion
import org.junit.Test
import ar.edu.unq.epers.home.AutoHome
import org.junit.Assert

class AutoHomeTestCase {
	
	var AutoHome autH
	var Auto auto1
	var Categoria cat1
	var Ubicacion ubic
	
	@Before
	def void setUp(){
		
		autH = new AutoHome()
		cat1 = new Familiar()
		ubic = new Ubicacion("Retiro")
		auto1 = new Auto("Ford","Mustang",2000,"arg123",cat1,2.5,ubic)
	}
	
	@Test
	def void testSave(){
		
		autH.save(auto1)
		Assert.assertEquals(autH.get("arg123"),auto1)
	}
}